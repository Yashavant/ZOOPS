*&---------------------------------------------------------------------*
*& Report ZSD_SALES_INVOICE_OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsd_sales_invoice_output.

DATA: lv_vbeln TYPE vbrk-vbeln.
SELECT-OPTIONS: s_vbeln FOR lv_vbeln NO-EXTENSION NO INTERVALS OBLIGATORY.
CLASS lcl_output DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: run.
  PRIVATE SECTION.
    METHODS display.
ENDCLASS.
CLASS lcl_output IMPLEMENTATION.
  METHOD run.
    DATA(lo_out) = NEW lcl_output( ).
    lo_out->display( ).
  ENDMETHOD.
  METHOD display.
    DATA(lo_output) = NEW zcl_sales_invoice_output( ).
    lo_output->get_invoice( im_vbeln = s_vbeln[] ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_output=>run( ).
