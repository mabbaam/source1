*&---------------------------------------------------------------------*
*& Include          MZSA0090_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'ENTER'.
      " Get Airline Name
      PERFORM get_airline_name USING zssa0090-carrid
                               CHANGING zssa0090-carrname.
      " Get Meal Text
      PERFORM get_meal_text USING zssa0090-carrid
                                  zssa0090-mealnumber
                                  sy-langu
                            CHANGING zssa0090-mealnumber_t.
    WHEN 'SEARCH'.

      PERFORM get_meal_info USING zssa0090-carrid
                                  zssa0090-mealnumber
                            CHANGING zssa0091.
      PERFORM get_vendor_info USING 'M'
                                    zssa0090-carrid
                                    zssa0090-mealnumber
                              CHANGING zssa0093.

    WHEN OTHERS.

  ENDCASE.
ENDMODULE.
