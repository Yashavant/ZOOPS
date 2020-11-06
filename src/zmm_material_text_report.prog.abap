*&---------------------------------------------------------------------*
*& Report ZMM_MATERIAL_REPORT_REFACTOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmm_material_text_report.
DATA: ls_makt TYPE makt.

SELECT-OPTIONS: s_matnr FOR ls_makt-matnr NO-EXTENSION NO INTERVALS OBLIGATORY,
                s_spras FOR ls_makt-spras NO-EXTENSION NO INTERVALS OBLIGATORY.

PARAMETERS: rb_t  RADIOBUTTON GROUP gp1,
            rb_m  RADIOBUTTON GROUP gp1,
            rb_ts RADIOBUTTON GROUP gp1.


CLASS lcl_material_text DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: run.
  PRIVATE SECTION.
    METHODS:display_material_text.
    DATA: lv_maktx TYPE makt-maktx.
ENDCLASS.
CLASS lcl_material_text IMPLEMENTATION.
  METHOD run.
    DATA(lo_mat) = NEW lcl_material_text( ).
    lo_mat->display_material_text( ).
  ENDMETHOD.

  METHOD display_material_text.

    CASE abap_true.
      WHEN rb_t.
        DATA(ob_testdouble) = NEW zcl_material_text_constr_cut( ).
        ob_testdouble->get_material_text(
          EXPORTING
            im_matnr = s_matnr-low " Material Number
            im_spras = s_spras-low " Language Key
          IMPORTING
            ex_maktx = lv_maktx                 " Material description
        )..
      WHEN rb_m.
        DATA(ob_mock) = NEW zcl_material_text_mock( ).
        ob_mock->get_material_text(
          EXPORTING
            im_matnr = s_matnr-low  " Material Number
            im_spras = s_spras-low  " Language Key
          IMPORTING
            ex_maktx =  lv_maktx                " Material description
        ).
      WHEN rb_ts.
        DATA(ob_testseam) = NEW zcl_material_text_test_seam( ).
        ob_testseam->get_material_text(
          EXPORTING
            im_matnr = s_matnr-low  " Material Number
            im_spras = s_spras-low  " Language Key
          IMPORTING
            ex_maktx =  lv_maktx                " Material description
        ).
    ENDCASE.

    IF lv_maktx IS NOT INITIAL.
      WRITE: 'Material: ' , s_matnr-low ,' Description: ', lv_maktx.
    ELSE.
      MESSAGE 'No Data found' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_material_text=>run( ).
