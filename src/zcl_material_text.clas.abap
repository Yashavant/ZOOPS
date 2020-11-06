class ZCL_MATERIAL_TEXT definition
  public
  final
  create public .

public section.

  interfaces ZIF_MATERIAL_TEXT .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MATERIAL_TEXT IMPLEMENTATION.


  METHOD zif_material_text~get_material_text.
    SELECT SINGLE maktx
             FROM makt
             INTO ex_maktx
            WHERE matnr = im_matnr
              AND spras = im_spras.
  ENDMETHOD.
ENDCLASS.
