*"* use this source file for your ABAP unit test classes
* Backdoor Injection
CLASS lcl_material_text_back_test1 DEFINITION DEFERRED.
CLASS zcl_material_text_back_cut1 DEFINITION LOCAL FRIENDS lcl_material_text_back_test1.

CLASS lcl_material_text_back_test1 DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA: f_doa TYPE REF TO zif_material_text1.
    METHODS: setup.
    METHODS: get_Material_Text FOR TESTING.
    METHODS: teardown.
ENDCLASS.       "lcl_Material_Text_Test


CLASS lcl_material_text_back_test1 IMPLEMENTATION.

  METHOD setup.
    f_doa ?= cl_abap_testdouble=>create( 'ZIF_MATERIAL_TEXT1' ).

    zcl_material_text_back_cut1=>gd_doa =  f_doa.
  ENDMETHOD.

  METHOD get_Material_Text.
* Given
    DATA im_Matnr TYPE matnr VALUE 'EWMS4-01'.
    DATA im_Spras TYPE spras VALUE 'E'.
    DATA act_Maktx TYPE maktx.
    DATA exp_Maktx TYPE maktx VALUE 'Small Part, Slow-Moving Item'.
    act_Maktx = 'Small Part, Slow-Moving Item'.

    cl_abap_testdouble=>configure_call( f_doa )->set_parameter(
      EXPORTING
        name          = 'EX_MAKTX'
        value         = act_Maktx ).

    f_doa->get_material_text(
      EXPORTING
        im_matnr = im_Matnr                 " Material Number
        im_spras = im_Spras  ).              " Language Key

* When
    CLEAR:act_Maktx.
    zcl_material_text_back_cut1=>get_material_text(
      EXPORTING
        im_matnr = im_Matnr           " Material Number
        im_spras = im_Spras           " Language Key
      IMPORTING
        ex_maktx =  act_Maktx         " Material description
    ).

* Then
    cl_Abap_Unit_Assert=>assert_Equals(
      act   = act_Maktx
      exp   = exp_Maktx          "<--- please adapt expected value
      msg   = 'Actual and Expected values are not correct'
*     level =
    ).
  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.

ENDCLASS.
