*"* use this source file for your ABAP unit test classes
CLASS lcl_demo_sflight_test DEFINITION FINAL FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA: lo_enviro TYPE REF TO if_cds_test_environment.

    CLASS-DATA: lo_td_sflight TYPE REF TO if_cds_test_data.

    DATA: lo_sflight_double TYPE REF TO if_cds_stub.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.

    METHODS: setup.
    METHODS: teardown.

* TEST METHODS
    METHODS: test_group_price FOR TESTING.

ENDCLASS.

CLASS lcl_demo_sflight_test IMPLEMENTATION.
  METHOD class_setup.

*” call the CREATE method to create the environment
    cl_cds_test_environment=>create(
    EXPORTING
    i_for_entity = 'ZDEMO_SFLIGHT1'           " CDS VIEW NAME
    RECEIVING
    r_result = lo_enviro
    ).
  ENDMETHOD.

  METHOD class_teardown.
    lo_enviro->destroy( ).
  ENDMETHOD.

  METHOD setup.

*” here we prepare the test double data as not intended to test with the actual DB data

* insert test data into component doubles- sflight
    DATA: lt_sflight TYPE TABLE OF sflight.
    lt_sflight = VALUE #(

    ( mandt = sy-mandt carrid = 'aa' connid = '0001'  price = '100' currency = 'inr' )
*    ( mandt = sy-mandt carrid = 'aa' connid = '0001'  price = '200' currency = 'inr' )
*    ( mandt = sy-mandt carrid = 'aa' connid = '0001'  price = '500' currency = 'usd' )
*    ( mandt = sy-mandt carrid = 'aa' connid = '0001'  price = '600' currency = 'usd' )
    ).
    lo_td_sflight = cl_cds_test_data=>create( i_data = lt_sflight ).

*“ the dependent component name
    lo_sflight_double = lo_enviro->get_double( i_name = 'sflight' ).
    lo_sflight_double->insert( i_test_data = lo_td_sflight ).

  ENDMETHOD.

  METHOD teardown.
    lo_enviro->clear_doubles( ).
  ENDMETHOD.
  METHOD test_group_price.

*” perform the assert testing – compare the actual with the expected values
    DATA: lt_exp_group_res TYPE TABLE OF zdemo_sflight1.
    lt_exp_group_res = VALUE #(

    ( carrid = 'aa' connid = '0001'  price = '100' currency = 'inr' )
    ).

* the selection on the CDS view gives the test double data
    SELECT * FROM zdemo_sflight1 INTO TABLE @DATA(lt_act_group_res).

* Assert checks

    cl_abap_unit_assert=>assert_equals(
    EXPORTING
    act = lines( lt_act_group_res )
    exp = lines( lt_exp_group_res )
    msg = |No. of lines must be 2| ).

  ENDMETHOD.

ENDCLASS.
