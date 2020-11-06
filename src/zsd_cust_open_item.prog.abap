*&---------------------------------------------------------------------*
*& Report zsd_cust_open_item
*&---------------------------------------------------------------------*
REPORT zsd_cust_open_item.
DATA: ls_bsid TYPE bsid.
SELECT-OPTIONS:s_bukrs FOR ls_bsid-bukrs,
               s_kunnr FOR ls_bsid-kunnr.
CLASS lcl_cust DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: run.
  PRIVATE SECTION.
    METHODS:display.
    CLASS-DATA: gd_cust TYPE REF TO lcl_cust.
    DATA: gd_alv TYPE REF TO cl_salv_table.
ENDCLASS.

CLASS lcl_cust IMPLEMENTATION.

  METHOD display.
    SELECT *
    FROM zsd_cust_open_item
    INTO TABLE @DATA(lt_cust)
   WHERE bukrs IN @s_bukrs
     AND kunnr IN @s_kunnr.

    IF lt_cust IS NOT INITIAL.
      TRY.
          cl_salv_table=>factory(
            IMPORTING
              r_salv_table   = gd_alv
            CHANGING
              t_table        = lt_cust
          ).
          gd_alv->display( ).
        CATCH cx_salv_msg.
      ENDTRY.
    ELSE.
      MESSAGE 'No Data Found' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ENDMETHOD.

  METHOD run.
    gd_cust = NEW #( ).
    gd_cust->display( ).
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl_cust=>run( ).
