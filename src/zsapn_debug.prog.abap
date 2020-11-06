*&---------------------------------------------------------------------*
*& Report ZSAPN_DEBUG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSAPN_DEBUG.

DATA : IT_MARA TYPE TABLE OF MARA,
       WA_MARA TYPE MARA.

PARAMETERS: P_MTART TYPE MARA-MTART.


SELECT * FROM MARA INTO TABLE IT_MARA UP TO 50 ROWS
  WHERE MTART = P_MTART.

LOOP AT IT_MARA INTO WA_MARA.
  WRITE:/ WA_MARA-MATNR, WA_MARA-MTART, WA_MARA-MATKL, WA_MARA-MEINS, WA_MARA-SPART.
ENDLOOP.
