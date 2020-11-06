*&---------------------------------------------------------------------*
*& Report ZSD_CUSTOMER_DETAILS_REFACTOR
*&---------------------------------------------------------------------*
REPORT zsd_customer_details_refactor.

DATA: ls_bsid TYPE bsid.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_bukrs FOR ls_bsid-bukrs,
                  s_kunnr FOR ls_bsid-kunnr.
  PARAMETERS: rb_t  RADIOBUTTON GROUP gp1,
              rb_m  RADIOBUTTON GROUP gp1,
              rb_ts RADIOBUTTON GROUP gp1.
SELECTION-SCREEN END OF BLOCK b1.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_final,
             bukrs TYPE bsid-bukrs,
             kunnr TYPE bsid-kunnr,
             name  TYPE kna1-name1,
             land1 TYPE kna1-land1,
             spras TYPE kna1-spras,
             dmbtr TYPE bsid-dmbtr,
             wrbtr TYPE bsid-wrbtr,
             waers TYPE bsid-waers,
           END OF ty_final.
    CLASS-METHODS: run.

  PRIVATE SECTION.
    CLASS-DATA: lo_main TYPE REF TO lcl_main.
    DATA: lo_alv   TYPE REF TO cl_salv_table,
          it_final TYPE STANDARD TABLE OF ty_final.
    METHODS:display_data.
ENDCLASS.
CLASS lcl_main IMPLEMENTATION.
  METHOD run.
    lo_main = NEW lcl_main( ).
    lo_main->display_data( ).
  ENDMETHOD.
  METHOD display_data.
    CASE abap_true.
      WHEN rb_t.
        DATA(ob_testdouble) = NEW zcl_customer_testdouble( ).
        ob_testdouble->get_data(
          EXPORTING
            r_kunnr  = s_kunnr[]
            r_bukrs  = s_bukrs[]
          IMPORTING
            it_final = it_final
        ).
      WHEN rb_m.
        DATA(ob_mock) = NEW zcl_customer_mock( ).
        ob_mock->get_data(
          EXPORTING
            r_kunnr  = s_kunnr[]
            r_bukrs  = s_bukrs[]
          IMPORTING
            it_final = it_final
        ).
      WHEN rb_ts.
        DATA(ob_testseam) = NEW zcl_customer_test_seam( ).
        ob_testseam->get_data(
          EXPORTING
            r_kunnr  = s_kunnr[]
            r_bukrs  = s_bukrs[]
          IMPORTING
            it_final = it_final
        ).
    ENDCASE.

    cl_salv_table=>factory(
      IMPORTING
        r_salv_table   =  lo_alv
      CHANGING
        t_table        = it_final
    ).

    lo_alv->display( ).

    REFRESH: it_final.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  lcl_main=>run( ).
