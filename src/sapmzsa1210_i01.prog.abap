*&---------------------------------------------------------------------*
*& Include          SAPMZSA1210_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
CASE sy-ucomm.
  WHEN 'BACK'.
    Leave to SCREEN 0.
    when 'SEARCH'.

      PERFORM get_airline_info.

      PERFORM get_conn_info USING zssa1280-carrid
                                  zssa1280-connid
                              CHANGING zssa0082.

*	WHEN 'ENTER'.

ENDCASE.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
CASE sy-ucomm.
  WHEN 'EXIT'.
    Leave program.
  WHEN 'CANC'.
    LEAVE to SCREEN 0.

ENDCASE.
ENDMODULE.
