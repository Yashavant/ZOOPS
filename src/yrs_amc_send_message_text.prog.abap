*&---------------------------------------------------------------------*
*& Report YRS_AMC_SEND_MESSAGE_TEXT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YRS_AMC_SEND_MESSAGE_TEXT.
PARAMETERS: message TYPE string LOWER CASE DEFAULT 'Hi there !'.
DATA: lo_producer_text TYPE REF TO if_amc_message_producer_text.
DATA: lx_amc_error       TYPE REF TO cx_amc_error.
TRY.
lo_producer_text ?= cl_amc_channel_manager=>create_message_producer( i_application_id = 'YAMC_TEST' i_channel_id = '/ping' ).


" send message to the AMC channel
lo_producer_text->send( i_message = message ).

CATCH cx_amc_error INTO lx_amc_error.
MESSAGE lx_amc_error->get_text( ) TYPE 'E'.
ENDTRY.
