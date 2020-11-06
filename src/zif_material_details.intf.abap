interface ZIF_MATERIAL_DETAILS
  public .


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
    tt_mara TYPE STANDARD TABLE OF ty_mara .
  types:
    tt_mard TYPE STANDARD TABLE OF ty_mard .
  types:
    tt_mbew TYPE STANDARD TABLE OF ty_mbew .

  class-data S_MATNR type R_MATNR .

  methods GET_DATA
    importing
      !IM_MATNR type R_MATNR
    exporting
      !IT_MARA type TT_MARA
      !IT_MBEW type TT_MBEW .
endinterface.
