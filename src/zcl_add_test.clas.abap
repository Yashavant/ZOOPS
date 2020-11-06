CLASS zcl_add_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: add IMPORTING im_a         TYPE i
                           im_b         TYPE i
                 RETURNING VALUE(r_add) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS sub
      IMPORTING
        im_a         TYPE i
        im_b         TYPE i
      RETURNING
        VALUE(r_sub) TYPE i.
ENDCLASS.



CLASS zcl_add_test IMPLEMENTATION.
  METHOD add.
    r_add = im_a + im_b.
  ENDMETHOD.
  METHOD sub.
  ENDMETHOD.
ENDCLASS.

