*&---------------------------------------------------------------------*
*& Include          SAPMZSA1290_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    when 'SEARCH'.
      PERFORM get_meal_info USING zssa0090-carrid
                                  zssa0090-mealnumber
                            CHANGING zssa0091.
      PERFORM get_meal_text  USING zssa0090-carrid
                                   zssa0090-mealnumber
                                   sy-langu
                    CHANGING zssa0090-mealnumber_t.

  ENDCASE.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE  ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
