*&---------------------------------------------------------------------*
*& Report ZCREATE_USER
*&---------------------------------------------------------------------*

REPORT zcreate_user.

TABLES zbc_user.

DATA wa_user TYPE zbc_user.

DATA: lo_producer TYPE REF TO if_amc_message_producer_text,
      lv_message  TYPE string.

PARAMETERS: p_user  TYPE string,
            p_first TYPE string,
            p_last  TYPE string.

START-OF-SELECTION.

  lv_message = 'Dunning level has been changed. Reload the page to view the updated dunning levels'.
  wa_user-firstname = p_first.
  wa_user-username = p_user.
  wa_user-lastname = p_last.

  INSERT zbc_user FROM wa_user.
  TRY .
      lo_producer ?= cl_amc_channel_manager=>create_message_producer(
                       i_application_id       = 'ZTEST_AMC'
                       i_channel_id           = '/dunning_level_change'
                     ).
      lo_producer->send( i_message = p_first ).
    CATCH cx_amc_error INTO DATA(ls) . .
      RETURN.
  ENDTRY.
