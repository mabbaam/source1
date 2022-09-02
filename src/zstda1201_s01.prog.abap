*&---------------------------------------------------------------------*
*& Include          ZSTDA1201_S01
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.

  SELECT-OPTIONS : so_carr FOR scarr-carrid,
                   so_conn for sflight-connid,
                   so_plan FOR sflight-planetype NO-EXTENSION NO INTERVALS.

SELECTION-SCREEN END OF BLOCK b1.
