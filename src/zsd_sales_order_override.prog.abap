*&---------------------------------------------------------------------*
*& Report ZSD_SALES_ORDER
*&---------------------------------------------------------------------*

REPORT zsd_sales_order_override.

DATA: ls_vbap TYPE vbap.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_vbeln FOR ls_vbap-vbeln,
                  s_matnr FOR ls_vbap-matnr.
SELECTION-SCREEN END OF BLOCK b1.

CLASS lcl_sales DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF ts_vbak,
             vbeln  TYPE vbak-vbeln,
             ernam  TYPE vbak-ernam,
             vkorg  TYPE vbak-vkorg,
             vtweg  TYPE vbak-vtweg,
             posnr  TYPE vbap-posnr,
             matnr  TYPE vbap-matnr,
             meins  TYPE vbap-meins,
             netwr  TYPE vbap-netwr,
             kwmeng TYPE vbap-kwmeng,
             vrkme  TYPE vbap-vrkme,
           END OF ts_vbak.

    TYPES: r_vbeln TYPE RANGE OF vbap-vbeln,
           r_matnr TYPE RANGE OF vbap-matnr.

    METHODS:constructor IMPORTING im_vbeln TYPE r_vbeln
                                  im_matnr TYPE r_matnr.

  PRIVATE SECTION.

    TYPES: tt_vbak TYPE STANDARD TABLE OF ts_vbak.
    DATA:  ob_alv  TYPE REF TO cl_salv_table.

    METHODS: get_data IMPORTING im_vbeln TYPE r_vbeln
                                im_matnr TYPE r_matnr
                      EXPORTING ex_vbak  TYPE tt_vbak,
      display CHANGING ch_vbak TYPE tt_vbak.
ENDCLASS.
CLASS lcl_sales IMPLEMENTATION.
  METHOD constructor.

    get_data(
      EXPORTING
        im_vbeln = im_vbeln
        im_matnr = im_matnr
      IMPORTING
        ex_vbak  = DATA(lt_vbak) ).

    IF lt_vbak IS NOT INITIAL.
      display(
        CHANGING
          ch_vbak = lt_vbak ).
    ELSE.
      MESSAGE 'No Data found' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ENDMETHOD.
  METHOD get_data.
    SELECT k~vbeln
           k~ernam
           k~vkorg
           k~vtweg
           p~posnr
           p~matnr
           p~meins
           p~netwr
           p~kwmeng
           p~vrkme
      FROM vbak AS k INNER JOIN vbap AS p ON k~vbeln = p~vbeln
      INTO TABLE ex_vbak
     WHERE k~vbeln IN im_vbeln
       AND p~matnr IN im_matnr.
  ENDMETHOD.
  METHOD display.
    TRY .
        cl_salv_table=>factory(
        IMPORTING
            r_salv_table   =  ob_alv
          CHANGING
            t_table        = ch_vbak ).
      CATCH cx_salv_msg. " ALV: General Error Class with Message
    ENDTRY.
    ob_alv->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA(lo_sales) = NEW lcl_sales(
  im_vbeln = s_vbeln[]
  im_matnr = s_matnr[] ).
