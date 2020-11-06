class ZCL_TRIANGLE_1 definition
  public
  final
  create public .

public section.

  methods GET_TRIANGLE_TYPE
    importing
      !IM_S1 type I
      !IM_S2 type I
      !IM_S3 type I
    returning
      value(EX_RES) type CHAR20 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_TRIANGLE_1 IMPLEMENTATION.


  METHOD GET_TRIANGLE_TYPE.
    IF ( im_s1 NE im_s2 ) AND ( im_s2 NE im_s3 ) AND ( im_s1 NE im_s3 ).
      ex_res = 'Scalene'.
      ELSEIF ( im_s1 EQ im_s2 AND im_s2 NE im_s3 ) OR
             ( im_s2 EQ im_s3 AND im_s3 NE im_s1 ) OR
             ( im_s1 EQ im_s3 AND im_s1 NE im_s2 ).
      ex_res = 'Isosceles'.
      ELSEIF ( im_s1 EQ im_s2 AND im_s2 eq im_s3 ).
      ex_res = 'Equilateral'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
