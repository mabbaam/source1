*&---------------------------------------------------------------------*
*& Module Pool      SAPMZSA1204
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE SAPMZSA1205_TOP.
*INCLUDE sapmzsa1204_top                         .    " Global Data

INCLUDE SAPMZSA1205_O01.
*INCLUDE sapmzsa1204_o01                         .  " PBO-Modules
INCLUDE SAPMZSA1205_I01.
*INCLUDE sapmzsa1204_i01                         .  " PAI-Modules
INCLUDE SAPMZSA1205_F01.
*INCLUDE sapmzsa1204_f01                         .  " FORM-Routines

LOAD-OF-PROGRAM.

perform set_default CHANGING zssa0073 .


*  SELECT pernr ename
*
*
*    FROM ztsa0001 UP TO 1 ROWS "반복을 한번만 돌아라// 속도가 더 빠름
*    INTO CORRESPONDING FIELDS OF zssa0073.
*
*  ENDSELECT.
