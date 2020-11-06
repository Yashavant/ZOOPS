*&---------------------------------------------------------------------*
*& Report ZMM_MATERIAL_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmm_material_report.
DATA: ls_marc TYPE marc.

SELECT-OPTIONS: s_matnr FOR ls_marc-matnr,
                s_werks FOR ls_marc-werks.

CLASS lcl_material DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_mara,
             matnr TYPE mara-matnr,
             mtart TYPE mara-mtart,
             mbrsh TYPE mara-mbrsh,
             matkl TYPE mara-matkl,
             meins TYPE mara-meins,
             brgew TYPE mara-brgew,
             ntgew TYPE mara-ntgew,
             volum TYPE mara-volum,
             voleh TYPE mara-voleh,
             werks TYPE marc-werks,
             ekgrp TYPE marc-ekgrp,
           END OF ty_mara,
           BEGIN OF ty_mard,
             matnr TYPE mard-matnr,
             werks TYPE mard-werks,
             lgort TYPE mard-lgort,
             lfgja TYPE mard-lfgja,
             lfmon TYPE mard-lfmon,
             labst TYPE mard-labst,
           END OF ty_mard.

    TYPES: BEGIN OF ty_final,
             matnr TYPE mara-matnr,
             werks TYPE marc-werks,
             lgort TYPE mard-lgort,
             mtart TYPE mara-mtart,
             mbrsh TYPE mara-mbrsh,
             matkl TYPE mara-matkl,
             meins TYPE mara-meins,
             brgew TYPE mara-brgew,
             ntgew TYPE mara-ntgew,
             volum TYPE mara-volum,
             voleh TYPE mara-voleh,
             ekgrp TYPE marc-ekgrp,
             lfgja TYPE mard-lfgja,
             lfmon TYPE mard-lfmon,
             labst TYPE mard-labst,
           END OF ty_final.
    CLASS-METHODS: run.
  PRIVATE SECTION.
    METHODS:get_meterial_data,
      material_data_process,
      display_material_data.
    DATA: it_mara  TYPE STANDARD TABLE OF ty_mara,
          it_mard  TYPE STANDARD TABLE OF ty_mard,
          it_final TYPE STANDARD TABLE OF ty_final,
          ls_final TYPE ty_final.
ENDCLASS.
CLASS lcl_material IMPLEMENTATION.
  METHOD run.
    DATA(lo_mat) = NEW lcl_material( ).
    lo_mat->get_meterial_data( ).
  ENDMETHOD.
  METHOD get_meterial_data.
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
      INTO TABLE it_mara
     WHERE m~matnr IN s_matnr
       AND r~werks IN s_werks.
    IF it_mara IS NOT INITIAL.
      SELECT matnr
             werks
             lgort
             lfgja
             lfmon
             labst
        FROM mard
        INTO TABLE it_mard
         FOR ALL ENTRIES IN it_mara
       WHERE matnr = it_mara-matnr
         AND werks = it_mara-werks.
    ENDIF.

    material_data_process( ).

  ENDMETHOD.
  METHOD material_data_process.
    LOOP AT it_mard INTO DATA(ls_mard).
      ls_final-lgort = ls_mard-lgort.
      ls_final-lfgja = ls_mard-lfgja.
      ls_final-lfmon = ls_mard-lfmon.
      ls_final-labst = ls_mard-labst.
      READ TABLE it_mara INTO DATA(ls_mara)
                     WITH KEY matnr = ls_mard-matnr
                              werks = ls_mard-werks.
      IF sy-subrc EQ 0.
        ls_final-matnr = ls_mara-matnr.
        ls_final-mtart = ls_mara-mtart.
        ls_final-mbrsh = ls_mara-mbrsh.
        ls_final-matkl = ls_mara-matkl.
        ls_final-meins = ls_mara-meins.
        ls_final-brgew = ls_mara-brgew.
        ls_final-ntgew = ls_mara-ntgew.
        ls_final-volum = ls_mara-volum.
        ls_final-voleh = ls_mara-voleh.
        ls_final-werks = ls_mara-werks.
        ls_final-ekgrp = ls_mara-ekgrp.
      ENDIF.
      APPEND ls_final TO it_final.
      CLEAR: ls_final.
    ENDLOOP.

    IF it_final IS NOT INITIAL.
      display_material_data( ).
    ELSE.
      MESSAGE 'No Data found' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ENDMETHOD.
  METHOD display_material_data.
    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table   =  DATA(lo_alv)
          CHANGING
            t_table        = it_final
        ).
      CATCH cx_salv_msg. " ALV: General Error Class with Message
    ENDTRY.
    lo_alv->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_material=>run( ).
