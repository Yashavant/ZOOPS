INTERFACE zif_material
  PUBLIC .


  TYPES:
    r_matnr TYPE RANGE OF matnr .
  TYPES:
    r_werks TYPE RANGE OF werks_d .
  TYPES:
    BEGIN OF ty_mara,
      matnr TYPE mara-matnr,
      mtart TYPE mara-mtart,
      mbrsh TYPE mara-mbrsh,
      matkl TYPE mara-matkl,
      meins TYPE mara-meins,
      brgew TYPE mara-brgew,
      ntgew TYPE mara-ntgew,
      volum TYPE mara-volum,
      voleh TYPE mara-voleh,
      werks TYPE marc-werks,
      ekgrp TYPE marc-ekgrp,
    END OF ty_mara .
  TYPES:
    BEGIN OF ty_mard,
      matnr TYPE mard-matnr,
      werks TYPE mard-werks,
      lgort TYPE mard-lgort,
      lfgja TYPE mard-lfgja,
      lfmon TYPE mard-lfmon,
      labst TYPE mard-labst,
    END OF ty_mard .
  TYPES:
    BEGIN OF ty_final,
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
    END OF ty_final .
  TYPES:
    tt_mara TYPE STANDARD TABLE OF ty_mara .
  TYPES:
    tt_mard TYPE STANDARD TABLE OF ty_mard .
  TYPES:
    tt_final TYPE STANDARD TABLE OF ty_final .

  METHODS get_material_data
    IMPORTING
      !im_matnr TYPE r_matnr
      !im_werks TYPE r_werks
    EXPORTING
      !ex_mard  TYPE tt_mard
      !ex_mara  TYPE tt_mara .
ENDINTERFACE.
