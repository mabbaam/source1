*&---------------------------------------------------------------------*
*& Report ZRSA12_15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_15.

DATA: BEGIN OF gs_std,
        stdno    TYPE n LENGTH 8,
        sname    TYPE c LENGTH 40,
        gender   TYPE c LENGTH 1,
        gender_t TYPE c LENGTH 10, "사용자에서 보여지는 ... 다국어를 생각해서 길이를 길게!
      END OF gs_std.

DATA gt_std LIKE TABLE OF gs_std.

gs_std-stdno = '20220001'.
gs_std-sname = 'KANG'.
gs_std-gender = 'M'.
APPEND gs_std TO gt_std.

CLEAR gs_std.
gs_std-stdno = '20220002'.
gs_std-sname = 'HAN'.
gs_std-gender = 'F'.
APPEND gs_std TO gt_std.
CLEAR gs_std.


LOOP AT gt_std INTO gs_std.
  "CASE ... or IF ...
  gs_std-gender_t = 'Male'(t01). "t01은 텍스트심볼
  MODIFY gt_std FROM gs_std. "INDEX st-tabix.  "gs_std를 가지고 gt_std를 변경하세요
  CLEAR gs_std.
ENDLOOP.

*MODIFY gt_std FROM gs_std INDEX 2.

cl_demo_output=>display_data( gt_std ). "나중에 배운다... 클래스 ... 등등



*LOOP AT gt_std INTO gs_std. "인터널테이블의 값을 스트럭쳐변수에 담아라
*  WRITE: sy-tabix, gs_std-stdno,
*        gs_std-sname, gs_std-gender.
*  NEW-LINE.
*  CLEAR gs_std. "루프(반복문)은 클리어 잘 써야한다!
*ENDLOOP.
*WRITE:/ sy-tabix, gs_std-stdno,
*        gs_std-sname, gs_std-gender.

"Read 첫번째 방법
*CLEAR gs_std.
*READ TABLE gt_std INDEX 1 INTO gs_std.

"Read 두번째 방법
READ TABLE gt_std WITH KEY stdno = '20200001'  "키 값이기 때문에 유니크한 값일 확률높다
*                           gender = 'M'
INTO gs_std.
