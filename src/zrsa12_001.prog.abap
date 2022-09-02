*&---------------------------------------------------------------------*
*& Report ZRSA12_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_001.


*PARAMETERS pa_num TYPE i.
*
*DO 5 TIMES.
*  WRITE pa_num.
*  pa_num = pa_num + 1.
*
*ENDDO.



*PARAMETERS: pa_name TYPE scarr-carrid.
*DATA: gs_aa TYPE scarr.
*
*select SINGLE carrid carrname
*  from scarr
*  into CORRESPONDING FIELDS OF gs_aa
*  where carrid = pa_name.
*
*  WRITE: gs_aa-carrid, gs_aa-carrname.


PARAMETERS: pa_da1 TYPE i,
            pa_da2 TYPE c,
            pa_da3 TYPE i.

DATA lv_cal TYPE p LENGTH 16 DECIMALS 2.

CASE pa_da2.
  WHEN '+'.
    lv_cal = pa_da1 + pa_da3.
  WHEN '-'.
    lv_cal = pa_da1 - pa_da3.
  WHEN '*'.
    lv_cal = pa_da1 * pa_da3.
  WHEN '/'.
    lv_cal = pa_da1 / pa_da3.

  WHEN OTHERS.
ENDCASE.

WRITE : lv_cal.
