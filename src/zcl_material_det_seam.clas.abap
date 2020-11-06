class ZCL_MATERIAL_DET_SEAM definition
  public
  final
  create public .

public section.

  types:
    r_matnr TYPE RANGE OF matnr .
  types:
    BEGIN OF ty_mara,
      matnr TYPE mara-matnr,
      mtart TYPE mara-mtart,
      matkl TYPE mara-matkl,
      meins TYPE mara-meins,
      werks TYPE marc-werks,
      ekgrp TYPE marc-ekgrp,
    END OF ty_mara .
  types:
    BEGIN OF ty_mard,
      matnr TYPE mard-matnr,
      werks TYPE mard-werks,
      lgort TYPE mard-lgort,
      labst TYPE mard-labst,
    END OF ty_mard .
  types:
    BEGIN OF ty_mbew,
      matnr TYPE mbew-matnr,
      bwkey TYPE mbew-bwkey,
      bwtar TYPE mbew-bwtar,
      lbkum TYPE mbew-lbkum,
      salk3 TYPE mbew-salk3,
      verpr TYPE mbew-verpr,
      stprs TYPE mbew-stprs,
    END OF ty_mbew .
  types:
    BEGIN OF ty_final,
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
         END OF ty_final .
  types:
    tt_mara TYPE STANDARD TABLE OF ty_mara .
  types:
    tt_mard TYPE STANDARD TABLE OF ty_mard .
  types:
    tt_mbew TYPE STANDARD TABLE OF ty_mbew .
  types:
    tt_final TYPE STANDARD TABLE OF ty_final .

  methods GET_MATERIAL_DETAILS
    importing
      !IM_MATNR type R_MATNR
    exporting
      !IT_FINAL type TT_FINAL .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MATERIAL_DET_SEAM IMPLEMENTATION.


  METHOD get_material_details.
    DATA: it_mara TYPE tt_mara,
          it_mbew TYPE tt_mbew.
    DATA: ls_final TYPE ty_final.
    DATA(lo_mat) = NEW zcl_material_details( ).
    TEST-SEAM get_data.
    lo_mat->zif_material_details~get_data(
      EXPORTING
        im_matnr = im_matnr
      IMPORTING
        it_mara  = it_mara
        it_mbew  = it_mbew ).

    END-TEST-SEAM.
    LOOP AT it_mbew INTO DATA(ls_mbew).

      ls_final-matnr = ls_mbew-matnr.
      ls_final-bwtar = ls_mbew-bwtar.
      ls_final-lbkum = ls_mbew-lbkum.
      ls_final-salk3 = ls_mbew-salk3.
      ls_final-verpr = ls_mbew-verpr.
      ls_final-stprs = ls_mbew-stprs.

      READ TABLE it_mara INTO DATA(ls_mara)
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
  ENDMETHOD.
ENDCLASS.
