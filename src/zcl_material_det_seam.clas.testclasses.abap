*"* use this source file for your ABAP unit test classes

CLASS lcl_material_test_seam DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO zcl_material_det_seam.  "class under test

    METHODS: setup.
    METHODS: teardown.
    METHODS: get_material_details FOR TESTING.
ENDCLASS.       "lcl_Material_Test_Seam


CLASS lcl_material_test_seam IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT f_cut.
  ENDMETHOD.


  METHOD teardown.
    FREE:f_cut.
  ENDMETHOD.


  METHOD get_material_details.

    DATA im_matnr TYPE zcl_material_det_seam=>r_matnr.
    DATA it_exp TYPE zcl_material_det_seam=>tt_final.
* Given

      cl_apl_ecatt_tdc_api=>get_instance(
        EXPORTING
          i_testdatacontainer   = 'ZTDC_MATERIAL'
        RECEIVING
          e_tdc_ref             = DATA(o_test) ).

    TEST-INJECTION get_data.
      cl_apl_ecatt_tdc_api=>get_instance(
        EXPORTING
          i_testdatacontainer   = 'ZTDC_MATERIAL'
        RECEIVING
          e_tdc_ref             = DATA(o_test) ).

      o_test->get_value(
        EXPORTING
          i_param_name   = 'IT_MARA'
          i_variant_name = 'VARIANT1'
        CHANGING
          e_param_value  = it_mara ).

      o_test->get_value(
        EXPORTING
          i_param_name   = 'IT_MBEW'
          i_variant_name = 'VARIANT1'
        CHANGING
          e_param_value  = it_mbew ).

    END-TEST-INJECTION.
    o_test->get_value(
      EXPORTING
        i_param_name   = 'IT_FINAL'
        i_variant_name = 'VARIANT1'
      CHANGING
        e_param_value  = it_exp ).
*  When
    f_cut->get_material_details(
      EXPORTING
        im_matnr = im_matnr
     IMPORTING
       it_final = DATA(it_final)
    ).
* Then
    cl_abap_unit_assert=>assert_equals(
      act   = it_final
      exp   = it_exp          "<--- please adapt expected value
      msg   = 'Testing value it_Final'
    ).
  ENDMETHOD.

ENDCLASS.
