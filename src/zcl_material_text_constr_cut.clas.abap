class ZCL_MATERIAL_TEXT_CONSTR_CUT definition
  public
  final
  create public .

public section.

  data GD_DOA type ref to ZIF_MATERIAL_TEXT .

  methods CONSTRUCTOR
    importing
      !IM_DOA type ref to ZIF_MATERIAL_TEXT optional .
  methods GET_MATERIAL_TEXT
    importing
      !IM_MATNR type MAKT-MATNR
      !IM_SPRAS type MAKT-SPRAS
    exporting
      !EX_MAKTX type MAKT-MAKTX .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MATERIAL_TEXT_CONSTR_CUT IMPLEMENTATION.


  METHOD constructor.
    IF im_doa IS NOT INITIAL.
      gd_doa  = im_doa.
    ELSE.
      gd_doa = NEW zcl_material_text( ).
    ENDIF.
  ENDMETHOD.


  METHOD get_material_text.
    gd_doa->get_material_text(
      EXPORTING
        im_matnr = im_matnr   " Material Number
        im_spras = im_spras   " Language Key
      IMPORTING
        ex_maktx = ex_maktx   " Material description
    ).
  ENDMETHOD.
ENDCLASS.
