class ZCL_SALES_INVOICE definition
  public
  final
  create public .

public section.

  interfaces ZIF_SALES_INVOICE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SALES_INVOICE IMPLEMENTATION.


  METHOD zif_sales_invoice~get_company_details.
    SELECT SINGLE *
             FROM t001
             INTO ex_t001
            WHERE bukrs = im_bukrs.
  ENDMETHOD.


  METHOD zif_sales_invoice~get_sales_invoice.
    SELECT SINGLE vbeln
                  fkart
                  waerk
                  vkorg
                  vtweg
                  inco1
                  inco2
                  zterm
                  zlsch
                  bukrs
                  kunrg
                  kunag
             FROM vbrk
             INTO ex_vbrk
            WHERE vbeln IN im_vbeln.
    IF ex_vbrk IS NOT INITIAL.
      SELECT vbeln
             posnr
             fkimg
             vrkme
             meins
             fklmg
             netwr
             matnr
             arktx
             werks
             waerk
        FROM vbrp
        INTO TABLE ex_vbrp
       WHERE vbeln = ex_vbrk-vbeln.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
