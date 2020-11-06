*"* use this source file for your ABAP unit test classes

CLASS lcl_Test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      f_Cut      TYPE REF TO zcl_material_testseam.  "class under test

    METHODS: setup.
    METHODS: teardown.
    METHODS: get_Material_Data FOR TESTING.
ENDCLASS.       "lcl_Test


CLASS lcl_Test IMPLEMENTATION.

  METHOD setup.

    CREATE OBJECT f_Cut.
  ENDMETHOD.

  METHOD teardown.
    FREE: f_Cut.
  ENDMETHOD.


  METHOD get_Material_Data.
* Given
    DATA im_Matnr TYPE zif_Material=>r_Matnr.
    DATA im_Werks TYPE zif_Material=>r_Werks.
    DATA: exp_Final TYPE zif_Material=>tt_Final.

    cl_apl_ecatt_tdc_api=>get_instance(
      EXPORTING
        i_testdatacontainer         = 'ZTDC_MATERIAL_DATA'
      RECEIVING
        e_tdc_ref                   = DATA(o_data) ).

    TEST-INJECTION get_data.
      cl_apl_ecatt_tdc_api=>get_instance(
        EXPORTING
          i_testdatacontainer         = 'ZTDC_MATERIAL_DATA'
        RECEIVING
          e_tdc_ref                   = DATA(o_data) ).

      o_data->get_value(
        EXPORTING
          i_param_name   = 'MARA'
          i_variant_name = 'MATERIAL_DATA'
        CHANGING
          e_param_value  = lt_mara ).

      o_data->get_value(
       EXPORTING
         i_param_name   = 'MARD'
         i_variant_name = 'MATERIAL_DATA'
       CHANGING
         e_param_value  = lt_mard ).
    END-TEST-INJECTION.

    o_data->get_value(
      EXPORTING
        i_param_name   = 'EXP'
        i_variant_name = 'MATERIAL_DATA'
      CHANGING
        e_param_value  = exp_final ).

* When
    f_Cut->get_Material_Data(
      EXPORTING
        im_matnr = im_Matnr
        im_werks = im_Werks
     IMPORTING
       ex_final = DATA(ex_Final)
    ).
* Then
    cl_Abap_Unit_Assert=>assert_Equals(
      act   = ex_Final
      exp   = exp_Final          "<--- please adapt expected value
      msg   = 'Testing value ex_Final'
*     level =
    ).
  ENDMETHOD.

ENDCLASS.
