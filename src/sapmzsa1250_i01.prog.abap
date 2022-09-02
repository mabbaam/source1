*&---------------------------------------------------------------------*
*& Include          SAPMZSA1250_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.

    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'SEARCH'.

      CLEAR zssa1251.
      SELECT SINGLE *
        FROM smeal
        INTO CORRESPONDING FIELDS OF zssa1251
        WHERE carrid = zssa1250-carrid
          AND mealnumber = zssa1250-mealno.

        PERFORM get_mealN_info. "이름

        PERFORM get_mealP_info. "가격

        PERFORM get_mealF_info. "음식이름

        PERFORM get_ven_info. "벤더정보

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
