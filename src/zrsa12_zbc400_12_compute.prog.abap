*&---------------------------------------------------------------------*
*& Report ZRSA12_ZBC400_12_COMPUTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_zbc400_12_compute.

*PARAMETERS pa_int1 TYPE i.
*PARAMETERS pa_int2 TYPE i.
*
*PARAMETERS pa_op TYPE c.
*
*data gv_result TYPE p LENGTH 16 DECIMALS 2.


PARAMETERS pa_int1 TYPE i.
PARAMETERS pa_int2 TYPE i.
PARAMETERS pa_op TYPE c.

DATA gv_result TYPE p LENGTH 16 DECIMALS 2.


IF pa_op = '+'.

  gv_result = pa_int1 + pa_int2.
  WRITE gv_result.
  CLEAR gv_result.

ELSEIF pa_op = '-'.

  gv_result = pa_int1 - pa_int2.
  WRITE gv_result.
  CLEAR gv_result.

ELSEIF pa_op = '*'.

  gv_result = pa_int1 * pa_int2.
  WRITE gv_result.
  CLEAR gv_result.
ELSEIF pa_op = '/'.

  gv_result = pa_int1 / pa_int2.
  WRITE gv_result.
  CLEAR gv_result.

  IF pa_int2 = 0.
    WRITE '0을 나눌 수 없습니다.'.
  ENDIF.

ELSE.

  WRITE '잘못된 연산기호를 입력하셨습니다.'.

ENDIF.
