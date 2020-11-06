class ZCL_TEST_CLASS definition
  public
  create public
  for testing
  duration short
  risk level harmless .

public section.
protected section.

  data F_CUT type ref to ZCL_TRIANGLE .
  data IM_S1 type I .
  data IM_S2 type I .
  data IM_S3 type I .
  data EXP type CHAR20 .
  data EX_RES type CHAR20 .
  data LO_TDC_API type ref to CL_APL_ECATT_TDC_API .
  data LT_VARIANTS type ETVAR_NAME_TABTYPE .

  methods TEADOWN .
  methods TEST_TRIANGLE
  for testing .
  methods GET_TRIANGLE_TYPE_IO
  for testing .
  methods GET_TRIANGLE_TYPE_EQ
  for testing .
private section.

  methods SETUP .
  methods GET_VALUE
    importing
      !IM_VAR type ETVAR_ID
    exporting
      !EX_EXP type CHAR20
      !EX_S1 type I
      !EX_S2 type I
      !EX_S3 type I .
ENDCLASS.



CLASS ZCL_TEST_CLASS IMPLEMENTATION.


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


  METHOD setup.
    CREATE OBJECT f_cut.
    lo_tdc_api = cl_apl_ecatt_tdc_api=>get_instance( 'ZTDC_TRIANGLE' ).
    lt_variants = lo_tdc_api->get_variant_list( ).

    DELETE lt_variants WHERE table_line = 'ECATTDEFAULT'.
  ENDMETHOD.


  METHOD teadown.
    FREE f_cut.
  ENDMETHOD.


  METHOD test_triangle.
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
ENDCLASS.
