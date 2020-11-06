class ZCL_MATERIAL_TEXT_BACK_CUT definition
  public
  final
  create public .

public section.

  methods GET_MATERIAL_TEXT
    importing
      !IM_MATNR type MAKT-MATNR
      !IM_SPRAS type MAKT-SPRAS
    exporting
      !EX_MAKTX type MAKT-MAKTX .
protected section.
private section.

  data GD_DOA type ref to ZIF_MATERIAL_TEXT .
ENDCLASS.



CLASS ZCL_MATERIAL_TEXT_BACK_CUT IMPLEMENTATION.


  METHOD GET_MATERIAL_TEXT.
    gd_doa->get_material_text(
      EXPORTING
        im_matnr = im_matnr   " Material Number
        im_spras = im_spras   " Language Key
      IMPORTING
        ex_maktx = ex_maktx   " Material description
    ).
  ENDMETHOD.
ENDCLASS.
