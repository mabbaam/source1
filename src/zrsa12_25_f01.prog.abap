*&---------------------------------------------------------------------*
*& Include          ZRSA12_25_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_date
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_date .
 CLEAR gt_info.
  SELECT *
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_info
    WHERE carrid = pa_car
      AND connid = pa_con.

  CLEAR gs_info.
  LOOP AT gt_info INTO gs_info.
    "Get Airline name
    SELECT SINGLE carrname
     FROM scarr
      INTO gs_info-carrname
      WHERE carrid = gs_info-carrid.
    "Get Connection Info
    SELECT SINGLE cityfrom cityto   "openSQL 에서는 , 안쓴다
      FROM spfli
*      INTO CORRESPONDING FIELDS OF gs_info
      INTO ( gs_info-cityfrom, gs_info-cityto ) " 이 경우에는 순서가 중요하다!
      WHERE carrid = gs_info-carrid
      AND connid = gs_info-connid.

    MODIFY gt_info FROM gs_info. "index sy-tabix.
    CLEAR gs_info.
  ENDLOOP.

ENDFORM.
