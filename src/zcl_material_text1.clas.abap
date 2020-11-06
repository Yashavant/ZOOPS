class ZCL_MATERIAL_TEXT1 definition
  public
  final
  create public .

public section.

  interfaces ZIF_MATERIAL_TEXT1 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MATERIAL_TEXT1 IMPLEMENTATION.


  method ZIF_MATERIAL_TEXT1~GET_MATERIAL_TEXT.
    SELECT SINGLE maktx
         FROM makt
         INTO ex_maktx
        WHERE matnr = im_matnr
          AND spras = im_spras.
  endmethod.
ENDCLASS.
