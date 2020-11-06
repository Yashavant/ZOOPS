interface ZIF_CUSTOMER_DATA
  public .


  types:
    r_kunnr TYPE RANGE OF kunnr .
  types:
    r_bukrs TYPE RANGE OF bukrs .
  types:
    tt_kna1 TYPE STANDARD TABLE OF kna1 .
  types:
    BEGIN OF ty_bsid,
      bukrs TYPE bsid-bukrs,
      kunnr TYPE bsid-kunnr,
      gjahr TYPE bsid-gjahr,
      belnr TYPE bsid-belnr,
      waers TYPE bsid-waers,
      shkzg TYPE bsid-shkzg,
      dmbtr TYPE bsid-dmbtr,
      wrbtr TYPE bsid-wrbtr,
    END OF ty_bsid .
  types TT_BSID TYPE STANDARD TABLE OF TY_BSID.

  methods GET_DATA
    importing
      !R_KUNNR type R_KUNNR
      !R_BUKRS type R_BUKRS
    exporting
      !IT_BSID type TT_BSID
      !IT_KNA1 type TT_KNA1 .
endinterface.
