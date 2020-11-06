class ZCL_SALES_ORDER_TD definition
  public
  create public .

public section.

  interfaces ZIF_SALES_ORDER .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SALES_ORDER_TD IMPLEMENTATION.


  METHOD ZIF_SALES_ORDER~DISPLAY.
    TRY .
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table   = zif_sales_order~gd_alv
          CHANGING
            t_table        = ch_vbak ).
      CATCH cx_salv_msg. " ALV: General Error Class with Message
    ENDTRY.
    zif_sales_order~gd_alv->display( ).
  ENDMETHOD.


  METHOD ZIF_SALES_ORDER~GET_DATA.
    SELECT k~vbeln
           k~ernam
           k~vkorg
           k~vtweg
           p~posnr
           p~matnr
           p~meins
           p~netwr
           p~kwmeng
           p~vrkme
      FROM vbak AS k INNER JOIN vbap AS p ON k~vbeln = p~vbeln
      INTO TABLE ex_vbak
     WHERE k~vbeln IN im_vbeln
       AND p~matnr IN im_matnr.
    IF ex_vbak IS INITIAL.
      MESSAGE 'No Data found' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
