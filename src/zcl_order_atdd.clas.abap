class ZCL_ORDER_ATDD definition
  public
  final
  create public .

public section.

  interfaces ZIF_ORDER_ATDD .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ORDER_ATDD IMPLEMENTATION.


  METHOD zif_order_atdd~get_data.

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
      INTO TABLE ex_vbak
      WHERE k~vbeln IN im_vbeln
        AND k~vkorg IN im_vkorg.

  ENDMETHOD.
ENDCLASS.
