*&---------------------------------------------------------------------*
*& Report ZRSA12_08
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_08.

PARAMETERS pa_code TYPE c LENGTH 4 DEFAULT 'SYNC'. "Default는 기본값 설정!
PARAMETERS pa_date TYPE sy-datum. " 습관적으로 sy-datum 쓰자.
DATA gv_cond_d1 LIKE pa_date.

gv_cond_d1 = sy-datum + 7. " sy-datum은 절대값임. 내일되면 날짜가 바뀐다.(이런것을 시스템변수p.263 라고 함)

CASE pa_code.
  WHEN 'SYNC'.
    IF pa_date > gv_cond_d1.
      WRITE 'ABAP Dictionary'(t02). " 텍스트 심볼도 습관적으로 하자
    ELSE.
      WRITE 'ABAP Workbench'(t01).
    ENDIF.

  WHEN OTHERS.
    WRITE '다음 기회에'(t03).
    EXIT. " 또는 Return
ENDCASE.
