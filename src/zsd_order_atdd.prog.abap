*&---------------------------------------------------------------------*
*& Report ZSD_ORDER_ATDD
*&---------------------------------------------------------------------*

REPORT zsd_order_atdd.

DATA: ls_vbak TYPE vbak.
SELECT-OPTIONS: s_vbeln FOR ls_vbak-vbeln,
                s_vkorg FOR ls_vbak-vkorg.
CLASS lcl_order DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: run.

  PRIVATE SECTION.
    METHODS get_data.
    DATA:ob_alv TYPE REF TO cl_salv_table.
ENDCLASS.
CLASS lcl_order IMPLEMENTATION.
  METHOD run.
    DATA(ob_order) = NEW lcl_order( ).
    ob_order->get_data( ).
  ENDMETHOD.
  METHOD get_data.
    DATA(lo_data) = NEW zcl_order_test_atdd( ).
    lo_data->order_data(
      EXPORTING
        im_vbeln = s_vbeln[]
        im_vkorg = s_vkorg[]
      IMPORTING
        ex_vbak  = DATA(lt_vbak) ).

    IF lt_vbak IS NOT INITIAL.
      TRY .
          cl_salv_table=>factory(
            IMPORTING
              r_salv_table   =  ob_alv
            CHANGING
              t_table        = lt_vbak ).
        CATCH cx_salv_msg. " ALV: General Error Class with Message
      ENDTRY.
      ob_alv->display( ).
    ELSE.
      MESSAGE 'No Data found' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_order=>run( ).
