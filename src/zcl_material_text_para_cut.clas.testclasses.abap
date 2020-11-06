*"* use this source file for your ABAP unit test classes

CLASS LCL_MATERIAL_TEXT_PARA_TEST DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO zcl_material_text_para_cut,  "class under test
      f_doa TYPE REF TO zif_material_text.
    METHODS: setup.
    METHODS: get_Material_Text FOR TESTING.
    METHODS: teardown.
ENDCLASS.       "lcl_Material_Text_Test


CLASS lcl_Material_Text_para_Test IMPLEMENTATION.

  METHOD setup.

    f_doa ?= cl_abap_testdouble=>create(
               object_name = 'ZIF_MATERIAL_TEXT' ).

    CREATE OBJECT f_Cut.

  ENDMETHOD.

  METHOD get_Material_Text.
* Given
    DATA im_Matnr TYPE matnr.
    DATA im_Spras TYPE spras.
    DATA act_Maktx TYPE maktx.
    DATA exp_Maktx TYPE maktx VALUE 'Test Material'.

    act_Maktx = 'Test Material'.
    cl_abap_testdouble=>configure_call( f_doa )->set_parameter(
      EXPORTING
        name          = 'EX_MAKTX'
        value         = act_Maktx ).

    f_doa->get_material_text(
      EXPORTING
        im_matnr = im_Matnr   " Material Number
        im_spras = im_Spras   " Language Key
    ).

* When
    CLEAR:act_Maktx.
    f_Cut->get_material_text(
      EXPORTING
        im_matnr = im_Matnr                 " Material Number
        im_spras = im_Spras                 " Language Key
        im_doa   =  f_doa                " Material Text
      IMPORTING
        ex_maktx =  act_Maktx                " Material description
    ).
* Then
    cl_Abap_Unit_Assert=>assert_Equals(
      act   = act_Maktx
      exp   = exp_Maktx          "<--- please adapt expected value
      msg   = 'Material text is not equal to Test Material'
*     level =
    ).
  ENDMETHOD.

  METHOD teardown.
    FREE: f_Cut,f_doa.
  ENDMETHOD.

ENDCLASS.
