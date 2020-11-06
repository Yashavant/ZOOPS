class ZCL_CUSTOMER_DATA definition
  public
  create public .

public section.

  interfaces ZIF_CUSTOMER_DATA .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CUSTOMER_DATA IMPLEMENTATION.


  METHOD zif_customer_data~get_data.

    SELECT bukrs,
       kunnr,
       gjahr,
       belnr,
       waers,
       shkzg,
       dmbtr,
       wrbtr
  FROM bsid
  INTO TABLE @it_bsid
 WHERE bukrs IN @r_bukrs
   AND kunnr IN @r_kunnr
   AND umsks = @space.

    IF it_bsid IS NOT INITIAL.
      SELECT *
        FROM kna1
        INTO TABLE it_kna1
         FOR ALL ENTRIES IN it_bsid
       WHERE kunnr = it_bsid-kunnr.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
