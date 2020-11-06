*"* use this source file for your ABAP unit test classes

CLASS lcl_triangle_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO zcl_triangle.  "class under test

    METHODS: setup.
    METHODS: teardown.
    METHODS: get_triangle_type FOR TESTING,
      get_triangle_type_io FOR TESTING,
      get_triangle_type_eq FOR TESTING,
      get_value IMPORTING im_var TYPE etvar_id
                EXPORTING ex_s1  TYPE i
                          ex_s2  TYPE i
                          ex_s3  TYPE i
                          ex_exp TYPE char20.

    DATA: lo_tdc_api  TYPE REF TO cl_apl_ecatt_tdc_api,
          lt_variants TYPE etvar_name_tabtype.
    DATA im_s1 TYPE i.
    DATA im_s2 TYPE i.
    DATA im_s3 TYPE i.
    DATA ex_res TYPE char20.
    DATA exp TYPE char20.

ENDCLASS.       "lcl_Triangle_Test


CLASS lcl_triangle_test IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT f_cut.
    lo_tdc_api = cl_apl_ecatt_tdc_api=>get_instance( 'ZTDC_TRIANGLE' ).
    lt_variants = lo_tdc_api->get_variant_list( ).

    DELETE lt_variants WHERE table_line = 'ECATTDEFAULT'.
  ENDMETHOD.


  METHOD teardown.
    FREE: f_cut.
  ENDMETHOD.

  METHOD get_triangle_type.
* Given

    LOOP AT lt_variants INTO DATA(ls_var) WHERE table_line CP 'TRIANGLE_SC*'.
      get_value(
        EXPORTING
          im_var = ls_var
        IMPORTING
          ex_s1  = im_s1
          ex_s2  = im_s2
          ex_s3  = im_s3
          ex_exp = exp ).
* When
      ex_res = f_cut->get_triangle_type(
          im_s1 = im_s1
          im_s2 = im_s2
          im_s3 = im_s3 ).
* Then
      cl_abap_unit_assert=>assert_equals(
        act   = ex_res
        exp   = exp          "<--- please adapt expected value
        msg   = 'Testing value ex_Res'
*     level =
      ).
    ENDLOOP.

  ENDMETHOD.

  METHOD get_triangle_type_io.
* Given
    LOOP AT lt_variants INTO DATA(ls_var) WHERE table_line CP 'TRIANGLE_IS*'.
      get_value(
        EXPORTING
          im_var = ls_var
        IMPORTING
          ex_s1  = im_s1
          ex_s2  = im_s2
          ex_s3  = im_s3
          ex_exp = exp ).
* When
      ex_res = f_cut->get_triangle_type(
          im_s1 = im_s1
          im_s2 = im_s2
          im_s3 = im_s3 ).
* Then
      cl_abap_unit_assert=>assert_equals(
        act   = ex_res
        exp   = exp          "<--- please adapt expected value
        msg   = 'Testing value ex_Res'
*     level =
      ).
    ENDLOOP.
  ENDMETHOD.

  METHOD get_triangle_type_eq.
* Given
    LOOP AT lt_variants INTO DATA(ls_var) WHERE table_line CP 'TRIANGLE_EQ*'.
      get_value(
        EXPORTING
          im_var = ls_var
        IMPORTING
          ex_s1  = im_s1
          ex_s2  = im_s2
          ex_s3  = im_s3
          ex_exp = exp ).
* When
      ex_res = f_cut->get_triangle_type(
          im_s1 = im_s1
          im_s2 = im_s2
          im_s3 = im_s3 ).
* Then
      cl_abap_unit_assert=>assert_equals(
        act   = ex_res
        exp   = exp          "<--- please adapt expected value
        msg   = 'Testing value ex_Res'
*     level =
      ).
    ENDLOOP.
  ENDMETHOD.
  METHOD get_value.
    DEFINE get_val.
      lo_tdc_api->get_value(
              EXPORTING
                i_param_name = &1
                i_variant_name = im_var
              CHANGING
                e_param_value = &2 ).
    END-OF-DEFINITION.

    get_val: 'S1' ex_s1,
             'S2' ex_s2,
             'S3' ex_s3,
             'EXP' ex_exp.
  ENDMETHOD.
ENDCLASS.
