*&---------------------------------------------------------------------*
*& Include          MZSA12020_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'S100'.
 SET TITLEBAR 'T100'.
ENDMODULE.


MODULE set_default OUTPUT.
  IF zssa0060 IS INITIAL.
    zssa0060-carrid = 'AA'.
    zssa0060-connid = '0017'.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MODIFY_SCREEN_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE modify_screen_0100 OUTPUT.
 LOOP AT SCREEN.
   CASE screen-name.
     WHEN 'ZSSA0060-CARRID'.
       IF sy-uname <> 'KD-A-12'.
*         screen-input = 0.
         screen-active = 0.
       ELSE.
*         screen-input = 1.
         screen-active = 1.
       ENDIF.
   ENDCASE.

   MODIFY SCREEN.
   CLEAR screen.
 ENDLOOP.
ENDMODULE.
