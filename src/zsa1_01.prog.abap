*&---------------------------------------------------------------------*
*& Report ZSA1_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsa1_01.

TABLES : mara, marc.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.

  PARAMETERS : pa_werks TYPE mkal-werks DEFAULT '1010',
               pa_berid TYPE pbid-berid DEFAULT '1010',
               pa_pbdnr TYPE pbid-pbdnr,
               pa_versb TYPE pbid-versb DEFAULT '00'.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN ULINE.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-t02.

  PARAMETERS : pa_crt  RADIOBUTTON GROUP rb1 DEFAULT 'X' USER-COMMAND mod,
               pa_disp RADIOBUTTON GROUP rb1.

SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN ULINE.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-t03.

  SELECT-OPTIONS : so_matnr FOR mara-matnr MODIF ID mar,
                   so_mtart FOR mara-mtart MODIF ID mar,
                   so_matkl FOR mara-matkl MODIF ID mar,
                   so_ekgrp FOR marc-ekgrp MODIF ID mac.

  PARAMETERS : pa_dispo TYPE marc-dispo MODIF ID mac,
               pa_dismm TYPE marc-dismm MODIF ID mac.


SELECTION-SCREEN END OF BLOCK b3.

AT SELECTION-SCREEN OUTPUT.
  PERFORM modify_screen.

FORM modify_screen.

  LOOP AT SCREEN.
    CASE screen-name.
      WHEN 'PA_PBDNR' OR 'PA_VERSB'.
        screen-input = 0.
        MODIFY SCREEN.
    ENDCASE.

    CASE 'X'.
      WHEN pa_crt.
        CASE  screen-group1.
          WHEN 'MAC'.
            screen-active = 0.
            MODIFY SCREEN.
        ENDCASE.

      WHEN pa_disp.
        CASE  screen-group1.
          WHEN 'MAR'.
            screen-active = 0.
            MODIFY SCREEN.
        ENDCASE.
    ENDCASE.
  ENDLOOP.
ENDFORM.




DATA : ok_code TYPE sy-ucomm.

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
