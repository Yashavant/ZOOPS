*"* use this source file for your ABAP unit test classes
CLASS lcl_fm_testing DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    CLASS-DATA: gd_qty TYPE i.
    METHODS: setup,
      teardown,
      test_fm FOR TESTING.
ENDCLASS.
CLASS lcl_fm_testing IMPLEMENTATION.
  METHOD setup.
    gd_qty = 1.
  ENDMETHOD.
  METHOD teardown.
  ENDMETHOD.
  METHOD test_fm.

  ENDMETHOD.
ENDCLASS.
