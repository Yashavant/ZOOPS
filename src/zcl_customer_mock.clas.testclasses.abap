*"* use this source file for your ABAP unit test classes
CLASS lcl_cust_mock DEFINITION INHERITING FROM zcl_customer_mock.
  PUBLIC SECTION.
    METHODS: get_cust_from_class REDEFINITION.
    DATA: lt_bsid TYPE zif_customer_data=>tt_bsid,
          lt_kna1 TYPE zif_customer_data=>tt_kna1.
ENDCLASS.
CLASS lcl_cust_mock IMPLEMENTATION.
  METHOD get_cust_from_class.
    it_bsid = lt_bsid.
    it_kna1 = lt_kna1.
  ENDMETHOD.
ENDCLASS.
CLASS lcl_customer_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut  TYPE REF TO lcl_cust_mock.  "class under test.
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_data FOR TESTING.

    DATA r_kunnr TYPE zif_customer_data=>r_kunnr.
    DATA r_bukrs TYPE zif_customer_data=>r_bukrs.
*    DATA it_bsid TYPE zif_customer_data=>tt_bsid.
*    DATA it_kna1 TYPE zif_customer_data=>tt_kna1.
    DATA exp_final TYPE zcl_customer_mock=>tt_final.

ENDCLASS.       "lcl_Customer_Test


CLASS lcl_customer_test IMPLEMENTATION.

  METHOD setup.

    DATA im_doa TYPE REF TO zif_customer_data.

    CREATE OBJECT f_cut.
*      EXPORTING
*        im_doa = me->lo_doa.
  ENDMETHOD.

  METHOD teardown.
    FREE:f_cut.
  ENDMETHOD.


  METHOD get_data.
* Given

    cl_apl_ecatt_tdc_api=>get_instance(
      EXPORTING
        i_testdatacontainer  =  'ZTDC_CUSTOMER'
      RECEIVING
        e_tdc_ref            =  DATA(o_test) ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'IT_BSID'
        i_variant_name = 'CUSTOMER_DATA'
      CHANGING
        e_param_value  =  f_cut->lt_bsid ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'IT_KNA1'
        i_variant_name = 'CUSTOMER_DATA'
      CHANGING
        e_param_value  =  f_cut->lt_kna1 ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'IT_FINAL'
        i_variant_name = 'CUSTOMER_DATA'
      CHANGING
        e_param_value  =  exp_final ).

* When
    f_cut->get_data(
      EXPORTING
        r_kunnr = r_kunnr
        r_bukrs = r_bukrs
     IMPORTING
       it_final = DATA(it_final) ).

* Then
    cl_abap_unit_assert=>assert_equals(
      act   = it_final
      exp   = exp_final          "<--- please adapt expected value
      msg   = 'Testing value it_Final'
    ).
  ENDMETHOD.

ENDCLASS.
