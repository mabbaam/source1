*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA1204
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE sapmzsa1204_top                         .    " Global Data

INCLUDE sapmzsa1204_o01                         .  " PBO-Modules
INCLUDE sapmzsa1204_i01                         .  " PAI-Modules
INCLUDE sapmzsa1204_f01                         .  " FORM-Routines

LOAD-OF-PROGRAM.

perform set_default CHANGING zssa0073 .
clear: gv_r1, gv_r2, gv_r3.
gv_r2 = 'X'.


*  SELECT pernr ename
*
*
*    FROM ztsa0001 UP TO 1 ROWS "반복을 한번만 돌아라// 속도가 더 빠름
*    INTO CORRESPONDING FIELDS OF zssa0073.
*
*  ENDSELECT.
