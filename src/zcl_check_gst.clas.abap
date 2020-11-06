class ZCL_CHECK_GST definition
  public
  final
  create public .

public section.

  interfaces ZIF_CHECK_GST .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CHECK_GST IMPLEMENTATION.


  METHOD zif_check_gst~check_gstin.

    SELECT SINGLE stcd3
             FROM lfa1
             INTO r_gst
            WHERE lifnr = im_lifnr.
  ENDMETHOD.
ENDCLASS.
