*"* use this source file for your ABAP unit test classes
CLASS lcl_material_mock DEFINITION INHERITING FROM zcl_material_det_mock.
  PUBLIC SECTION.
    METHODS:get_material REDEFINITION.
    DATA: lt_mara TYPE  zcl_material_det_mock=>tt_mara,
          lt_mbew TYPE  zcl_material_det_mock=>tt_mbew.
ENDCLASS.
CLASS lcl_material_mock IMPLEMENTATION.
  METHOD get_material.
    it_mara = lt_mara.
    it_mbew = lt_mbew.
  ENDMETHOD.
ENDCLASS.
CLASS lcl_material_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO lcl_material_mock.  "class under test

    METHODS: setup.
    METHODS: teardown.
    METHODS: material_mock FOR TESTING.
ENDCLASS.       "lcl_Material_Test

CLASS lcl_material_test IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT f_cut.
  ENDMETHOD.


  METHOD teardown.
    FREE: f_cut.
  ENDMETHOD.


  METHOD material_mock.

    DATA im_matnr TYPE zcl_material_det_mock=>r_matnr.
    DATA it_exp TYPE zcl_material_det_mock=>tt_final.

    cl_apl_ecatt_tdc_api=>get_instance(
      EXPORTING
        i_testdatacontainer   =   'ZTDC_MATERIAL'
      RECEIVING
        e_tdc_ref             = DATA(o_test) ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'IT_MARA'
        i_variant_name = 'VARIANT1'
      CHANGING
        e_param_value  = f_cut->lt_mara ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'IT_MBEW'
        i_variant_name = 'VARIANT1'
      CHANGING
        e_param_value  = f_cut->lt_mbew ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'IT_FINAL'
        i_variant_name = 'VARIANT1'
      CHANGING
        e_param_value  = it_exp ).

    f_cut->material_mock(
      EXPORTING
        im_matnr = im_matnr
     IMPORTING
       it_final = DATA(it_final)
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = it_final
      exp   = it_exp          "<--- please adapt expected value
      msg   = 'Testing value it_Final'
    ).
  ENDMETHOD.




ENDCLASS.
