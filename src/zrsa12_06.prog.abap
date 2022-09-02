*&---------------------------------------------------------------------*
*& Report ZRSA12_06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_06.

PARAMETERS pa_i TYPE i.
"A,B,C,D 만 입력가능.
PARAMETERS pa_class TYPE c LENGTH 1.
DATA gv_result LIKE pa_i.


*10보다 크면 출력
*20보다 크다면, 10을 추가로 더해서 출력하세요.
*A반이라면,입력한 값에 모두 100을 추가하세요.

IF pa_i > 20.
  gv_result = pa_i + 10.
ELSEIF pa_i > 10.
  gv_result = pa_i.
ELSE.

ENDIF.

CASE pa_class.
  WHEN 'A'.
    gv_result = pa_i + 100.
  WHEN OTHERS. "else와 같은 느낌!

ENDCASE.


*IF pa_i > 20.
*
*  ELSEIF pa_i > 10.
*
*  ELSE.
*
*ENDIF.




*IF pa_i > 20.
*
*  gv_result = pa_i + 10.
*  WRITE gv_result.
*
*ELSE. "아니라면
*  IF pa_i > 10.
*    WRITE pa_i.
*
*  ENDIF.
*
*ENDIF.
