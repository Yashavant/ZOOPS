class ZCL_CALCULATOR definition
  public
  final
  create public .

public section.

  methods ADD
    importing
      !I_A type I
      !I_B type I
    returning
      value(RESULT) type I .
  methods SUB
    importing
      !I_A type I
      !I_B type I
    returning
      value(RESULT) type I .
  methods MULT
    importing
      !I_A type I
      !I_B type I
    returning
      value(RESULT) type I .
  methods DIV
    importing
      !I_A type I
      !I_B type I
    returning
      value(RESULT) type I .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CALCULATOR IMPLEMENTATION.


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
