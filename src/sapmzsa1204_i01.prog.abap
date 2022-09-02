*&---------------------------------------------------------------------*
*& Include          SAPMZSA1204_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
*message i016(pn) WITH sy-ucomm.


  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'ENTER'.
      "get emp name
      PERFORM get_emp_name USING zssa0073-pernr
                           CHANGING zssa0073-ename.

    WHEN 'SEARCH'.
      "get emp name
      PERFORM get_emp_name USING zssa0073-pernr
                         CHANGING zssa0073-ename.
      "get Employee info
      PERFORM get_emp_info USING zssa0073-pernr
                           CHANGING zssa0070.

    WHEN 'DEP'."popup
      CALL SCREEN 101 STARTING AT 10 10.



*      CLEAR zssa0073-ename.
*      SELECT SINGLE ename
*        FROM ztsa0001
*        INTO zssa0073-ename
*        WHERE pernr = zssa0073-pernr.

  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0101  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0101 INPUT.


  CASE sy-ucomm.
    WHEN 'CLOSE'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
