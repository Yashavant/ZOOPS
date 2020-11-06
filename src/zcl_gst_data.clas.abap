class ZCL_GST_DATA definition
  public
  final
  create public .

public section.

  data DOA type ref to ZIF_CHECK_GST .

  methods GET_GST
    importing
      !IM_LIFNR type LIFNR
    returning
      value(R_GSTIN) type ABAP_BOOL .
  methods SET_DOA
    importing
      !IM_DOA type ref to ZIF_CHECK_GST optional .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GST_DATA IMPLEMENTATION.


  METHOD get_gst.
    DATA(lv_gstin) = doa->check_gstin( im_lifnr = im_lifnr ).
    IF lv_gstin IS NOT INITIAL.
      r_gstin = abap_true.
    ELSE.
      r_gstin = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD set_doa.
    IF im_doa IS NOT INITIAL.
      doa = im_doa.
    ELSE.
      doa = NEW zcl_check_gst( ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
