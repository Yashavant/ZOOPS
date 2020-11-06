*&---------------------------------------------------------------------*
*& Report ZSD_INVOICE_PRINTING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsd_invoice_printing.

DATA: wa_vbrk TYPE  zif_sales_invoice=>ty_vbrk,
      wa_t001 TYPE  t001,
      it_vbrp TYPE  zif_sales_invoice=>tt_vbrp.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_vbeln TYPE vbrk-vbeln.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
  PERFORM get_data.

END-OF-SELECTION.

  PERFORM print_data.

*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*

FORM get_data .
  SELECT SINGLE vbeln
                fkart
                waerk
                vkorg
                vtweg
                inco1
                inco2
                zterm
                zlsch
                bukrs
                kunrg
                kunag
           FROM vbrk
           INTO wa_vbrk
          WHERE vbeln = p_vbeln.
  IF wa_vbrk IS NOT INITIAL.
    SELECT vbeln
           posnr
           fkimg
           vrkme
           meins
           fklmg
           netwr
           matnr
           arktx
           werks
           waerk
      FROM vbrp
      INTO TABLE it_vbrp
     WHERE vbeln = wa_vbrk-vbeln.

    SELECT SINGLE *
             FROM t001
             INTO wa_t001
            WHERE bukrs = wa_vbrk-bukrs.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form print_data
*&---------------------------------------------------------------------*

FORM print_data .

  DATA: lv_fnam TYPE rs38l_fnam.
  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname           = 'ZSD_SALES_INVOICE'
    IMPORTING
      fm_name            = lv_fnam
    EXCEPTIONS
      no_form            = 1
      no_function_module = 2
      OTHERS             = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  CALL FUNCTION lv_fnam
    EXPORTING
      im_vbrk          = wa_vbrk
      im_t001          = wa_t001
      im_vbrp          = it_vbrp
    EXCEPTIONS
      formatting_error = 1
      internal_error   = 2
      send_error       = 3
      user_canceled    = 4
      OTHERS           = 5.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
