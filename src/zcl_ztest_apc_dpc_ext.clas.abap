class ZCL_ZTEST_APC_DPC_EXT definition
  public
  inheriting from ZCL_ZTEST_APC_DPC
  create public .

public section.
protected section.

  methods USERSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZTEST_APC_DPC_EXT IMPLEMENTATION.


  METHOD userset_get_entityset.

    SELECT *
      FROM zbc_user
      INTO TABLE et_entityset.
  ENDMETHOD.
ENDCLASS.
