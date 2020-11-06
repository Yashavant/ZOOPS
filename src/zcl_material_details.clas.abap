class ZCL_MATERIAL_DETAILS definition
  public
  final
  create public .

public section.

  interfaces ZIF_MATERIAL_DETAILS .

  aliases S_MATNR
    for ZIF_MATERIAL_DETAILS~S_MATNR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MATERIAL_DETAILS IMPLEMENTATION.


  method ZIF_MATERIAL_DETAILS~GET_DATA.
      SELECT m~matnr
         m~mtart
         m~matkl
         m~meins
         r~werks
         r~ekgrp
    FROM mara AS m INNER JOIN marc AS r ON m~matnr = r~matnr
    INTO TABLE it_mara
    WHERE m~matnr IN IM_MATNR.

  IF it_mara IS NOT INITIAL.

    SELECT matnr
           bwkey
           bwtar
           lbkum
           salk3
           verpr
           stprs
      FROM mbew
      INTO TABLE it_mbew
      FOR ALL ENTRIES IN it_mara
      WHERE matnr = it_mara-matnr
        AND bwkey = it_mara-werks.

  ENDIF. "IF it_mara IS NOT INITIAL.
  endmethod.
ENDCLASS.
