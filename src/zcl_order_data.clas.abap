class ZCL_ORDER_DATA definition
  public
  create public .

public section.

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
  types:
    r_vbeln TYPE RANGE OF vbak-vbeln .
  types:
    r_vkorg TYPE RANGE OF vbak-vkorg .
  types:
    tt_vbak TYPE STANDARD TABLE OF ty_vbak .

  data IT_VBAK type TT_VBAK .

  methods GET_DATA
    importing
      !IM_VBELN type R_VBELN
      !IM_VKORG type R_VKORG .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ORDER_DATA IMPLEMENTATION.


  METHOD get_data.
    SELECT k~vbeln
       k~auart
       k~vkorg
       k~vtweg
       k~spart
       k~kunnr
       p~posnr
       p~matnr
       p~matkl
       p~arktx
       p~meins
       p~netwr
       p~waerk
       p~kwmeng
  FROM vbak AS k INNER JOIN vbap AS p ON k~vbeln = p~vbeln
  INTO TABLE it_vbak
  WHERE k~vbeln IN im_vbeln
    AND k~vkorg IN im_vkorg.

  ENDMETHOD.
ENDCLASS.
