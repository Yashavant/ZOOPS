class ZCL_MATERIAL_TEXT_SETTER_CUT definition
  public
  final
  create public .

public section.

  data GD_DOA type ref to ZIF_MATERIAL_TEXT .

  methods GET_MATERIAL_TEXT
    importing
      !IM_MATNR type MAKT-MATNR
      !IM_SPRAS type MAKT-SPRAS
    exporting
      !EX_MAKTX type MAKT-MAKTX .
  methods SET_OBJECT
    importing
      !IM_DOA type ref to ZIF_MATERIAL_TEXT optional .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MATERIAL_TEXT_SETTER_CUT IMPLEMENTATION.


  METHOD GET_MATERIAL_TEXT.
    gd_doa->get_material_text(
      EXPORTING
        im_matnr = im_matnr   " Material Number
        im_spras = im_spras   " Language Key
      IMPORTING
        ex_maktx = ex_maktx   " Material description
    ).
  ENDMETHOD.


  METHOD set_object.
    IF im_doa IS NOT INITIAL.
      gd_doa = im_doa.
    ELSE.
      gd_doa = NEW zcl_material_text( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
