*&---------------------------------------------------------------------*
*& Include SAPMZSA1204_TOP                          - Module Pool      SAPMZSA1204
*&---------------------------------------------------------------------*
PROGRAM sapmzsa1204.

"Condition 이라는 변수선언
"tables 을 만들라면 스트럭처를 만들어야 한다.
TABLES zssa0073.
DATA gs_cond TYPE zssa0073. " 이렇게 만들어주면 좋다. (권장사항)


" Employee Info
TABLES Zssa0070.
DATA gs_emp TYPE zssa0070.

"Dep info
TABLES zssa0071.
DATA gs_dep TYPE zssa0071.

"Radio Button
data: gv_r1 TYPE c LENGTH 1,
      gv_r2(1),
      gv_r3.
