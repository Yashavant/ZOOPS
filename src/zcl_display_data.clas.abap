class ZCL_DISPLAY_DATA definition
  public
  inheriting from ZCL_ORDER_DATA
  create public .

public section.

  methods DISPLAY_DATA .
protected section.
private section.
ENDCLASS.



CLASS ZCL_DISPLAY_DATA IMPLEMENTATION.


  METHOD display_data.
    TRY .
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table   =  DATA(lo_alv)
          CHANGING
            t_table        = it_vbak ).
      CATCH cx_salv_msg.
    ENDTRY.

    lo_alv->display( ).
  ENDMETHOD.
ENDCLASS.
