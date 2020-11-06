*"* use this source file for your ABAP unit test classes

CLASS lcl_material_text_Normal_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO zcl_material_text_normal.  "class under test
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_Material_Text FOR TESTING.
ENDCLASS.       "lcl_Material_Text_Test


CLASS lcl_material_text_Normal_test IMPLEMENTATION.

  METHOD setup.

    CREATE OBJECT f_Cut.

  ENDMETHOD.

  METHOD teardown.
    FREE: f_Cut.
  ENDMETHOD.

  METHOD get_Material_Text.
* Given
    DATA im_Matnr TYPE matnr VALUE 'EWMS4-01'.
    DATA im_Spras TYPE spras VALUE 'E'.
    DATA act_Maktx TYPE maktx.
    DATA exp_Maktx TYPE maktx VALUE 'Small Part, Slow-Moving Item'.

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
