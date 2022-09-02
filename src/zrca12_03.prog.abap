*&---------------------------------------------------------------------*
*& Report ZRCA12_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrca12_03.

PARAMETERS pa_car TYPE scarr-carrid. "Char 3
*PARAMETERS pa_car1 TYPE c LENGTH 3.

DATA gs_info TYPE scarr. "s의 약자는 스트럭쳐 g는 글로벌
* 스트럭쳐는 변수가 여러개인것.(일반변수를 모아놓은 것.)

CLEAR gs_info.

SELECT SINGLE carrid carrname
FROM scarr
INTO CORRESPONDING FIELDS OF gs_info "순서대로 똑같이 넣어주세요
*  into gs_info "이게더 빠르지만, 정확하지 않을 수 있다. 인트 코레스폰딩필드 쓰자.
  WHERE carrid = pa_car.

write: gs_info-mandt, gs_info-carrid, gs_info-carrname.
