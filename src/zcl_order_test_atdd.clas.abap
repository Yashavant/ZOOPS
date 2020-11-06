class ZCL_ORDER_TEST_ATDD definition
  public
  final
  create public .

public section.

  methods ORDER_DATA
    importing
      !IM_VBELN type ZIF_ORDER_ATDD=>R_VBELN
      !IM_VKORG type ZIF_ORDER_ATDD=>R_VKORG
    exporting
      !EX_VBAK type ZIF_ORDER_ATDD=>TT_VBAK .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ORDER_TEST_ATDD IMPLEMENTATION.


  METHOD order_data.
    DATA(lo_doa) = NEW zcl_order_atdd( ).
    TEST-SEAM get_data.
      lo_doa->zif_order_atdd~get_data(
        EXPORTING
          im_vbeln = im_vbeln
          im_vkorg = im_vkorg
        IMPORTING
          ex_vbak  = ex_vbak ).
    END-TEST-SEAM.
  ENDMETHOD.
ENDCLASS.
