CLASS zcl_material DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_material .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_material IMPLEMENTATION.

  METHOD zif_material~get_material_data.
    SELECT m~matnr
       m~mtart
       m~mbrsh
       m~matkl
       m~meins
       m~brgew
       m~ntgew
       m~volum
       m~voleh
       r~werks
       r~ekgrp
  FROM mara AS m INNER JOIN marc AS r ON m~matnr = r~matnr
  INTO TABLE ex_mara
 WHERE m~matnr IN im_matnr
   AND r~werks IN im_werks.

    IF ex_mara IS NOT INITIAL.
      SELECT matnr
             werks
             lgort
             lfgja
             lfmon
             labst
        FROM mard
        INTO TABLE ex_mard
         FOR ALL ENTRIES IN ex_mara
       WHERE matnr = ex_mara-matnr
         AND werks = ex_mara-werks.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
