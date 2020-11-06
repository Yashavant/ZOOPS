*&---------------------------------------------------------------------*
*& Report ZSD_CUST_OPEN_ITEM_RPT
*&---------------------------------------------------------------------*
REPORT zsd_cust_open_item_rpt.
DATA: ls_bsid TYPE bsid.
SELECT-OPTIONS: s_bukrs FOR ls_bsid-bukrs no-EXTENSION no INTERVALS OBLIGATORY,
                s_kunnr FOR ls_bsid-kunnr.

CLASS lcl_customer DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:run.
  PRIVATE SECTION.
    TYPES: BEGIN OF ty_bsid,
             bukrs TYPE bsid-bukrs,
             kunnr TYPE bsid-kunnr,
             gjahr TYPE bsid-gjahr,
             belnr TYPE bsid-belnr,
             waers TYPE bsid-waers,
             shkzg TYPE bsid-shkzg,
             dmbtr TYPE bsid-dmbtr,
             wrbtr TYPE bsid-wrbtr,
           END OF ty_bsid,
           BEGIN OF ty_total,
             bukrs TYPE bsid-bukrs,
             kunnr TYPE bsid-kunnr,
             waers TYPE bsid-waers,
             dmbtr TYPE bsid-dmbtr,
             wrbtr TYPE bsid-wrbtr,
           END OF ty_total,
           BEGIN OF ty_final,
             bukrs TYPE bsid-bukrs,
             kunnr TYPE bsid-kunnr,
             name  TYPE kna1-name1,
             land1 TYPE kna1-land1,
             spras TYPE kna1-spras,
             dmbtr TYPE bsid-dmbtr,
             wrbtr TYPE bsid-wrbtr,
             waers TYPE bsid-waers,
           END OF ty_final.

    CLASS-DATA: obj_cust TYPE REF TO lcl_customer.
    DATA: lt_bsid  TYPE STANDARD TABLE OF ty_bsid,
          lt_kna1  TYPE STANDARD TABLE OF kna1,
          lt_total TYPE STANDARD TABLE OF ty_total,
          ls_total TYPE ty_total,
          lt_final TYPE STANDARD TABLE OF ty_final,
          ls_final TYPE ty_final.
    METHODS: get_data,
      data_manipulation.
    DATA: obj_alv TYPE REF TO cl_salv_table.
ENDCLASS.
CLASS lcl_customer IMPLEMENTATION.
  METHOD run.
    obj_cust = NEW #( ).
    obj_cust->get_data( ).
  ENDMETHOD.
  METHOD get_data.
    SELECT bukrs,
           kunnr,
           gjahr,
           belnr,
           waers,
           shkzg,
           dmbtr,
           wrbtr
      FROM bsid
      INTO TABLE @lt_bsid
     WHERE bukrs IN @s_bukrs
       AND kunnr IN @s_kunnr
       AND umsks = @space.

    IF lt_bsid IS NOT INITIAL.
      SELECT *
        FROM kna1
        INTO TABLE lt_kna1
         FOR ALL ENTRIES IN lt_bsid
       WHERE kunnr = lt_bsid-kunnr.
    ENDIF.
    data_manipulation( ).
  ENDMETHOD.
  METHOD data_manipulation.
    SORT lt_bsid BY kunnr.
    LOOP AT lt_bsid INTO DATA(ls_bsid).
      ls_total-bukrs = ls_bsid-bukrs.
      ls_total-kunnr = ls_bsid-kunnr.
      ls_total-waers = ls_bsid-waers.
      IF ls_bsid-shkzg = 'H'.
        ls_total-dmbtr = ls_bsid-dmbtr * -1.
        ls_total-wrbtr = ls_bsid-wrbtr * -1.
      ELSE.
        ls_total-dmbtr = ls_bsid-dmbtr.
        ls_total-wrbtr = ls_bsid-wrbtr.
      ENDIF.
      COLLECT ls_total INTO lt_total.
      CLEAR:ls_total,ls_bsid.
    ENDLOOP.
    LOOP AT lt_total INTO DATA(ls_total).
      ls_final-bukrs = ls_total-bukrs.
      ls_final-kunnr = ls_total-kunnr.
      ls_final-dmbtr = ls_total-dmbtr.
      ls_final-wrbtr = ls_total-wrbtr.
      ls_final-waers = ls_total-waers.
      IF line_exists(  lt_kna1[ kunnr = ls_total-kunnr  ] ).
        ls_final-name = lt_kna1[ kunnr = ls_total-kunnr  ]-name1.
        ls_final-land1 = lt_kna1[ kunnr = ls_total-kunnr  ]-land1.
        ls_final-spras = lt_kna1[ kunnr = ls_total-kunnr  ]-spras.
      ENDIF.
      APPEND ls_final TO lt_final.
      CLEAR: ls_final,ls_total.
    ENDLOOP.
    TRY .
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table   =  obj_alv
          CHANGING
            t_table        = lt_final
        ).
      CATCH cx_salv_msg. " ALV: General Error Class with Message
    ENDTRY.
    IF obj_alv IS NOT INITIAL.
      obj_alv->display( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_customer=>run( ).
