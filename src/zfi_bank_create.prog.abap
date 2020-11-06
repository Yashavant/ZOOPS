*&---------------------------------------------------------------------*
*& Report ZFI_BANK_CREATE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zfi_bank_create.

DATA: lv_cntry TYPE  bapi1011_key-bank_ctry.
DATA: lv_key TYPE  bapi1011_key-bank_key.
DATA: wa_address TYPE bapi1011_address.
DATA: wa_return TYPE bapiret2.
DATA: lv_cotry1  TYPE bapi1011_key-bank_ctry.
DATA: lv_key1 TYPE bapi1011_key-bank_key.

lv_cntry = 'IN'.
lv_key = 'HDFC-04'.
wa_address-bank_name = 'Bank 1'.

CALL FUNCTION 'BAPI_BANK_CREATE'
  EXPORTING
    bank_ctry    = lv_cntry
    bank_key     = lv_key
    bank_address = wa_address
  IMPORTING
    return       = wa_return
    bankcountry  = lv_cotry1
    bankkey      = lv_key1.

IF wa_return IS INITIAL.
  CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
ELSE.
  CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
ENDIF.
