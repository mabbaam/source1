*&---------------------------------------------------------------------*
*& Report ZRSA12_25
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
INCLUDE zrsa12_25_top                           .    " Global Data

* INCLUDE ZRSA12_25_O01                           .  " PBO-Modules
* INCLUDE ZRSA12_25_I01                           .  " PAI-Modules
INCLUDE zrsa12_25_f01                           .  " FORM-Routines
"Event

*load-of-PROGRAM.
INITIALIZATION. "Runtime(프로그램시작)시 딱 한번만 실행
  IF sy-uname = 'KD-A-12'.
    pa_car = 'AA'.
    pa_con = '0017'.
  ENDIF.

AT SELECTION-SCREEN OUTPUT. " PBO 역할을 한다

AT SELECTION-SCREEN. " PAI
  IF pa_con IS INITIAL.
*      MESSAGE w016(pn) WITH 'Check'.

    MESSAGE i016(pn) WITH 'Check'.
    STOP.
  ENDIF.

START-OF-SELECTION.

  PERFORM get_date.
  WRITE 'TEST'. "테스트용
  IF gt_info IS INITIAL.
    "S ,I, E, W, A, X  총6가지의 타입이 있다.
    MESSAGE e016(pn) WITH 'Data is not found.'.
    RETURN.
  ENDIF.


*  IF gt_info IS NOT INITIAL. "값이 비어있지 않으면 출력해라
*    cl_demo_output=>display_data( gt_info ).
*  ELSE.
*  ENDIF.
