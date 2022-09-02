*&---------------------------------------------------------------------*
*& Include          SAPMZSA1209_I01
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
    WHEN 'ENTER'.
      PERFORM get_emp_name USING zssa0073-pernr
                           CHANGING zssa0073-ename.

*      CLEAR zssa0073-ename.
*      SELECT SINGLE ename
*        FROM ztsa0001
*        INTO zssa0073-ename
*        WHERE pernr = zssa0073-pernr.


  ENDCASE.


ENDMODULE.
