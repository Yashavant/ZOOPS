class ZCL_SALES_INVOICE_OUTPUT definition
  public
  create public .

public section.

  methods GET_INVOICE
    importing
      !IM_VBELN type ZIF_SALES_INVOICE=>R_VBELN .
  methods CALL_SMARTFORM
    importing
      !IM_FNM type RS38L_FNAM
      !IM_VBRK type ZIF_SALES_INVOICE=>TY_VBRK
      !IM_T001 type T001
      !IM_VBRP type ZIF_SALES_INVOICE=>TT_VBRP .
  methods SET_OBJECT
    exporting
      !EX_INVOICE type ref to ZCL_SALES_INVOICE_TEST .
  methods GET_MOCK_DATA
    importing
      !IM_VBELN type ZIF_SALES_INVOICE=>R_VBELN
    exporting
      !EX_VBRK type ZIF_SALES_INVOICE=>TY_VBRK
      !EX_VBRP type ZIF_SALES_INVOICE=>TT_VBRP
      !EX_T001 type T001 .
protected section.
private section.

  methods GET_SMARTFORM_FM
    importing
      !IM_FORM_NAME type TDSFNAME
    exporting
      !EX_FNM type RS38L_FNAM .
ENDCLASS.



CLASS ZCL_SALES_INVOICE_OUTPUT IMPLEMENTATION.


  METHOD call_smartform.

    CALL FUNCTION im_fnm "'/1BCDWB/SF00000045'
      EXPORTING
        im_vbrk          = im_vbrk
        im_t001          = im_t001
        im_vbrp          = im_vbrp
* IMPORTING
*       DOCUMENT_OUTPUT_INFO       =
*       JOB_OUTPUT_INFO  =
*       JOB_OUTPUT_OPTIONS         =
      EXCEPTIONS
        formatting_error = 1
        internal_error   = 2
        send_error       = 3
        user_canceled    = 4
        OTHERS           = 5.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


  ENDMETHOD.


  METHOD get_invoice.

*    set_object(
*      IMPORTING
*        ex_invoice = DATA(lo_invoice) ).
*
*    lo_invoice->get_invoice_data(
*      EXPORTING
*        im_vbeln = im_vbeln
*      IMPORTING
*        ex_vbrk  = DATA(ls_vbrk)
*        ex_vbrp  = DATA(lt_vbrp) ).
*    lo_invoice->get_company_data(
*      EXPORTING
*        im_bukrs =  ls_vbrk-bukrs
*      IMPORTING
*        ex_t001  = DATA(ls_t001) ).

    get_mock_data(
      EXPORTING
        im_vbeln = im_vbeln
      IMPORTING
        ex_vbrk  = DATA(ls_vbrk)
        ex_vbrp  = DATA(lt_vbrp)
        ex_t001  = DATA(ls_t001)                 " Company Codes
    ).

    get_smartform_fm(
      EXPORTING
        im_form_name = 'ZSD_SALES_INVOICE'
      IMPORTING
        ex_fnm       =  DATA(lv_fnm) ).

    call_smartform(
      EXPORTING
        im_fnm  = lv_fnm
        im_vbrk = ls_vbrk
        im_t001 = ls_t001
        im_vbrp = lt_vbrp ).


  ENDMETHOD.


  METHOD get_mock_data.
    set_object(
      IMPORTING
        ex_invoice = DATA(lo_invoice) ).

    lo_invoice->get_invoice_data(
      EXPORTING
        im_vbeln = im_vbeln
      IMPORTING
        ex_vbrk  = ex_vbrk
        ex_vbrp  = ex_vbrp ).
    lo_invoice->get_company_data(
      EXPORTING
        im_bukrs =  ex_vbrk-bukrs
      IMPORTING
        ex_t001  = ex_t001 ).
  ENDMETHOD.


  METHOD get_smartform_fm.

    CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
      EXPORTING
        formname           = im_form_name
      IMPORTING
        fm_name            = ex_fnm
      EXCEPTIONS
        no_form            = 1
        no_function_module = 2
        OTHERS             = 3.
    IF sy-subrc <> 0.

    ENDIF.
  ENDMETHOD.


  METHOD set_object.
    ex_invoice = NEW zcl_sales_invoice_test( ).
  ENDMETHOD.
ENDCLASS.
