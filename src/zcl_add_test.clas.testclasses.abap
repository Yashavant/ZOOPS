*"* use this source file for your ABAP unit test classes
CLASS lcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA: f_cut TYPE REF TO zcl_add_test.
    METHODS:setup,
      teardown,
      add_test FOR TESTING.
ENDCLASS.

CLASS lcl_test IMPLEMENTATION.

  METHOD setup.
    f_cut = NEW #( ).
  ENDMETHOD.

  METHOD add_test.
    DATA: iv_a TYPE i VALUE 10,
          iv_b TYPE i VALUE 5.
    DATA(r_result) = f_cut->add(
       EXPORTING
         im_a = iv_a
         im_b = iv_b ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = r_result
        exp                  = 15
        msg                  = 'Error in Addition Method'
    ).

  ENDMETHOD.
  METHOD teardown.
    FREE: f_cut.
  ENDMETHOD.

ENDCLASS.
