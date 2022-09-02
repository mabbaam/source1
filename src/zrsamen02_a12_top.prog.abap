*&---------------------------------------------------------------------*
*& Include ZRSAMEN02_A12_TOP                        - Report ZRSAMEN02_A12
*&---------------------------------------------------------------------*
REPORT zrsamen02_a12.

TABLES zssa19fl.

types: BEGIN OF tp_sfli.
    INCLUDE TYPE sflight.
    types: carrname TYPE scarr-carrname,
    end of tp_sfli.


"ALV
data: go_container_high type ref to cl_gui_custom_container,
      go_alv_grid_high TYPE ref to cl_gui_alv_grid,

      go_container_low type ref to cl_gui_custom_container,
      go_alv_grid_low TYPE ref to cl_gui_alv_grid.


"테이블관련 변수

data: gs_sflight TYPE tp_sfli,
      gt_sflight_high LIKE TABLE OF gs_sflight,
      gt_sflight_low like TABLE OF gs_sflight.


SELECTION-SCREEN BEGIN OF BLOCK con WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS so_car FOR zssa19fl-carrid NO-EXTENSION. "옵션을 사용하지 않겠다
  SELECT-OPTIONS so_con FOR zssa19fl-connid NO-EXTENSION.
  SELECT-OPTIONS so_fld FOR zssa19fl-fldate NO-EXTENSION.
SELECTION-SCREEN END OF BLOCK con.
