class YCL_APC_WSP_EXT_YAPC_WS_TEST definition
  public
  inheriting from CL_APC_WSP_EXT_STATELESS_PCP_B
  final
  create public .

public section.

  methods IF_APC_WSP_EXT_PCP~ON_START
    redefinition .
  methods IF_APC_WSP_EXT_PCP~ON_MESSAGE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS YCL_APC_WSP_EXT_YAPC_WS_TEST IMPLEMENTATION.


  METHOD if_apc_wsp_ext_pcp~on_message.
    DATA: lo_producer TYPE REF TO if_amc_message_producer_text.
    TRY.
* retrieve the text message
        DATA(lv_text) = i_message->get_text( ).
        lo_producer ?= cl_amc_channel_manager=>create_message_producer(
         i_application_id = 'YAMC_TEST'
        i_channel_id       = '/ping' ).
        lo_producer->send( i_message = lv_text ).
      CATCH cx_amc_error INTO DATA(lx_amc_error).
        MESSAGE lx_amc_error->get_text( ) TYPE 'E'.
      CATCH cx_apc_error INTO DATA(lx_apc_error).
        MESSAGE lx_apc_error->get_text( ) TYPE 'E'.
    ENDTRY.

*    TRY.
** retrieve the text message
*        DATA(lv_text) = i_message->get_text( ).
** create the message object
*        DATA(lo_message) = i_message_manager->create_message( ).
** send 1st message
*        lo_message->set_text( |{ sy-mandt }/{ sy-uname }: ON_MESSAGE has been successfully executed !| ).
*        i_message_manager->send( lo_message ).
** send 2nd message, i.e. echo the incoming message
*        lo_message->set_text( lv_text ).
*        i_message_manager->send( lo_message ).
*      CATCH cx_apc_error INTO DATA(lx_apc_error).
*        MESSAGE lx_apc_error->get_text( ) TYPE 'E'.
*    ENDTRY.
  ENDMETHOD.


  METHOD if_apc_wsp_ext_pcp~on_start.

    TRY.
* bind the WebSocket connection to the AMC channel
        DATA(lo_binding) = i_context->get_binding_manager( ).
        lo_binding->bind_amc_message_consumer( i_application_id = 'YAMC_TEST'
        i_channel_id      = '/ping' ).
      CATCH cx_apc_error INTO DATA(lx_apc_error).
        DATA(lv_message) = lx_apc_error->get_text( ).
        MESSAGE lx_apc_error->get_text( ) TYPE 'E'.
    ENDTRY.

*    TRY.
** send the message on WebSocket connection
*        DATA(lo_message) = i_message_manager->create_message( ).
*        lo_message->set_text( |{ sy-mandt }/{ sy-uname }: ON_START has been successfully executed !| ).
*        i_message_manager->send( lo_message ).
*      CATCH cx_apc_error INTO DATA(lx_apc_error).
*        MESSAGE lx_apc_error->get_text( ) TYPE 'E'.
*    ENDTRY.
  ENDMETHOD.
ENDCLASS.
