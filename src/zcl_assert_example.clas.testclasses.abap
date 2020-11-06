*"* use this source file for your ABAP unit test classes

CLASS lcl_Test_Assert DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO zcl_Assert_Example.  "class under test

    DATA im_String TYPE char20.
    DATA ex_String TYPE char20.

    METHODS: setup.
    METHODS: teardown.
    METHODS: get_String_inital FOR TESTING,
      get_String_not_inital FOR TESTING,
      get_String_string_pattern FOR TESTING,
      get_String_not_string_pattern FOR TESTING,
      get_String_not_DIFFERS FOR TESTING.
ENDCLASS.       "lcl_Test_Assert


CLASS lcl_Test_Assert IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT f_Cut.
  ENDMETHOD.

  METHOD teardown.
    FREE: f_Cut.
  ENDMETHOD.

  METHOD get_String_inital.
* Given
* When
    f_Cut->get_String(
      EXPORTING
        im_string = im_String
     IMPORTING
       ex_string = ex_String ).
*Then
    CL_abap_unit_assert=>assert_initial(
      EXPORTING
        act              = ex_String
        msg              =  'Value Assigned to EX_STRING').

  ENDMETHOD.

  METHOD get_String_not_inital.
* Given
    im_String = 'This is string'.

* When
    f_Cut->get_String(
      EXPORTING
        im_string = im_String
     IMPORTING
       ex_string = ex_String ).

* Then
    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act              = ex_String
        msg              =  ' Value is not assigned to EX_STRING' ).
  ENDMETHOD.

  METHOD get_String_string_pattern.
* Given
    im_String = 'Hello'.

* When
    f_Cut->get_String(
      EXPORTING
        im_string = im_String
     IMPORTING
       ex_string = ex_String ).

* Then
    cl_abap_unit_assert=>assert_char_cp(
      EXPORTING
        act              = ex_String
        exp              = 'World'
        msg              = '' ).
  ENDMETHOD.

  METHOD get_String_not_string_pattern.
* Given
    im_String = 'Welcome'.

* When
    f_Cut->get_String(
      EXPORTING
        im_string = im_String
     IMPORTING
       ex_string = ex_String ).
* Then
    cl_abap_unit_assert=>assert_char_cp(
      EXPORTING
        act              = ex_String
        exp              = 'ABAP Coding'
        msg              = '' ).
  ENDMETHOD.

  METHOD get_String_not_DIFFERS.
* Given
    im_String = 'Welcome'.

* When
    f_Cut->get_String(
      EXPORTING
        im_string = im_String
     IMPORTING
       ex_string = ex_String ).
* Then
    cl_abap_unit_assert=>assert_differs(
      EXPORTING
        act              = ex_String
        exp              = 'ABAP Codeing'
        msg              = ''
    ).
  ENDMETHOD.

ENDCLASS.
