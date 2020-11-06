*&---------------------------------------------------------------------*
*& Report ZSD_SALES_ORDER
*&---------------------------------------------------------------------*

REPORT zsd_sales_order_interface.

DATA: ls_vbap TYPE vbap.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_vbeln FOR ls_vbap-vbeln,
                  s_matnr FOR ls_vbap-matnr.
SELECTION-SCREEN END OF BLOCK b1.

CLASS lcl_sales DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:call_alv IMPORTING im_order TYPE REF TO zif_sales_order.
ENDCLASS.
CLASS lcl_sales IMPLEMENTATION.

  METHOD call_alv.
    im_order->get_data(
      EXPORTING
        im_vbeln = s_vbeln[]
        im_matnr = s_matnr[]
      IMPORTING
        ex_vbak  = DATA(lt_vbak) ).
    im_order->display(
      CHANGING
        ch_vbak = lt_vbak ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  lcl_sales=>call_alv( im_order = NEW zcl_sales_order( ) ).
