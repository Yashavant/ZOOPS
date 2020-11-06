*"* use this source file for your ABAP unit test classes
CLASS ltc_uservalidity DEFINITION FOR TESTING
                       RISK LEVEL HARMLESS
                       DURATION SHORT.
  PRIVATE SECTION.
    DATA: m_cut TYPE REF TO zcl_uservalidity.
    METHODS setup.
    METHODS user_days FOR TESTING RAISING cx_static_check.

ENDCLASS.
CLASS ltc_uservalidity IMPLEMENTATION.
  METHOD setup.
    m_cut = NEW zcl_uservalidity( ).
  ENDMETHOD.
  METHOD user_days.

    " 60 Days test all possible combinations for XXX
    m_cut->check_userendate_upd_needed( EXPORTING
                                         userid = 'XXX123'
                                         days   = 60
                                         startdate ='20180130'
                                       IMPORTING
                                         r_result = DATA(checkvalue)
                                         r_newenddate = DATA(enddate) ).

    cl_abap_unit_assert=>assert_equals( act = checkvalue
                                        exp = 'Y' ).

    m_cut->check_userendate_upd_needed( EXPORTING
                                         userid = 'XXX123'
                                         days   = 59
                                         startdate ='20180131'
                                       IMPORTING
                                         r_result = checkvalue
                                         r_newenddate = enddate ).

    cl_abap_unit_assert=>assert_equals( act = checkvalue
                                        exp = 'N' ).

    m_cut->check_userendate_upd_needed( EXPORTING
                                         userid = 'XXX123'
                                         days   = 61
                                         startdate ='20180129'
                                       IMPORTING
                                         r_result = checkvalue
                                         r_newenddate = enddate ).

    cl_abap_unit_assert=>assert_equals( act = checkvalue
                                        exp = 'Y' ).
    m_cut->check_userendate_upd_needed( EXPORTING
                                         userid = 'XTZ123'
                                         days   = 59
                                         startdate ='20180131'
                                       IMPORTING
                                         r_result = checkvalue
                                         r_newenddate = enddate ).
    cl_abap_unit_assert=>assert_equals( act = checkvalue
                                        exp = 'N' ).
    " 45 Days test all possible combinations for YYY
    m_cut->check_userendate_upd_needed( EXPORTING
                                          userid = 'YYY123'
                                          days   = 45
                                          startdate ='20180130'
                                        IMPORTING
                                          r_result = checkvalue
                                          r_newenddate = enddate ).
    cl_abap_unit_assert=>assert_equals( act = checkvalue
                                        exp = 'Y' ).

    m_cut->check_userendate_upd_needed( EXPORTING
                                         userid = 'YYY123'
                                         days   = 44
                                         startdate ='20180130'
                                       IMPORTING
                                         r_result = checkvalue
                                         r_newenddate = enddate ).
    cl_abap_unit_assert=>assert_equals( act = checkvalue
                                        exp = 'N' ).
    m_cut->check_userendate_upd_needed( EXPORTING
                                         userid = 'YYY123'
                                         days   = 48
                                         startdate ='20180130'
                                       IMPORTING
                                         r_result = checkvalue
                                         r_newenddate = enddate ).
    cl_abap_unit_assert=>assert_equals( act = checkvalue
                                        exp = 'Y' ).
    m_cut->check_userendate_upd_needed( EXPORTING
                                         userid = 'XTZ123'
                                         days   = 49
                                         startdate ='20180130'
                                       IMPORTING
                                         r_result = checkvalue
                                         r_newenddate = enddate ).
    cl_abap_unit_assert=>assert_equals( act = checkvalue
                                        exp = 'N' ).

  ENDMETHOD.

ENDCLASS.
