class ZCL_ASSERT_EXAMPLE definition
  public
  create public .

public section.

  methods GET_STRING
    importing
      !IM_STRING type CHAR20
    exporting
      !EX_STRING type CHAR20 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ASSERT_EXAMPLE IMPLEMENTATION.


  METHOD get_string.
    IF im_string IS NOT INITIAL.
      IF im_string CP 'Hello'.
        ex_string = 'World'.
      ELSEIF im_string NP 'Hello'.
       ex_string = 'ABAP Coding'.
        ELSE.
        ex_string = im_string.
      ENDIF.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
