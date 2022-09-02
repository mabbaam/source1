*&---------------------------------------------------------------------*
*& Include          MZSA1201_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.
      when 'SEARCH'.
        CLEAR zssa0031.
        SELect SINGLE *
          FROM ztsa0001 as a INNER JOIN ztsa0002 as b
          on a~depid = b~depid
          into CORRESPONDING FIELDS OF zssa0031
          WHERE a~pernr = gv_pernr.
  ENDCASE.

ENDMODULE.
