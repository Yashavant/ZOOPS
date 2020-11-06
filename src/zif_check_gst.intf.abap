interface ZIF_CHECK_GST
  public .


  methods CHECK_GSTIN
    importing
      !IM_LIFNR type LIFNR
    returning
      value(R_GST) type STCD3 .
endinterface.
