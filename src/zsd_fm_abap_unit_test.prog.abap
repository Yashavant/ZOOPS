*&---------------------------------------------------------------------*
*& Report ZSD_FM_ABAP_UNIT_TEST
*&---------------------------------------------------------------------*
REPORT zsd_fm_abap_unit_test.

CLASS lcl_fm_testing DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    METHODS: setup,
      teardown,
      test_fm FOR TESTING.
ENDCLASS.
CLASS lcl_fm_testing IMPLEMENTATION.
  METHOD setup.
  ENDMETHOD.
  METHOD teardown.
  ENDMETHOD.
  METHOD test_fm.
  ENDMETHOD.
ENDCLASS.
