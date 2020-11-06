INTERFACE zif_sales_invoice
  PUBLIC .


  TYPES:
    BEGIN OF ty_vbrk,
      vbeln TYPE vbrk-vbeln,
      fkart TYPE vbrk-fkart,
      waerk TYPE vbrk-waerk,
      vkorg TYPE vbrk-vkorg,
      vtweg TYPE vbrk-vtweg,
      inco1 TYPE vbrk-inco1,
      inco2 TYPE vbrk-inco2,
      zterm TYPE vbrk-zterm,
      zlsch TYPE vbrk-zlsch,
      bukrs TYPE vbrk-bukrs,
      kunrg TYPE vbrk-kunrg,
      kunag TYPE vbrk-kunag,
    END OF ty_vbrk .
  TYPES:
    BEGIN OF ty_vbrp,
      vbeln TYPE vbrp-vbeln,
      posnr TYPE vbrp-posnr,
      fkimg TYPE vbrp-fkimg,
      vrkme TYPE vbrp-vrkme,
      meins TYPE vbrp-meins,
      fklmg TYPE vbrp-fklmg,
      netwr TYPE vbrp-netwr,
      matnr TYPE vbrp-matnr,
      arktx TYPE vbrp-arktx,
      werks TYPE vbrp-werks,
      waerk TYPE vbrp-waerk,
    END OF ty_vbrp .
  TYPES:
    r_vbeln TYPE RANGE OF vbeln_vf .
  TYPES:
    tt_vbrp TYPE STANDARD TABLE OF ty_vbrp .

  METHODS get_sales_invoice
    IMPORTING
      !im_vbeln TYPE r_vbeln
    EXPORTING
      !ex_vbrp  TYPE tt_vbrp
      !ex_vbrk  TYPE ty_vbrk .
  METHODS get_company_details
    IMPORTING
      !im_bukrs TYPE bukrs
    EXPORTING
      !ex_t001  TYPE t001 .
ENDINTERFACE.
