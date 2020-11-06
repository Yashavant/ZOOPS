*"* use this source file for your ABAP unit test classes
CLASS lcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    CLASS-DATA:
        environment TYPE REF TO if_cds_test_environment.
    CLASS-DATA: lo_td_mat TYPE REF TO if_cds_test_data.

    DATA: lo_mat_double TYPE REF TO if_cds_stub.

    CLASS-METHODS:
      class_setup,
      class_teardown.
    METHODS setup.
    METHODS teardown.
    METHODS: test_material_CDS FOR TESTING RAISING cx_static_check.
    DATA: it_ZMM_MATERIAL TYPE STANDARD TABLE OF ZMM_MATERIAL,
          test_data       TYPE REF TO if_cds_test_data.
ENDCLASS.

CLASS lcl_test IMPLEMENTATION.
    METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'ZMM_MATERIAL'
              ).
  ENDMETHOD.
  METHOD setup.
    DATA: it_ZMM_MAT TYPE STANDARD TABLE OF mara.
    it_ZMM_MAT = VALUE #( ( matnr = 'Mat1' ernam = 'ABC'  mtart ='001' matkl = 'M01'  ) ).
environment->insert_test_data(
  EXPORTING
    i_data             = it_ZMM_MAT
).
*    lo_td_mat = cl_cds_test_data=>create( i_data = it_ZMM_MAT ).
*    lo_mat_double = environment->get_double( i_name = 'mara' ).
*    lo_mat_double->insert( i_test_data = lo_td_mat ).

  ENDMETHOD.
  METHOD teardown.
  ENDMETHOD.
  METHOD test_material_cds.

    it_ZMM_MATERIAL = VALUE #( ( matnr = 'Mat1' ernam = 'ABC'  mtart ='001' matkl = 'M01'  ) ).

    SELECT * FROM zmm_material INTO  TABLE @DATA(act_mara).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = act_mara
        exp                  = it_ZMM_MATERIAL
        msg                  = 'Error With CDS View' ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

ENDCLASS.
