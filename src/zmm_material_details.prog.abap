*&---------------------------------------------------------------------*
*& Report ZMM_MATERIAL_DETAILS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmm_material_details.

TYPES: BEGIN OF ty_mara,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
         meins TYPE mara-meins,
         werks TYPE marc-werks,
         ekgrp TYPE marc-ekgrp,
       END OF ty_mara,
       BEGIN OF ty_mbew,
         matnr TYPE mbew-matnr,
         bwkey TYPE mbew-bwkey,
         bwtar TYPE mbew-bwtar,
         lbkum TYPE mbew-lbkum,
         salk3 TYPE mbew-salk3,
         verpr TYPE mbew-verpr,
         stprs TYPE mbew-stprs,
       END OF ty_mbew.

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

DATA: ls_mara  TYPE ty_mara,
      it_mara  TYPE STANDARD TABLE OF ty_mara,
      it_mbew  TYPE STANDARD TABLE OF ty_mbew,
      ls_final TYPE ty_final,
      it_final TYPE STANDARD TABLE OF ty_final.

DATA: obj_alv TYPE REF TO cl_salv_table.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_matnr FOR ls_mara-matnr.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  SELECT m~matnr
         m~mtart
         m~matkl
         m~meins
         r~werks
         r~ekgrp
    FROM mara AS m INNER JOIN marc AS r ON m~matnr = r~matnr
    INTO TABLE it_mara
    WHERE m~matnr IN s_matnr.

  IF it_mara IS NOT INITIAL.

    SELECT matnr
           bwkey
           bwtar
           lbkum
           salk3
           verpr
           stprs
      FROM mbew
      INTO TABLE it_mbew
      FOR ALL ENTRIES IN it_mara
      WHERE matnr = it_mara-matnr
        AND bwkey = it_mara-werks.

  ENDIF. "IF it_mara IS NOT INITIAL.

END-OF-SELECTION.

  LOOP AT it_mbew INTO DATA(ls_mbew).

    ls_final-matnr = ls_mbew-matnr.
    ls_final-bwtar = ls_mbew-bwtar.
    ls_final-lbkum = ls_mbew-lbkum.
    ls_final-salk3 = ls_mbew-salk3.
    ls_final-verpr = ls_mbew-verpr.
    ls_final-stprs = ls_mbew-stprs.

    READ TABLE it_mara INTO ls_mara
                   WITH KEY matnr = ls_mbew-matnr
                            werks = ls_mbew-bwkey.
    IF sy-subrc EQ 0.
      ls_final-matnr = ls_mara-matnr .
      ls_final-mtart = ls_mara-mtart .
      ls_final-matkl = ls_mara-matkl .
      ls_final-meins = ls_mara-meins .
      ls_final-werks = ls_mara-werks .
      ls_final-ekgrp = ls_mara-ekgrp .
    ENDIF.

    APPEND ls_final TO it_final.
    CLEAR:ls_final.
  ENDLOOP.


  cl_salv_table=>factory(
    IMPORTING
      r_salv_table   = obj_alv                          " Basis Class Simple ALV Tables
    CHANGING
      t_table        = it_final
  ).

  obj_alv->display( ).
