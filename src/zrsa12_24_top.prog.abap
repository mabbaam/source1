*&---------------------------------------------------------------------*
*& Include ZRSA12_24_TOP                            - Report ZRSA12_24
*&---------------------------------------------------------------------*
REPORT zrsa12_24.

"스트럭쳐 변수와 인터널테이블 선언
DATA: gs_info TYPE zsinfo00,
      gt_info LIKE TABLE OF gs_info.

"셀렉션 스크린을 선언
PARAMETERS: pa_car TYPE scarr-carrid,
            pa_con TYPE spfli-connid,
            pa_dat TYPE sflight-fldate.

*PARAMETERS: pa_car TYPE sbook-carrid,
*            pa_con TYPE sbook-connid,
*            pa_dat TYPE sbook-fldate.
