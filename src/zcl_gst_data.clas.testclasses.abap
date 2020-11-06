*"* use this source file for your ABAP unit test classes

CLASS lcl_Test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO zcl_gst_data,  "class under test
      f_doa TYPE REF TO zif_check_gst.

    METHODS: setup.
    METHODS: teardown.
    METHODS: get_gst_true FOR TESTING,
      get_gst_false FOR TESTING.
    DATA im_Lifnr TYPE lifnr.
    DATA r_Gstin TYPE abap_bool.
ENDCLASS.       "lcl_Test

CLASS lcl_Test IMPLEMENTATION.

  METHOD setup.
    f_doa ?= cl_abap_testdouble=>create( 'ZIF_CHECK_GST' ).
    CREATE OBJECT f_Cut.
    f_cut->set_doa(
        im_doa = f_doa ).
  ENDMETHOD.

  METHOD teardown.
    FREE: f_doa,f_Cut.
  ENDMETHOD.

  METHOD get_Gst_true.
* Given
    cl_abap_testdouble=>configure_call( f_doa )->returning( value = 'X' ).
    f_doa->check_gstin( im_lifnr = '' ).
* When
    r_gstin = f_Cut->get_Gst( im_Lifnr ).
* Then
    cl_Abap_Unit_Assert=>assert_true(
      EXPORTING
        act              = r_gstin
        msg              =  'Testing value r_Gst' ).

  ENDMETHOD.

  METHOD get_Gst_false.
* Given
    cl_abap_testdouble=>configure_call( f_doa )->returning( value = ' ' ).
    f_doa->check_gstin( im_lifnr = '' ).
* When
    r_gstin = f_Cut->get_Gst( im_Lifnr ).
* Then
    cl_Abap_Unit_Assert=>assert_false(
      EXPORTING
        act              = r_gstin
        msg              =  'Testing value r_Gst' ).

  ENDMETHOD.

ENDCLASS.
