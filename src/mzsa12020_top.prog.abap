*&---------------------------------------------------------------------*
*& Include MZSA12020_TOP                            - Module Pool      SAPMZSA12020
*&---------------------------------------------------------------------*
PROGRAM sapmzsa12020.

DATA: BEGIN OF gs_cond,
        carrid TYPE sflight-carrid,
        connid TYPE sflight-connid,
      END OF gs_cond.  "스트럽처 타입!


      " Condition
TABLES zssa0060.
" Global 형태

DATA ok_code LIKE sy-ucomm.
