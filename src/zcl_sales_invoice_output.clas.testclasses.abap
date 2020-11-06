*"* use this source file for your ABAP unit test classes

CLASS lcl_sales_invoice_output_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
.
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO zcl_Sales_Invoice_Output.  "class under test

    METHODS: setup.
    METHODS: teardown.
    METHODS: set_object FOR TESTING.
ENDCLASS.       "lcl_Sales_Invoice_Output_Test


CLASS lcl_Sales_Invoice_Output_Test IMPLEMENTATION.

  METHOD setup.

    CREATE OBJECT f_Cut.
  ENDMETHOD.


  METHOD teardown.
    FREE: f_Cut.
  ENDMETHOD.


  METHOD set_Object.
*Given
    DATA ex_Invoice TYPE REF TO zcl_Sales_Invoice_Test.

*when
    f_Cut->set_Object(
     IMPORTING
       ex_invoice = ex_Invoice
    ).

*Then
    cl_Abap_Unit_Assert=>assert_bound(
      EXPORTING
        act              = ex_Invoice
        msg              = 'Object is invalid'
    ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_invoice_mock DEFINITION INHERITING FROM zcl_sales_invoice_output.
  PUBLIC SECTION.
    METHODS: get_mock_data REDEFINITION.
    DATA: ls_vbrk TYPE zif_sales_invoice=>ty_vbrk,
          lt_vbrp TYPE zif_sales_invoice=>Tt_VBRp,
          ls_t001 TYPE t001.
ENDCLASS.
CLASS lcl_invoice_mock IMPLEMENTATION.
  METHOD get_mock_data.
    ex_vbrk = ls_vbrk.
    ex_vbrp = lt_vbrp.
    ex_t001 = ls_t001.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_sales_invoice_output_mock DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO lcl_invoice_mock.  "class under test

    METHODS: setup.
    METHODS: teardown.
    METHODS: get_invoice FOR TESTING.
ENDCLASS.       "lcl_Sales_Invoice_Output_Test

CLASS lcl_Sales_Invoice_Output_mock IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT f_Cut.
  ENDMETHOD.


  METHOD teardown.
    FREE: f_Cut.
  ENDMETHOD.

  METHOD get_invoice.
* Given
    DATA: im_vbeln TYPE zif_sales_invoice=>r_vbeln.

    cl_apl_ecatt_tdc_api=>get_instance(
      EXPORTING
        i_testdatacontainer   = 'ZTDC_INVOICE_DATA'
      RECEIVING
        e_tdc_ref             = DATA(o_test) ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'VBRK'
        i_variant_name = 'INVOICE_DATA'
      CHANGING
        e_param_value  = f_Cut->ls_vbrk ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'VBRP'
        i_variant_name = 'INVOICE_DATA'
      CHANGING
        e_param_value  = f_Cut->lt_vbrp ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'T001'
        i_variant_name = 'INVOICE_DATA'
      CHANGING
        e_param_value  = f_Cut->ls_t001 ).
* When
    f_Cut->get_invoice( im_vbeln = im_vbeln ).
* Then
    cl_Abap_Unit_Assert=>assert_subrc(
      EXPORTING
        exp              = 0
        act              = sy-subrc
        msg              = 'Return code is not Zero'
    ).
  ENDMETHOD.
ENDCLASS.
