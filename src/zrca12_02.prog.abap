*&---------------------------------------------------------------------*
*& Report ZRCA12_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrca12_02.
DATA gv_step TYPE i.
DATA gv_cal TYPE i.
DATA gv_lev TYPE i.

PARAMETERS pa_req LIKE gv_lev.
PARAMETERS pa_ayear(1) TYPE c.
DATA gv_new_lev LIKE gv_lev.

CASE pa_ayear.
  WHEN '1'.
    IF pa_req >= 3.
      gv_new_lev = 3.
    ELSE.
      gv_new_lev = pa_req.
    ENDIF.


  WHEN OTHERS.

MESSAGE 'Message Test' TYPE 'S'.

ENDCASE.


DO gv_new_lev TIMES.
  gv_lev = gv_lev + 1.
  CLEAR gv_step.
  DO 9 TIMES.
    gv_step = gv_step + 1.
    gv_cal = gv_lev * gv_step.
    WRITE: gv_lev, ' * ' , gv_step, ' = ', gv_cal.
    NEW-LINE.
  ENDDO.
  CLEAR gv_step. " clear를 심하게 쓴 상태. 여기에서는 둘중에 하나만 써도 된다.
  WRITE ' ========== '.
  NEW-LINE.
ENDDO.
