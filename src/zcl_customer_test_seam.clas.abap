class ZCL_CUSTOMER_TEST_SEAM definition
  public
  create public .

public section.

  types:
    BEGIN OF ty_total,
             bukrs TYPE bsid-bukrs,
             kunnr TYPE bsid-kunnr,
             waers TYPE bsid-waers,
             dmbtr TYPE bsid-dmbtr,
             wrbtr TYPE bsid-wrbtr,
           END OF ty_total .
  types:
    BEGIN OF ty_final,
        bukrs TYPE bsid-bukrs,
        kunnr TYPE bsid-kunnr,
        name  TYPE kna1-name1,
        land1 TYPE kna1-land1,
        spras TYPE kna1-spras,
        dmbtr TYPE bsid-dmbtr,
        wrbtr TYPE bsid-wrbtr,
        waers TYPE bsid-waers,
      END OF ty_final .
  types:
    tt_final TYPE STANDARD TABLE OF ty_final .
  types:
    tt_total TYPE STANDARD TABLE OF ty_total .

  methods GET_DATA
    importing
      !R_KUNNR type ZIF_CUSTOMER_DATA=>R_KUNNR
      !R_BUKRS type ZIF_CUSTOMER_DATA=>R_BUKRS
    exporting
      !IT_FINAL type TT_FINAL .
protected section.
private section.

  data IT_TOTAL type TT_TOTAL .
  data GS_TOTAL type TY_TOTAL .
  data GS_FINAL type TY_FINAL .

  methods DATA_PROCES
    importing
      !IT_BSID type ZIF_CUSTOMER_DATA=>TT_BSID
      !IT_KNA1 type ZIF_CUSTOMER_DATA=>TT_KNA1
    exporting
      !IT_FINAL type TT_FINAL .
ENDCLASS.



CLASS ZCL_CUSTOMER_TEST_SEAM IMPLEMENTATION.


  METHOD DATA_PROCES.

    LOOP AT it_bsid INTO DATA(ls_bsid).
      gs_total-bukrs = ls_bsid-bukrs.
      gs_total-kunnr = ls_bsid-kunnr.
      gs_total-waers = ls_bsid-waers.
      IF ls_bsid-shkzg = 'H'.
        gs_total-dmbtr = ls_bsid-dmbtr * -1.
        gs_total-wrbtr = ls_bsid-wrbtr * -1.
      ELSE.
        gs_total-dmbtr = ls_bsid-dmbtr.
        gs_total-wrbtr = ls_bsid-wrbtr.
      ENDIF.
      COLLECT gs_total INTO it_total.
      CLEAR:gs_total,ls_bsid.
    ENDLOOP.
    LOOP AT it_total INTO gs_total.
      gs_final-bukrs = gs_total-bukrs.
      gs_final-kunnr = gs_total-kunnr.
      gs_final-dmbtr = gs_total-dmbtr.
      gs_final-wrbtr = gs_total-wrbtr.
      gs_final-waers = gs_total-waers.
      IF line_exists(  it_kna1[ kunnr = gs_total-kunnr  ] ).
        gs_final-name = it_kna1[ kunnr = gs_total-kunnr  ]-name1.
        gs_final-land1 = it_kna1[ kunnr = gs_total-kunnr  ]-land1.
        gs_final-spras = it_kna1[ kunnr = gs_total-kunnr  ]-spras.
      ENDIF.
      APPEND gs_final TO it_final.
      CLEAR: gs_final,gs_total.
    ENDLOOP.
    REFRESH: it_total.

  ENDMETHOD.


  METHOD get_data.
    REFRESH: it_final.
    DATA: it_bsid TYPE zif_customer_data=>tt_bsid,
          it_kna1 TYPE zif_customer_data=>tt_kna1.
    TEST-SEAM get_data.
      DATA(obj_data) = NEW zcl_customer_data( ).
      obj_data->zif_customer_data~get_data(
        EXPORTING
          r_kunnr = r_kunnr
          r_bukrs = r_bukrs
        IMPORTING
          it_bsid = it_bsid
          it_kna1 = it_kna1 ).
    END-TEST-SEAM.
    SORT it_bsid BY kunnr.
    data_proces(
      EXPORTING
        it_bsid  = it_bsid
        it_kna1  = it_kna1
      IMPORTING
        it_final = it_final
    ).
  ENDMETHOD.
ENDCLASS.
