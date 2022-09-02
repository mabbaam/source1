*&---------------------------------------------------------------------*
*& Report ZRCA12_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRCA12_01.

DATA gv_num TYPE i.

DO 6 times.
  gv_num = gv_num + 1.
  write sy-index. "대시가 붙으면 스트럭쳐변수. 일단은 흘려듣기
  if gv_num > 3.
    exit.
    endif.

  WRITE gv_num.
  new-line.


  ENDDO.



*DATA gv_gender type c LENGTH 1. "타입을 젠더로도 많으 쓴다. /M ,F ...
*
*gv_gender = 'X'.
*
*case gv_gender.
*  When 'M'.
*
*  When 'F'.
*
*  When OTHERS.
*
*  ENDCASE.
*
*IF gv_gender = 'M'. " 요구사항에 예외도 생각해봐야한다.
*
*  ELSEIF gv_gender = 'F'.
*
*  ELSE.
*
*  ENDIF.

*gv_gender = 'F'.
