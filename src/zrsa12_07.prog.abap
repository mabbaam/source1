*&---------------------------------------------------------------------*
*& Report ZRSA12_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_07.

PARAMETERS pa_date TYPE d.

WRITE 'TODAY:'.

DATA gv_result LIKE pa_date.

MOVE pa_date TO gv_result.

*ADD 1 TO gv_result.
*
*gv_result =  pa_date - 1.

WRITE 'ABAP Workbench'.
IF pa_date >= pa_date + 7 .
  WRITE 'ABAP Dictionary'.

ENDIF.


WRITE pa_date.
NEW-LINE.
WRITE gv_result.
