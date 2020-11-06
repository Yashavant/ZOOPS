*&---------------------------------------------------------------------*
*& Report ZCALCULATOR1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcalculator1.

CLASS lcl_calculator1 DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS add
      IMPORTING
        i_a             TYPE i
        i_b             TYPE i
      RETURNING
        VALUE(r_result) TYPE i.

ENDCLASS.

CLASS lcl_calculator1 IMPLEMENTATION.


  METHOD add.
    r_result = i_a + i_b.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_Calculator1_Test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.

    DATA i_A TYPE i.
    DATA i_B TYPE i.
    DATA result TYPE i.
    DATA exp TYPE i.

    METHODS: setup.
    METHODS: add FOR TESTING.
    METHODS: teardown.
ENDCLASS.       "lcl_Calculator_Test

CLASS lcl_Calculator1_Test IMPLEMENTATION.
  METHOD setup.
  ENDMETHOD.
  METHOD teardown.
  ENDMETHOD.
  METHOD add.
*  Given
    i_a = 5.
    i_b = 2.
    exp = 7.

* When
    result = lcl_calculator1=>add(
        i_a = i_A
        i_b = i_B ).
* Then
    cl_Abap_Unit_Assert=>assert_Equals(
      act   = result
      exp   = exp          "<--- please adapt expected value
      msg   = 'Test case falied to addition operation'
    ).
  ENDMETHOD.
ENDCLASS.
