*&---------------------------------------------------------------------*
*& Report ZMM_MATERIAL_REPORT_REFACTOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmm_material_report_refactor.
DATA: ls_marc TYPE marc.

SELECT-OPTIONS: s_matnr FOR ls_marc-matnr,
                s_werks FOR ls_marc-werks.

PARAMETERS: rb_t  RADIOBUTTON GROUP gp1,
            rb_m  RADIOBUTTON GROUP gp1,
            rb_ts RADIOBUTTON GROUP gp1.


CLASS lcl_material DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_final,
             matnr TYPE mara-matnr,
             werks TYPE marc-werks,
             lgort TYPE mard-lgort,
             mtart TYPE mara-mtart,
             mbrsh TYPE mara-mbrsh,
             matkl TYPE mara-matkl,
             meins TYPE mara-meins,
             brgew TYPE mara-brgew,
             ntgew TYPE mara-ntgew,
             volum TYPE mara-volum,
             voleh TYPE mara-voleh,
             ekgrp TYPE marc-ekgrp,
             lfgja TYPE mard-lfgja,
             lfmon TYPE mard-lfmon,
             labst TYPE mard-labst,
           END OF ty_final.
    CLASS-METHODS: run.
  PRIVATE SECTION.
    METHODS:display_material_data.
    DATA: it_final TYPE STANDARD TABLE OF ty_final,
          ls_final TYPE ty_final.
ENDCLASS.
CLASS lcl_material IMPLEMENTATION.
  METHOD run.
    DATA(lo_mat) = NEW lcl_material( ).
    lo_mat->display_material_data( ).
  ENDMETHOD.

  METHOD display_material_data.

    CASE abap_true.
      WHEN rb_t.
        DATA(ob_testdouble) = NEW zcl_material_test( ).
        ob_testdouble->get_material_data(
          EXPORTING
            im_matnr = s_matnr[]
            im_werks = s_werks[]
          IMPORTING
            ex_final = it_final ).
      WHEN rb_m.
        DATA(ob_mock) = NEW ZCL_MATERIAL_mock( ).
        ob_mock->get_material_data(
          EXPORTING
            im_matnr = s_matnr[]
            im_werks = s_werks[]
          IMPORTING
            ex_final = it_final ).
      WHEN rb_ts.
        DATA(ob_testseam) = NEW zcl_material_testseam( ).
        ob_testseam->get_material_data(
          EXPORTING
            im_matnr = s_matnr[]
            im_werks = s_werks[]
          IMPORTING
            ex_final = it_final ).
    ENDCASE.

    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table   =  DATA(lo_alv)
          CHANGING
            t_table        = it_final
        ).
      CATCH cx_salv_msg. " ALV: General Error Class with Message
    ENDTRY.
    lo_alv->display( ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO lcl_material.
    METHODS: setup,
      test_1 FOR TESTING.
ENDCLASS.
CLASS lcl_test IMPLEMENTATION.
  METHOD setup.
    f_cut = NEW #( ).
  ENDMETHOD.
  METHOD test_1.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_material=>run( ).
