class ZCL_MATERIAL_TEST definition
  public
  final
  create public .

public section.

  data GD_MATATERIAL type ref to ZIF_MATERIAL .

  methods CONSTRUCTOR
    importing
      !IM_MATATERIAL type ref to ZIF_MATERIAL optional .
  methods GET_MATERIAL_DATA
    importing
      !IM_MATNR type ZIF_MATERIAL=>R_MATNR
      !IM_WERKS type ZIF_MATERIAL=>R_WERKS
    exporting
      !EX_FINAL type ZIF_MATERIAL=>TT_FINAL .
protected section.
private section.

  methods PROCESS_MATERIAL_DATA
    importing
      !IM_MARA type ZIF_MATERIAL=>TT_MARA
      !IM_MARD type ZIF_MATERIAL=>TT_MARD
    exporting
      !EX_FINAL type ZIF_MATERIAL=>TT_FINAL .
ENDCLASS.



CLASS ZCL_MATERIAL_TEST IMPLEMENTATION.


  METHOD constructor.
    IF im_mataterial IS NOT INITIAL.
      gd_mataterial = im_mataterial.
    ELSE.
      gd_mataterial = NEW zcl_material( ).
    ENDIF.
  ENDMETHOD.


  METHOD get_material_data.
    gd_mataterial->get_material_data(
      EXPORTING
        im_matnr = im_matnr
        im_werks = im_werks
      IMPORTING
        ex_mard  = DATA(lt_mard)
        ex_mara  = DATA(ld_mara) ).

    process_material_data(
      EXPORTING
        im_mara  = ld_mara
        im_mard  = lt_mard
      IMPORTING
        ex_final = ex_final
    ).
  ENDMETHOD.


  METHOD process_material_data.
    DATA: ls_final TYPE zif_material=>ty_final.
    LOOP AT im_mard INTO DATA(ls_mard).
      ls_final-lgort = ls_mard-lgort.
      ls_final-lfgja = ls_mard-lfgja.
      ls_final-lfmon = ls_mard-lfmon.
      ls_final-labst = ls_mard-labst.
      READ TABLE im_mara INTO DATA(ls_mara)
                     WITH KEY matnr = ls_mard-matnr
                              werks = ls_mard-werks.
      IF sy-subrc EQ 0.
        ls_final-matnr = ls_mara-matnr.
        ls_final-mtart = ls_mara-mtart.
        ls_final-mbrsh = ls_mara-mbrsh.
        ls_final-matkl = ls_mara-matkl.
        ls_final-meins = ls_mara-meins.
        ls_final-brgew = ls_mara-brgew.
        ls_final-ntgew = ls_mara-ntgew.
        ls_final-volum = ls_mara-volum.
        ls_final-voleh = ls_mara-voleh.
        ls_final-werks = ls_mara-werks.
        ls_final-ekgrp = ls_mara-ekgrp.
      ENDIF.
      APPEND ls_final TO ex_final.
      CLEAR: ls_final.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
