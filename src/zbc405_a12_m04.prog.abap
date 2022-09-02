*&---------------------------------------------------------------------*
*& Report ZBC405_A12_M04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a12_m04_top                      .    " Global Data

* INCLUDE ZBC405_A12_M04_O01                      .  " PBO-Modules
* INCLUDE ZBC405_A12_M04_I01                      .  " PAI-Modules
* INCLUDE ZBC405_A12_M04_F01                      .  " FORM-Routines

INITIALIZATION.

  gv_text = '버튼'.
  gv_chg = 1.

"tab 초기설정
 tab1 = 'car info'.
 tab2 = 'fldate'.
 ts_info-activetab = 'FLD'.
 ts_info-dynnr = '1200'.

 "flda 초기값 설정
* 20200808
 so_fld-low+0(4) = sy-datum+0(4) - 2.
 so_fld-low+4 = sy-datum+4.
* so_fld-high+0(4) = sy-datum+0(4).      "~~ +0(4) 0부터 4자리까지
* so_fld-high+4 = '1231'.
 so_fld-high = sy-datum+0(4) && '1231'.
* append so_fld to so_fld[].
* append so_fld to so_fld.
 append so_fld.

  "PBO

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    CASE screen-group1. "screen이라는 글로벌스트럭처 .. 그안에 group1
      WHEN 'GR1'.
        screen-active = gv_chg. "0은 기능을 사용하지 않는다. 1은 사용한다.
        MODIFY SCREEN.

    ENDCASE.
  ENDLOOP.


  "PAI

AT SELECTION-SCREEN.
  check sy-dynnr = '1000'. "서브스크린이 있다면 어느 pai인지 체크를 해줘야 제대로된다.
  CASE sscrfields-ucomm.
    WHEN 'ON'.
      CASE gv_chg.
        WHEN '1'.
          gv_chg = 0.
        WHEN '0'.
          gv_chg = 1.
      ENDCASE.

  ENDCASE.
