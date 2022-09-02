*&---------------------------------------------------------------------*
*& Include ZRSA12_50_TOP                            - Report ZRSA12_50
*&---------------------------------------------------------------------*
REPORT zrsa12_50.

TABLES: scarr, spfli, sflight. "DATA scarr TYPE scarr.

PARAMETERS : pa_car LIKE scarr-carrid,
             pa_con LIKE spfli-connid.

SELECT-OPTIONS so_dat FOR sflight-fldate. "for 다음에는 변수만 올 수 있다.
