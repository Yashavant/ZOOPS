*&---------------------------------------------------------------------*
*& Report ZDEBUG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdebug.
DATA: gd_kunnr TYPE kna1-kunnr.

SELECT-OPTIONS: s_kunnr FOR gd_kunnr.

CLASS lcl_debug DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: run.
  PRIVATE SECTION.
    TYPES: BEGIN OF ts_kna1,
             kunnr TYPE kna1-kunnr,
             land1 TYPE kna1-land1,
             name1 TYPE kna1-name1,
             ort01 TYPE kna1-ort01,
           END OF ts_kna1.

    DATA: it_kna1 TYPE STANDARD TABLE OF ts_kna1.
    METHODS: get_customer_data,
      Display_customer.
ENDCLASS.
CLASS lcl_debug IMPLEMENTATION.
  METHOD run.
    DATA(lo_obj) = NEW lcl_debug( ).
    lo_obj->get_customer_data( ).
    lo_obj->Display_customer( ).
  ENDMETHOD.
  METHOD get_customer_data.

    BREAK sapdev30.

    SELECT kunnr
           land1
           name1
           ort01
      FROM kna1
      INTO TABLE it_kna1
      WHERE kunnr IN s_kunnr.

  ENDMETHOD.
  METHOD Display_customer.
    LOOP AT it_kna1 INTO DATA(ls_kna1).
      WRITE:/ ls_kna1-kunnr, ls_kna1-land1, ls_kna1-name1, ls_kna1-ort01.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_debug=>run( ).
