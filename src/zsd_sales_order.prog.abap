*&---------------------------------------------------------------------*
*& Report ZSD_SALES_ORDER
*&---------------------------------------------------------------------*

REPORT zsd_sales_order.

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
    METHODS:constructor.

    DATA: it_vbak TYPE STANDARD TABLE OF ts_vbak,
          ob_alv  TYPE REF TO cl_salv_table.
ENDCLASS.
CLASS lcl_sales IMPLEMENTATION.
  METHOD constructor.

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
      INTO TABLE it_vbak
     WHERE k~vbeln IN s_vbeln
       AND p~matnr IN s_matnr.
    IF it_vbak IS NOT INITIAL.
      TRY .
          cl_salv_table=>factory(
          IMPORTING
              r_salv_table   =  ob_alv
            CHANGING
              t_table        = it_vbak
          ).
        CATCH cx_salv_msg. " ALV: General Error Class with Message
      ENDTRY.
      ob_alv->display( ).
    ELSE.
      MESSAGE 'No Data found' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA(lo_sales) = NEW lcl_sales( ).
