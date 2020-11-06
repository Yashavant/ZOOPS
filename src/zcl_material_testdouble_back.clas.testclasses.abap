*"* use this source file for your ABAP unit test classes
CLASS lcl_material_details DEFINITION DEFERRED. "Back Door Injection
CLASS zcl_material_testdouble_back DEFINITION LOCAL FRIENDS lcl_material_details. "Back Door Injection
CLASS lcl_material_details DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut  TYPE REF TO zcl_material_testdouble_back,  "class under test
      gd_doa TYPE REF TO zif_material_details.
    METHODS: setup.
    METHODS: teardown.
    METHODS: material_test_double FOR TESTING.
ENDCLASS.       "lcl_Material_Details


CLASS lcl_material_details IMPLEMENTATION.

  METHOD setup.
    gd_doa ?= cl_abap_testdouble=>create(
               object_name = 'ZIF_MATERIAL_DETAILS' ).
    f_cut = NEW zcl_material_testdouble_back( ).
    f_cut->gd_doa = gd_doa.                "Back Door Injection

  ENDMETHOD.

  METHOD teardown.
    FREE: gd_doa,f_cut.
  ENDMETHOD.

  METHOD material_test_double.
* Given
    DATA im_matnr TYPE zcl_material_det_testdouble=>r_matnr.
    DATA: it_exp  TYPE zcl_material_det_testdouble=>tt_final,
          it_mara TYPE zcl_material_det_testdouble=>tt_mara,
          it_mbew TYPE zcl_material_det_testdouble=>tt_mbew.

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
        e_param_value  = it_mara ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'IT_MBEW'
        i_variant_name = 'VARIANT1'
      CHANGING
        e_param_value  = it_mbew ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'IT_FINAL'
        i_variant_name = 'VARIANT1'
      CHANGING
        e_param_value  = it_exp ).


    cl_abap_testdouble=>configure_call( gd_doa )->set_parameter(
      EXPORTING
        name          = 'IT_MARA'
        value         = it_mara )->set_parameter(
      EXPORTING
        name          = 'IT_MBEW'
        value         = it_mbew ) .

    gd_doa->get_data(
      EXPORTING
        im_matnr = im_matnr ).

* When
    f_cut->material_test_double(
      EXPORTING
        im_matnr = im_matnr
     IMPORTING
       it_final = DATA(it_final)
    ).
* Then
    cl_abap_unit_assert=>assert_equals(
      act   = it_final
      exp   = it_exp
      msg   = 'Testing value it_Final'
    ).
  ENDMETHOD.




ENDCLASS.
