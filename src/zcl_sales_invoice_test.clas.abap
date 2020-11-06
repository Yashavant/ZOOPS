class ZCL_SALES_INVOICE_TEST definition
  public
  final
  create public .

public section.

  data GD_INVOICE type ref to ZIF_SALES_INVOICE .

  methods CONSTRUCTOR
    importing
      !IM_INVOICE type ref to ZIF_SALES_INVOICE optional .
  methods GET_INVOICE_DATA
    importing
      !IM_VBELN type ZIF_SALES_INVOICE=>R_VBELN
    exporting
      !EX_VBRK type ZIF_SALES_INVOICE=>TY_VBRK
      !EX_VBRP type ZIF_SALES_INVOICE=>TT_VBRP .
  methods GET_COMPANY_DATA
    importing
      !IM_BUKRS type BUKRS
    exporting
      !EX_T001 type T001 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SALES_INVOICE_TEST IMPLEMENTATION.


  METHOD constructor.
    IF im_invoice IS NOT INITIAL.
      gd_invoice = im_invoice.
    ELSE.
      gd_invoice = NEW zcl_sales_invoice( ).
    ENDIF.
  ENDMETHOD.


  METHOD get_company_data.
    gd_invoice->get_company_details(
      EXPORTING
        im_bukrs = im_bukrs
      IMPORTING
        ex_t001  = ex_t001 ).
  ENDMETHOD.


  METHOD get_invoice_data.
    gd_invoice->get_sales_invoice(
      EXPORTING
        im_vbeln = im_vbeln
      IMPORTING
        ex_vbrp  = ex_vbrp
        ex_vbrk  = ex_vbrk
    ).
  ENDMETHOD.
ENDCLASS.
