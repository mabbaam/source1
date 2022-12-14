*&---------------------------------------------------------------------*
*& Include ZBC405_A12_M04_TOP                       - Report ZBC405_A12_M04
*&---------------------------------------------------------------------*
REPORT zbc405_a12_m04.


SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME.
  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 3(8) TEXT-t01 FOR FIELD pa_rad1. "위치를 지정해줘야 한다.
    SELECTION-SCREEN POSITION 1.
    PARAMETERS: pa_rad1 RADIOBUTTON GROUP rg1 MODIF ID gr1.
    SELECTION-SCREEN COMMENT pos_low(9) TEXT-t01 FOR FIELD pa_rad2.
    PARAMETERS: pa_rad2 RADIOBUTTON GROUP rg1 MODIF ID gr1.

  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK bl1.

TABLES: sflight, sscrfields.

*SELECT-OPTIONS so_fld FOR sflight-fldate. "앞에 선언이 되어있어야 한다.

*SELECTION-SCREEN skip 1.
SELECTION-SCREEN PUSHBUTTON /1(10) gv_text USER-COMMAND on.

DATA gv_chg TYPE c LENGTH 1.

"SUBSCREEN
SELECTION-SCREEN BEGIN OF SCREEN 1100 as subscreen.
  PARAMETERS pa_car TYPE sflight-carrid.
  SELECTION-SCREEN end OF SCREEN 1100.

SELECTION-SCREEN BEGIN OF SCREEN 1200 as subscreen.
  SELECT-OPTIONS so_fld FOR sflight-fldate.
  SELECTION-SCREEN end OF SCREEN 1200.


"TAB STRIP
SELECTION-SCREEN BEGIN OF TABBED BLOCK ts_info FOR 5 LINES.
SELECTION-SCREEN tab (10) tab1 USER-COMMAND car DEFAULT SCREEN 1100.
SELECTION-SCREEN tab (10) tab2 USER-COMMAND fld DEFAULT SCREEN 1200.
SELECTION-SCREEN END OF BLOCK ts_info.
