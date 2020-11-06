*"* use this source file for your ABAP unit test classes

CLASS lcl_Material_Text_Test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO zcl_Material_Text_Constr_Cut.  "class under test
    DATA f_Doa TYPE REF TO zif_Material_Text.

    METHODS: setup.
    METHODS: get_Material_Text FOR TESTING.
    METHODS: teardown.
ENDCLASS.       "lcl_Material_Text_Test


CLASS lcl_Material_Text_Test IMPLEMENTATION.

  METHOD setup.

* Narrow Casting
    f_doa ?= cl_abap_testdouble=>create(
               object_name = 'ZIF_MATERIAL_TEXT' ).
    CREATE OBJECT f_Cut
      EXPORTING
        im_doa = f_doa.
  ENDMETHOD.

  METHOD get_Material_Text.
    DATA im_Matnr TYPE matnr.
    DATA im_Spras TYPE spras.
    DATA act_Maktx TYPE maktx.
    DATA exp_Maktx TYPE maktx VALUE 'Test Material'.
* Given
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
    CLEAR act_Maktx.
    f_Cut->get_Material_Text(
      EXPORTING
        im_matnr = im_Matnr
        im_spras = im_Spras
     IMPORTING
       ex_maktx = act_Maktx
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
