*"* use this source file for your ABAP unit test classes

CLASS lcl_sales_invoice_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO zcl_Sales_Invoice_Test.  "class under test
    DATA:f_invoice TYPE REF TO zif_sales_invoice.

    METHODS: setup.
    METHODS: teardown.
    METHODS: get_invoice_data FOR TESTING.
    METHODS: get_company_details FOR TESTING.
ENDCLASS.       "lcl_Sales_Invoice_Test


CLASS lcl_Sales_Invoice_Test IMPLEMENTATION.

  METHOD setup.

    f_invoice ?= cl_abap_testdouble=>create( 'ZIF_SALES_INVOICE' ).
    CREATE OBJECT f_Cut
      EXPORTING
        im_invoice = f_invoice.

  ENDMETHOD.


  METHOD teardown.
    FREE: f_Cut, f_invoice.
  ENDMETHOD.

  METHOD get_Invoice_Data.

    DATA im_Vbeln TYPE zif_Sales_Invoice=>r_Vbeln.
    DATA ex_vbrp TYPE zif_Sales_Invoice=>tt_vbrp.
    DATA ex_vbrk TYPE zif_Sales_Invoice=>ty_vbrk.
    DATA exp_vbrp TYPE zif_Sales_Invoice=>tt_vbrp.
    DATA exp_vbrk TYPE zif_Sales_Invoice=>ty_vbrk.

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
        e_param_value  = ex_vbrk ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'VBRP'
        i_variant_name = 'INVOICE_DATA'
      CHANGING
        e_param_value  = EX_vbrp ).

    o_test->get_value(
  EXPORTING
    i_param_name   = 'VBRK'
    i_variant_name = 'INVOICE_DATA'
  CHANGING
    e_param_value  = exp_vbrk ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'VBRP'
        i_variant_name = 'INVOICE_DATA'
      CHANGING
        e_param_value  = EXp_vbrp ).

    cl_abap_testdouble=>configure_call( f_invoice )->set_parameter(
      EXPORTING
        name          = 'EX_VBRK'
        value         = ex_vbrk )->set_parameter(
      EXPORTING
        name          = 'EX_VBRP'
        value         = ex_vbrp ) .

    f_invoice->get_sales_invoice(
      EXPORTING
        im_vbeln = im_Vbeln ).

    REFRESH: ex_vbrp.
    CLEAR: ex_vbrp.

    f_Cut->get_invoice_data(
      EXPORTING
        im_vbeln = im_Vbeln
      IMPORTING
        ex_vbrk  = ex_vbrk
        ex_vbrp  = ex_vbrp ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = ex_vbrk
        exp                  = exp_vbrk
        msg                  = 'Checking Valueof EX_VBRK'
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = ex_vbrp
        exp                  = exp_vbrp
        msg                  = 'Checking Valueof EX_VBRP'
    ).

  ENDMETHOD.

  METHOD get_company_details.

    DATA im_bukrs TYPE bukrs.
    DATA ex_t001 TYPE t001.
    DATA exp_t001 TYPE t001.

    cl_apl_ecatt_tdc_api=>get_instance(
      EXPORTING
        i_testdatacontainer   = 'ZTDC_INVOICE_DATA'
      RECEIVING
        e_tdc_ref             = DATA(o_test) ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'T001'
        i_variant_name = 'INVOICE_DATA'
      CHANGING
        e_param_value  = ex_t001 ).

    o_test->get_value(
       EXPORTING
         i_param_name   = 'EXP_T001'
         i_variant_name = 'INVOICE_DATA'
       CHANGING
         e_param_value  = exp_t001 ).

    cl_abap_testdouble=>configure_call( f_invoice )->set_parameter(
      EXPORTING
        name          = 'EX_T001'
        value         = ex_t001 ) .

    f_invoice->get_company_details(
      EXPORTING
        im_bukrs = im_bukrs ).

    CLEAR: ex_t001.

    f_Cut->get_company_data(
      EXPORTING
        im_bukrs = im_bukrs
      IMPORTING
        ex_t001  = ex_t001 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = ex_t001
        exp                  = exp_t001
        msg                  = 'Checking Value of EX_T001'
    ).

  ENDMETHOD.

ENDCLASS.
