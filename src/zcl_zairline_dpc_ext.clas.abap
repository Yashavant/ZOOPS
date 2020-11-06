class ZCL_ZAIRLINE_DPC_EXT definition
  public
  inheriting from ZCL_ZAIRLINE_DPC
  create public .

public section.
protected section.

  methods AIRLINESET_GET_ENTITY
    redefinition .
  methods AIRLINESET_GET_ENTITYSET
    redefinition .
  methods SCHEDULESET_GET_ENTITY
    redefinition .
  methods SCHEDULESET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZAIRLINE_DPC_EXT IMPLEMENTATION.


  METHOD airlineset_get_entity.

    IF line_exists( it_key_tab[ name = 'Carrid' ] ).
      DATA(lv_Carrid) = it_key_tab[ name = 'Carrid' ]-value.
      SELECT SINGLE *
               FROM scarr
               INTO er_entity
              WHERE carrid = lv_CARRID.
    ENDIF.
  ENDMETHOD.


  METHOD airlineset_get_entityset.
    IF line_exists( it_key_tab[ name = 'Carrid' ] ).
      DATA(lv_Carrid) = it_key_tab[ name = 'Carrid' ]-value.
      SELECT *
        FROM scarr
        INTO TABLE et_entityset
       WHERE carrid = lv_CARRID.
    ELSE.
  SELECT *
    FROM scarr
    INTO TABLE et_entityset.
    ENDIF.
  ENDMETHOD.


  method SCHEDULESET_GET_ENTITY.
    IF line_exists( it_key_tab[ name = 'Carrid' ] ).
      DATA(lv_Carrid) = it_key_tab[ name = 'Carrid' ]-value.
      SELECT SINGLE *
               FROM SPFLI
               INTO er_entity
              WHERE carrid = lv_CARRID.
    ENDIF.
  endmethod.


  METHOD scheduleset_get_entityset.
    IF line_exists( it_key_tab[ name = 'Carrid' ] ).
      DATA(lv_Carrid) = it_key_tab[ name = 'Carrid' ]-value.
      SELECT *
        FROM spfli
        INTO TABLE et_entityset
       WHERE carrid = lv_CARRID.
    ELSE.
      SELECT *
        FROM spfli
        INTO TABLE et_entityset.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
