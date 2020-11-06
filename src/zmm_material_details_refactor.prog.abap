*&---------------------------------------------------------------------*
*& Report ZMM_MATERIAL_DETAILS
*&---------------------------------------------------------------------*
REPORT zmm_material_details_refactor.

DATA: lv_matnr TYPE matnr.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_matnr FOR lv_matnr.
  PARAMETERS: rb_t  RADIOBUTTON GROUP gp1,
              rb_m  RADIOBUTTON GROUP gp1,
              rb_ts RADIOBUTTON GROUP gp1.
SELECTION-SCREEN END OF BLOCK b1.

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_final,
             matnr TYPE mara-matnr,
             mtart TYPE mara-mtart,
             matkl TYPE mara-matkl,
             meins TYPE mara-meins,
             werks TYPE marc-werks,
             ekgrp TYPE marc-ekgrp,
             lgort TYPE mard-lgort,
             labst TYPE mard-labst,
             bwtar TYPE mbew-bwtar,
             lbkum TYPE mbew-lbkum,
             salk3 TYPE mbew-salk3,
             verpr TYPE mbew-verpr,
             stprs TYPE mbew-stprs,
           END OF ty_final.
    CLASS-METHODS: run.

  PRIVATE SECTION.
    CLASS-DATA: lo_main TYPE REF TO lcl_main.
    DATA: lo_alv   TYPE REF TO cl_salv_table,
          it_final TYPE STANDARD TABLE OF ty_final..
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
        DATA(ob_testdouble) = NEW zcl_material_det_testdouble( ).
        ob_testdouble->material_test_double(
          EXPORTING
            im_matnr = s_matnr[]
          IMPORTING
            it_final = it_final
        ).
      WHEN rb_m.
        DATA(ob_mock) = NEW zcl_material_det_mock( ).
        ob_mock->material_mock(
          EXPORTING
            im_matnr = s_matnr[]
          IMPORTING
            it_final = it_final
        ).
      WHEN rb_ts.
        DATA(ob_testseam) = NEW zcl_material_det_seam( ).
        ob_testseam->get_material_details(
          EXPORTING
            im_matnr = s_matnr[]
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
