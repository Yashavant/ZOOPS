class ZCL_ZMM_PURCHASE_ORDER_DPC_EXT definition
  public
  inheriting from ZCL_ZMM_PURCHASE_ORDER_DPC
  create public .

public section.
protected section.

  methods HEADERSET_GET_ENTITY
    redefinition .
  methods HEADERSET_GET_ENTITYSET
    redefinition .
  methods ITEMSET_GET_ENTITYSET
    redefinition .
  methods ITEMSET_GET_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZMM_PURCHASE_ORDER_DPC_EXT IMPLEMENTATION.


  METHOD headerset_get_entity.
    DATA: lv_ebeln TYPE ekko-ebeln.
    IF line_exists( it_key_tab[ name = 'Ebeln' ] ).
      lv_ebeln = it_key_tab[ name = 'Ebeln' ]-value.
      lv_ebeln = |{ lv_ebeln ALPHA = IN }|.
      SELECT SINGLE *
               FROM ekko
               INTO er_entity
              WHERE ebeln = lv_ebeln.
      ENDIF.

    ENDMETHOD.


  METHOD headerset_get_entityset.
    DATA: lv_ebeln TYPE ekko-ebeln.
    IF line_exists( it_key_tab[ name = 'Ebeln' ] ).
      lv_ebeln = it_key_tab[ name = 'Ebeln' ]-value.
      lv_ebeln = |{ lv_ebeln ALPHA = IN }|.
      SELECT *
        FROM ekko
        INTO TABLE et_entityset
       WHERE ebeln = lv_ebeln.
    ELSE.
      SELECT *
        FROM ekko
        INTO TABLE et_entityset.
    ENDIF.

    CALL METHOD /iwbep/cl_mgw_data_util=>paging
      EXPORTING
        is_paging = is_paging
      CHANGING
        ct_data   = et_entityset.

    CALL METHOD /iwbep/cl_mgw_data_util=>filtering
      EXPORTING
        it_select_options = it_filter_select_options
      CHANGING
        ct_data           = et_entityset.

    IF io_tech_request_context->has_inlinecount( ) = abap_true.
      DESCRIBE TABLE et_entityset LINES es_response_context-inlinecount.
    ELSE.
      CLEAR es_response_context-inlinecount.
    ENDIF.

    CALL METHOD /iwbep/cl_mgw_data_util=>orderby
      EXPORTING
        it_order = it_order
      CHANGING
        ct_data  = et_entityset.

  ENDMETHOD.


  method ITEMSET_GET_ENTITY.
    DATA: lv_ebeln TYPE ekko-ebeln.
    IF line_exists( it_key_tab[ name = 'Ebeln' ] ).
      lv_ebeln = it_key_tab[ name = 'Ebeln' ]-value.
      lv_ebeln = |{ lv_ebeln ALPHA = IN }|.
      SELECT SINGLE *
               FROM ekpo
               INTO ER_ENTITY
              WHERE ebeln = lv_ebeln.
    ENDIF.
  endmethod.


  METHOD itemset_get_entityset.
    DATA: lv_ebeln TYPE ekko-ebeln.
    IF line_exists( it_key_tab[ name = 'Ebeln' ] ).
      lv_ebeln = it_key_tab[ name = 'Ebeln' ]-value.
      lv_ebeln = |{ lv_ebeln ALPHA = IN }|.
      SELECT *
        FROM ekpo
        INTO TABLE et_entityset
       WHERE ebeln = lv_ebeln.
    ELSE.
      SELECT *
        FROM ekpo
        INTO TABLE et_entityset.
    ENDIF.

    CALL METHOD /iwbep/cl_mgw_data_util=>paging
      EXPORTING
        is_paging = is_paging
      CHANGING
        ct_data   = et_entityset.

    CALL METHOD /iwbep/cl_mgw_data_util=>filtering
      EXPORTING
        it_select_options = it_filter_select_options
      CHANGING
        ct_data           = et_entityset.

    IF io_tech_request_context->has_inlinecount( ) = abap_true.
      DESCRIBE TABLE et_entityset LINES es_response_context-inlinecount.
    ELSE.
      CLEAR es_response_context-inlinecount.
    ENDIF.

    CALL METHOD /iwbep/cl_mgw_data_util=>orderby
      EXPORTING
        it_order = it_order
      CHANGING
        ct_data  = et_entityset.

  ENDMETHOD.
ENDCLASS.
