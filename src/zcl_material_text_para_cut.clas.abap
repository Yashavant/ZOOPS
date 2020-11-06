class ZCL_MATERIAL_TEXT_PARA_CUT definition
  public
  final
  create public .

public section.

  methods GET_MATERIAL_TEXT
    importing
      !IM_MATNR type MAKT-MATNR
      !IM_SPRAS type MAKT-SPRAS
      !IM_DOA type ref to ZIF_MATERIAL_TEXT
    exporting
      !EX_MAKTX type MAKT-MAKTX .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MATERIAL_TEXT_PARA_CUT IMPLEMENTATION.


  METHOD get_material_text.
    im_doa->get_material_text(
      EXPORTING
        im_matnr = im_matnr   " Material Number
        im_spras = im_spras   " Language Key
      IMPORTING
        ex_maktx = ex_maktx   " Material description
    ).
  ENDMETHOD.
ENDCLASS.
