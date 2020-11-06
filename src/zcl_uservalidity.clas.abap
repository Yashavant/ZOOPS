class ZCL_USERVALIDITY definition
  public
  final
  create public .

public section.

  types:
    TT_USERDAYS TYPE STANDARD TABLE OF ZUSERDAYS .

  data USERNAME type BNAME .
  data DAYS type I .
  data USERDAYS type TT_USERDAYS .

  methods CONSTRUCTOR .
  methods CHECK_USERENDATE_UPD_NEEDED
    importing
      !USERID type XUBNAME
      !DAYS type PEA_SCRDD
      !STARTDATE type SY-DATUM
    exporting
      !R_RESULT type STRING
      !R_NEWENDDATE type SY-DATUM .
protected section.
private section.
ENDCLASS.



CLASS ZCL_USERVALIDITY IMPLEMENTATION.


  METHOD check_userendate_upd_needed.
    DATA:ls_userdays TYPE zuserdays,
         uname       TYPE bname.
    uname = userid+0(3).
    READ TABLE userdays INTO ls_userdays WITH KEY username = uname .
    IF sy-subrc EQ 0.
      IF ls_userdays-zdays > days.
        r_result = 'N'.
      ELSE.
        r_result = 'Y'.
        r_newenddate = startdate + ls_userdays-zdays.
      ENDIF.
    ELSE.
      r_result = 'N'.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.
    SELECT * FROM zuserdays INTO TABLE userdays.
  ENDMETHOD.
ENDCLASS.
