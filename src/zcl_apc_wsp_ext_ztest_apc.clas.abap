class ZCL_APC_WSP_EXT_ZTEST_APC definition
  public
  inheriting from CL_APC_WSP_EXT_STATELESS_BASE
  final
  create public .

public section.

  methods IF_APC_WSP_EXTENSION~ON_START
    redefinition .
  methods IF_APC_WSP_EXTENSION~ON_MESSAGE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_APC_WSP_EXT_ZTEST_APC IMPLEMENTATION.


  method IF_APC_WSP_EXTENSION~ON_MESSAGE.
*CALL METHOD SUPER->IF_APC_WSP_EXTENSION~ON_MESSAGE
*  EXPORTING
*    I_MESSAGE         =
*    I_MESSAGE_MANAGER =
*    I_CONTEXT         =
*    .
  endmethod.


  METHOD if_apc_wsp_extension~on_start.
    DATA: lo_binding TYPE REF TO if_apc_ws_binding_manager.

    DATA: lx_error TYPE REF TO cx_apc_error.

    DATA: lv_message TYPE string.

* bind the APC WebSocket connection to an AMC channel

    TRY .
        lo_binding = i_context->get_binding_manager( ).
        lo_binding->bind_amc_message_consumer(
          EXPORTING
            i_application_id       = 'ZTEST_AMC'
            i_channel_id           =  '/dunning_level_change'
        ).
      CATCH cx_apc_error INTO lx_error.
        lv_message = lx_error->get_text( ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
