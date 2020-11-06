class ZCL_MATERIAL_TEXT_BACK_CUT1 definition
  public
  final
  create public .

public section.

  class-methods GET_MATERIAL_TEXT
    importing
      !IM_MATNR type MAKT-MATNR
      !IM_SPRAS type MAKT-SPRAS
    exporting
      !EX_MAKTX type MAKT-MAKTX .
  PROTECTED SECTION.
private section.

  class-data GD_DOA type ref to ZIF_MATERIAL_TEXT1 .
ENDCLASS.



CLASS ZCL_MATERIAL_TEXT_BACK_CUT1 IMPLEMENTATION.


  METHOD get_material_text.
    gd_doa->get_material_text(
      EXPORTING
        im_matnr = im_matnr                 " Material Number
        im_spras = im_spras                  " Language Key
      IMPORTING
        ex_maktx = ex_maktx                 " Material description
    ).

*    SELECT SINGLE maktx
*             FROM makt
*             INTO ex_maktx
*            WHERE matnr = im_matnr
*              AND spras = im_spras.
  ENDMETHOD.
ENDCLASS.
