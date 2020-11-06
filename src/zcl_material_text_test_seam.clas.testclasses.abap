*"* use this source file for your ABAP unit test classes

CLASS lcl_Material_Text_test_seam DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO zcl_material_text_test_seam.  "class under test
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_Material_Text FOR TESTING.
ENDCLASS.       "lcl_Material_Text_Test


CLASS lcl_Material_Text_test_seam IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT f_Cut.
  ENDMETHOD.

  METHOD teardown.
    FREE: f_Cut.
  ENDMETHOD.

  METHOD get_Material_Text.
* Given
    DATA im_Matnr TYPE matnr.
    DATA im_Spras TYPE spras.
    DATA act_Maktx TYPE maktx.
    DATA exp_Maktx TYPE maktx VALUE 'Test Material'.

    TEST-INJECTION get_text.
      ex_maktx = 'Test Material'.
    END-TEST-INJECTION.
* When
    CLEAR:act_Maktx.
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
      msg   = 'Testing value ex_Maktx'
*     level =
    ).
  ENDMETHOD.
ENDCLASS.
