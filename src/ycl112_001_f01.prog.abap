*&---------------------------------------------------------------------*
*& Include          YCL112_001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form select_data
*&---------------------------------------------------------------------*
FORM select_data .

refresh gt_scarr.  "인터널테이블의 내용을 초기화 하겠다

 select *
   FROM scarr
   WHERE carrid   in @S_CARRID   "셀렉트옵션은 in 이라는 문법이 들어온다.
   and   carrname in @S_CARRNM
   into TABLE @gt_scarr.

sort gt_scarr by carrid.

ENDFORM.
