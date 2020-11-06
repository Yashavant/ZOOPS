*&---------------------------------------------------------------------*
*& Report ZMM_PO_DETAILS
*&---------------------------------------------------------------------*

REPORT zmm_po_details.
DATA: lv_matnr TYPE matnr.
SELECT-OPTIONS: s_matnr FOR lv_matnr.
CLASS lcl_po DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:run.
  PRIVATE SECTION.
    METHODS: display.
    CLASS-DATA: gd_po  TYPE REF TO lcl_po,
                gd_alv TYPE REF TO cl_salv_table.
ENDCLASS.
CLASS lcl_po IMPLEMENTATION.
  METHOD run.
    gd_po = NEW #( ).
    gd_po->display( ).
  ENDMETHOD.
  METHOD display.
    SELECT *
      FROM zpohead
      INTO TABLE @DATA(lt_po)
      WHERE matnr IN @s_matnr.
    IF lt_po IS NOT INITIAL.
      TRY .
          cl_salv_table=>factory(
            IMPORTING
              r_salv_table   = gd_alv                         " Basis Class Simple ALV Tables
            CHANGING
              t_table        = lt_po
          ).
        CATCH cx_salv_msg. " ALV: General Error Class with Message
      ENDTRY.
      gd_alv->display( ).
    ELSE.
      MESSAGE 'Not Data Found' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF. "IF lt_po IS NOT INITIAL.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_po=>run( ).
