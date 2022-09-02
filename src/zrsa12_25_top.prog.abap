*&---------------------------------------------------------------------*
*& Include ZRSA12_25_TOP                            - Report ZRSA12_25
*&---------------------------------------------------------------------*
REPORT zrsa12_25.


" Sch Date Info
DATA: gt_info TYPE TABLE OF zsinfo00,
      gs_info LIKE LINE OF gt_info.

*Selection Screen
PARAMETERS: pa_car LIKE sbook-carrid, "DEFAULT 'AA'
            pa_con LIKE sbook-connid. "DEFAULT '0017'
