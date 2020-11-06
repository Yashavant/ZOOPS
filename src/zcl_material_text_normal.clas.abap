CLASS zcl_material_text_normal DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_material_text
      IMPORTING
        !im_matnr TYPE makt-matnr
        !im_spras TYPE makt-spras
      EXPORTING
        !ex_maktx TYPE makt-maktx .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MATERIAL_TEXT_NORMAL IMPLEMENTATION.


  METHOD get_material_text.
    SELECT SINGLE maktx
             FROM makt
             INTO ex_maktx
            WHERE matnr = im_matnr
              AND spras = im_spras.
  ENDMETHOD.
ENDCLASS.
