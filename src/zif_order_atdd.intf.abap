interface ZIF_ORDER_ATDD
  public .
  types:
    BEGIN OF ty_vbak,
           vbeln  TYPE vbak-vbeln,
           auart  TYPE vbak-auart,
           vkorg  TYPE vbak-vkorg,
           vtweg  TYPE vbak-vtweg,
           spart  TYPE vbak-spart,
           kunnr  TYPE vbak-kunnr,
           posnr  TYPE vbap-posnr,
           matnr  TYPE vbap-matnr,
           matkl  TYPE vbap-matkl,
           arktx  TYPE vbap-arktx,
           meins  TYPE vbap-meins,
           netwr  TYPE vbap-netwr,
           waerk  TYPE vbap-waerk,
           kwmeng TYPE vbap-kwmeng,
         END OF ty_vbak .
  types R_VBELN type RANGE OF VBAK-VBELN .
  types R_VKORG type RANGE OF VBAK-VKORG .
  types:
    tt_vbak TYPE STANDARD TABLE OF ty_vbak .

  methods GET_DATA
    importing
      !IM_VBELN type R_VBELN
      !IM_VKORG type R_VKORG
    exporting
      !EX_VBAK type TT_VBAK .
endinterface.
