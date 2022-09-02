*&---------------------------------------------------------------------*
*& Include          SAPMZSA1203_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM..
    WHEN 'BACK' OR 'CANC'.
      SET SCREEN 0.
      LEAVE SCREEN.

    WHEN 'SEARCH'.
      PERFORM get_airline_name USING gv_carrid
                               CHANGING gv_carrname.
      SET SCREEN 200.
      LEAVE SCREEN.
    WHEN OTHERS.

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
*    WHEN 'BACK'.
*
*      MESSAGE i000(zmca12) WITH 'BACK'.
*      SET SCREEN 100.

      MESSAGE i000(zmca12) WITH 'BACK'.
      LEAVE TO SCREEN 100.

  ENDCASE.

ENDMODULE.
