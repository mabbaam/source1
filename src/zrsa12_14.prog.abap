*&---------------------------------------------------------------------*
*& Report ZRSA12_14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_14.
"Transparent Table = Structure Type
DATA gs_scarr TYPE scarr.

PARAMETERS pa_carr LIKE gs_scarr-carrid.

SELECT SINGLE carrid carrname currcode
  FROM scarr
  INTO gs_scarr
  WHERE carrid = pa_carr.

WRITE: gs_scarr-carrid, gs_scarr-carrname, gs_scarr-currcode.












*TYPES: BEGIN OF ts_cat,
*         home TYPE c LENGTH 10,
*         name TYPE c LENGTH 10,
*         age  TYPE i,
*       END OF ts_cat.
*
*DATA gs_cat TYPE ts_cat.
*
**DATA xxx TYPE ts_cat-age. "일반변수
**
**DATA xxx like gs_cat. "스트럭쳐변수
*
*
**DATA: gv_cat_name TYPE c LENGTH 10,
**      gv_cat_age  TYPE i.
**
**DATA: BEGIN OF gs_cat,
**        name TYPE c LENGTH 10,
**        age  TYPE i,
**      END OF gs_cat.
**
*
**WRITE gs_cat-age.
*
*gs_cat-age = 2.
*IF gs_cat IS not INITIAL.
*  WRITE 'Check'.
*
*ENDIF.
