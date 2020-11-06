interface ZIF_SALES_ORDER
  public .


  types:
    BEGIN OF ts_vbak,
           vbeln  TYPE vbak-vbeln,
           ernam  TYPE vbak-ernam,
           vkorg  TYPE vbak-vkorg,
           vtweg  TYPE vbak-vtweg,
           posnr  TYPE vbap-posnr,
           matnr  TYPE vbap-matnr,
           meins  TYPE vbap-meins,
           netwr  TYPE vbap-netwr,
           kwmeng TYPE vbap-kwmeng,
           vrkme  TYPE vbap-vrkme,
         END OF ts_vbak .
  types:
    r_matnr TYPE RANGE OF vbap-matnr .
  types:
    r_vbeln TYPE RANGE OF vbap-vbeln .
  types:
    tt_vbak TYPE STANDARD TABLE OF ts_vbak .

  data GD_ALV type ref to CL_SALV_TABLE .

  methods GET_DATA
    importing
      !IM_VBELN type R_VBELN
      !IM_MATNR type R_MATNR
    exporting
      !EX_VBAK type TT_VBAK .
  methods DISPLAY
    changing
      !CH_VBAK type TT_VBAK .
endinterface.
