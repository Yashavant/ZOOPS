class ZCL_CALCULATOR1 definition
  public
  final
  create public .

public section.

  class-methods ADD
    importing
      !I_A type I
      !I_B type I
    returning
      value(RESULT) type I .
  class-methods DIV
    importing
      !I_A type I
      !I_B type I
    returning
      value(RESULT) type I .
  class-methods MULT
    importing
      !I_A type I
      !I_B type I
    returning
      value(RESULT) type I .
  class-methods SUB
    importing
      !I_A type I
      !I_B type I
    returning
      value(RESULT) type I .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CALCULATOR1 IMPLEMENTATION.


  METHOD add.
    result = i_a + i_b.
  ENDMETHOD.


  METHOD div.
    result = i_a / i_b.
  ENDMETHOD.


  METHOD mult.
    result = i_a * i_b.
  ENDMETHOD.


  METHOD sub.
    result = i_a - i_b.
  ENDMETHOD.
ENDCLASS.
