class ZCL_MATERIAL_TEXT_TEST_SEAM definition
  public
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
ENDCLASS.



CLASS ZCL_MATERIAL_TEXT_TEST_SEAM IMPLEMENTATION.


  METHOD get_material_text.
    DATA(lo_mat) = NEW zcl_material_text( ).
    TEST-SEAM get_text.
      lo_mat->zif_material_text~get_material_text(
        EXPORTING
          im_matnr = im_matnr   " Material Number
          im_spras = im_spras   " Language Key
        IMPORTING
          ex_maktx = ex_maktx   " Material description
      ).
    END-TEST-SEAM.
  ENDMETHOD.
ENDCLASS.
