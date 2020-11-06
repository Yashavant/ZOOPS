class ZCL_IM_MB_MIGO_BADI definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_MB_MIGO_BADI .

  methods SET_OBJECT
    exporting
      !EX_GSTIN type ref to ZCL_GST_DATA .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_MB_MIGO_BADI IMPLEMENTATION.


  METHOD if_ex_mb_migo_badi~check_header.
*    BREAK SAPDEV30.
  ENDMETHOD.


  method IF_EX_MB_MIGO_BADI~CHECK_ITEM.
*    BREAK SAPDEV30.
  endmethod.


  method IF_EX_MB_MIGO_BADI~HOLD_DATA_DELETE.
  endmethod.


  method IF_EX_MB_MIGO_BADI~HOLD_DATA_LOAD.
  endmethod.


  method IF_EX_MB_MIGO_BADI~HOLD_DATA_SAVE.
  endmethod.


  method IF_EX_MB_MIGO_BADI~INIT.
  endmethod.


  method IF_EX_MB_MIGO_BADI~LINE_DELETE.
  endmethod.


  method IF_EX_MB_MIGO_BADI~LINE_MODIFY.
  endmethod.


  method IF_EX_MB_MIGO_BADI~MAA_LINE_ID_ADJUST.
  endmethod.


  method IF_EX_MB_MIGO_BADI~MODE_SET.
  endmethod.


  method IF_EX_MB_MIGO_BADI~PAI_DETAIL.
  endmethod.


  method IF_EX_MB_MIGO_BADI~PAI_HEADER.
  endmethod.


  method IF_EX_MB_MIGO_BADI~PBO_DETAIL.
  endmethod.


  method IF_EX_MB_MIGO_BADI~PBO_HEADER.
  endmethod.


  METHOD if_ex_mb_migo_badi~post_document.
    BREAK sapdev30.
*    DATA(o_gstin) = NEW zcl_gst_data( ).
*    o_gstin->set_doa(
*        im_doa = NEW zcl_check_gst( ) ).
    set_object(
      IMPORTING
        ex_gstin =  DATA(o_gstin) ).

    LOOP AT it_mseg INTO DATA(ls_mseg).
      DATA(lv_gstin) = o_gstin->get_gst( im_lifnr = ls_mseg-lifnr ).
      IF lv_gstin IS INITIAL.
        MESSAGE 'No Gstin no assigned to Vendor' TYPE 'E'.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  method IF_EX_MB_MIGO_BADI~PROPOSE_SERIALNUMBERS.
  endmethod.


  method IF_EX_MB_MIGO_BADI~PUBLISH_MATERIAL_ITEM.
  endmethod.


  method IF_EX_MB_MIGO_BADI~RESET.
  endmethod.


  METHOD if_ex_mb_migo_badi~status_and_header.
*    BREAK sapdev30.
*    IF i_lines_in_model IS NOT INITIAL AND sy-ucomm = 'OK_CHECK'.
*      DATA(o_gstin) = NEW zcl_gst_data( ).
*      o_gstin->set_doa(
*          im_doa = NEW zcl_check_gst( ) ).
*      DATA(lv_gstin) = o_gstin->get_gst( im_lifnr = is_gohead-lifnr ).
*      IF lv_gstin IS INITIAL.
*        MESSAGE 'No Gstin no assigned to Vendor' TYPE 'E'.
*      ENDIF.
*    ENDIF.
  ENDMETHOD.


  METHOD set_object.
    ex_gstin = NEW zcl_gst_data( ).
    ex_gstin->set_doa(
        im_doa = NEW zcl_check_gst( ) ).
  ENDMETHOD.
ENDCLASS.
