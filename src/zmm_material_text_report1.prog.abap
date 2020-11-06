*&---------------------------------------------------------------------*
*& Report ZMM_MATERIAL_REPORT_REFACTOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmm_material_text_report1.

DATA: ls_makt TYPE makt.

SELECT-OPTIONS: s_matnr FOR ls_makt-matnr NO-EXTENSION NO INTERVALS OBLIGATORY,
                s_spras FOR ls_makt-spras NO-EXTENSION NO INTERVALS OBLIGATORY.

PARAMETERS: rb_C RADIOBUTTON GROUP gp1, " Constrcutor Injection
            rb_S RADIOBUTTON GROUP gp1, " Setter Injection
            rb_P RADIOBUTTON GROUP gp1,  " Parameter Injection
            rb_B RADIOBUTTON GROUP gp1.  " Backdoor Injection

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
      WHEN rb_C.
        DATA(obj_constructor) = NEW zcl_material_text_constr_cut1( ).
        obj_constructor->get_material_text(
          EXPORTING
            im_matnr = s_matnr-low " Material Number
            im_spras = s_spras-low " Language Key
          IMPORTING
            ex_maktx = lv_maktx    " Material description
        ).
      WHEN rb_S.
        DATA(obj_setter) = NEW zcl_material_text_setter_cut1( ).
        obj_setter->set_object(
            im_doa = NEW zcl_material_text1( ) ).
        obj_setter->get_material_text(
          EXPORTING
            im_matnr = s_matnr-low " Material Number
            im_spras = s_spras-low " Language Key
          IMPORTING
            ex_maktx = lv_maktx                 " Material description
        ).
      WHEN rb_P.
        DATA(obj_parameter) = NEW zcl_material_text_para_cut1( ).
        obj_parameter->get_material_text(
          EXPORTING
            im_matnr = s_matnr-low                 " Material Number
            im_spras = s_spras-low                 " Language Key
            im_doa   = NEW zcl_material_text1( )   " Material Text
          IMPORTING
            ex_maktx = lv_maktx                 " Material description
        ).
      WHEN rb_B.
*        CLASS lcl_backdoor DEFINITION DEFERRED.

        DATA(obj_backdoor) = NEW zcl_material_text_back_cut1( ).

*        obj_backdoor->get_material_text(
*          EXPORTING
*            im_matnr = s_matnr-low " Material Number
*            im_spras = s_spras-low " Language Key
*          IMPORTING
*            ex_maktx = lv_maktx                 " Material description
*        ).
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
