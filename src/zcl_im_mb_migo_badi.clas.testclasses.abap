
CLASS lcl_Test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO zcl_im_mb_migo_badi.  "class under test

    METHODS: setup.
    METHODS: teardown.
    METHODS: set_Object FOR TESTING.
ENDCLASS.       "lcl_Test


CLASS lcl_Test IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT f_Cut.
  ENDMETHOD.

  METHOD teardown.
    FREE: f_Cut.
  ENDMETHOD.

  METHOD set_Object.

    DATA ex_Gstin TYPE REF TO zcl_Gst_Data.

    f_Cut->set_Object(
     IMPORTING
       ex_gstin = ex_Gstin ).

    cl_Abap_Unit_Assert=>assert_bound(
      EXPORTING
        act              = ex_Gstin
        msg              = 'Testing value ex_Gstin' ).
  ENDMETHOD.
ENDCLASS.
