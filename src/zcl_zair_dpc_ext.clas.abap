class ZCL_ZAIR_DPC_EXT definition
  public
  inheriting from ZCL_ZAIR_DPC
  create public .

public section.
protected section.

  methods AIRSET_GET_ENTITYSET
    redefinition .
  methods AIR1SET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZAIR_DPC_EXT IMPLEMENTATION.


  method AIR1SET_GET_ENTITYSET.
    SELECT *
      FROM ZSPFLI_V
      INTO TABLE et_entityset.
  endmethod.


  METHOD airset_get_entityset.
    SELECT *
      FROM spfli
      INTO TABLE et_entityset.
  ENDMETHOD.
ENDCLASS.
