*&---------------------------------------------------------------------*
*& Include          SAPMZSA1250_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_meal_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_msub_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_mealN_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_mealN_info . " 이름


  SELECT SINGLE *
    FROM scarr
    INTO CORRESPONDING FIELDS OF zssa1251
    WHERE carrid = zssa1250-carrid.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_mealP_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_mealP_info .  "가격

  SELECT SINGLE *
    FROM ztsa12ven
    INTO CORRESPONDING FIELDS OF zssa1251
    WHERE carrid = zssa1250-carrid
    and mealno = zssa1250-mealno.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_ven_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_ven_info . "벤더정보

  SELECT SINGLE *
    FROM ztsa12ven
    INTO CORRESPONDING FIELDS OF zssa1252
    WHERE carrid = zssa1250-carrid
    AND mealno = zssa1250-mealno.



ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_mealF_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_mealF_info . "음식이름


  SELECT SINGLE text

      FROM smealt
    INTO CORRESPONDING FIELDS OF zssa1251
    WHERE carrid = zssa1250-carrid
      AND mealnumber = zssa1250-mealno.


ENDFORM.
