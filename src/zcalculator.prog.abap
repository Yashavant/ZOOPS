*&---------------------------------------------------------------------*
*& Report ZCALCULATOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcalculator.

CLASS lcl_calculator DEFINITION.
  PUBLIC SECTION.
    METHODS add
      IMPORTING
        i_a           TYPE i
        i_b           TYPE i
      RETURNING
        VALUE(result) TYPE i.
    METHODS sub
      IMPORTING
        i_a           TYPE i
        i_b           TYPE i
      RETURNING
        VALUE(result) TYPE i.
    METHODS mult
      IMPORTING
        i_a           TYPE i
        i_b           TYPE i
      RETURNING
        VALUE(result) TYPE i.
    METHODS div
      IMPORTING
        i_a           TYPE i
        i_b           TYPE i
      RETURNING
        VALUE(result) TYPE i.
ENDCLASS.

CLASS lcl_calculator IMPLEMENTATION.
  METHOD add.
    result = i_a + i_b.
  ENDMETHOD.

  METHOD sub.
    result = i_a - i_b.
  ENDMETHOD.

  METHOD mult.
    result = i_a * i_b.
  ENDMETHOD.
  METHOD div.
    result = i_a / i_b.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_Calculator_Test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.

    DATA i_A TYPE i.
    DATA i_B TYPE i.
    DATA result TYPE i.
    DATA exp TYPE i.

    DATA:
      f_Cut TYPE REF TO lcl_calculator.  "class under test

    METHODS: setup.
    METHODS: add FOR TESTING.
    METHODS: sub FOR TESTING.
    METHODS: mult FOR TESTING.
    METHODS: div FOR TESTING.
    METHODS: teardown.
ENDCLASS.       "lcl_Calculator_Test

CLASS lcl_Calculator_Test IMPLEMENTATION.
  METHOD setup.
    CREATE OBJECT f_Cut.
  ENDMETHOD.
  METHOD teardown.
    FREE: f_Cut.
  ENDMETHOD.
  METHOD add.
*  Given
    i_a = 5.
    i_b = 2.
    exp = 7.

* When
    result = f_Cut->add(
        i_a = i_A
        i_b = i_B ).

* Then
    cl_Abap_Unit_Assert=>assert_Equals(
      act   = result
      exp   = exp          "<--- please adapt expected value
      msg   = 'Addition functionality is not working for Unit test cases'
    ).
  ENDMETHOD.
  METHOD sub.

*  Given
    i_a = 5.
    i_b = 2.
    exp = 3.

* When
    result = f_Cut->sub(
        i_a = i_A
        i_b = i_B ).
* Then
    cl_Abap_Unit_Assert=>assert_Equals(
      act   = result
      exp   = exp          "<--- please adapt expected value
      msg   = 'Subtraction functionality is not working for Unit test cases'
    ).
  ENDMETHOD.
  METHOD mult.

*  Given
    i_a = 5.
    i_b = 2.
    exp = 10.

* When
    result = f_Cut->mult(
        i_a = i_A
        i_b = i_B ).
* Then
    cl_Abap_Unit_Assert=>assert_Equals(
      act   = result
      exp   = exp          "<--- please adapt expected value
      msg   = 'Multiplication functionality is not working for Unit test cases'
    ).
  ENDMETHOD.
  METHOD div.

*  Given
    i_a = 6.
    i_b = 2.
    exp = 3.

* When
    result = f_Cut->div(
        i_a = i_A
        i_b = i_B ).
* Then
    cl_Abap_Unit_Assert=>assert_Equals(
      act   = result
      exp   = exp          "<--- please adapt expected value
      msg   = 'Division functionality is not working for Unit test cases'
    ).
  ENDMETHOD.
ENDCLASS.
