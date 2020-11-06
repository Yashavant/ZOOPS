*"* use this source file for your ABAP unit test classes

CLASS lcl_order_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO zcl_order_test_atdd.  "class under test

    METHODS: setup.
    METHODS: teardown.
    METHODS: order_data FOR TESTING.
ENDCLASS.       "lcl_Order_Test


CLASS lcl_order_test IMPLEMENTATION.

  METHOD setup.
    CREATE OBJECT f_cut.
  ENDMETHOD.


  METHOD teardown.
    FREE: f_cut.
  ENDMETHOD.


  METHOD order_data.

    DATA im_vbeln TYPE zif_order_atdd=>r_vbeln.
    DATA im_vkorg TYPE zif_order_atdd=>r_vkorg.
    DATA ex_vbak TYPE zif_order_atdd=>tt_vbak.
    DATA ex_exp TYPE zif_order_atdd=>tt_vbak.

    cl_apl_ecatt_tdc_api=>get_instance(
     EXPORTING
        i_testdatacontainer   =   'ZTDC_OREDER'
      RECEIVING
        e_tdc_ref             = DATA(o_test) ).

    o_test->get_value(
      EXPORTING
        i_param_name   = 'EX_VBAK'
        i_variant_name = 'ORDER_DATA'
      CHANGING
        e_param_value  = ex_exp ).

    TEST-INJECTION get_data.

      cl_apl_ecatt_tdc_api=>get_instance(
       EXPORTING
          i_testdatacontainer   =   'ZTDC_OREDER'
        RECEIVING
          e_tdc_ref             = DATA(o_test) ).

      o_test->get_value(
        EXPORTING
          i_param_name   = 'EX_VBAK'
          i_variant_name = 'ORDER_DATA'
        CHANGING
          e_param_value  = ex_vbak ).

    END-TEST-INJECTION.
    f_cut->order_data(
      EXPORTING
        im_vbeln = im_vbeln
        im_vkorg = im_vkorg
     IMPORTING
       ex_vbak = ex_vbak ).

    cl_abap_unit_assert=>assert_equals(
      act   = ex_vbak
      exp   = ex_exp          "<--- please adapt expected value
      msg   = 'Testing value ex_Vbak'
*     level =
    ).
  ENDMETHOD.
ENDCLASS.
