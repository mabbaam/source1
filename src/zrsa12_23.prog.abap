*&---------------------------------------------------------------------*
*& Report ZRSA12_23
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_23.

DATA: BEGIN OF gs_info,
        carrid   TYPE zsinfo-carrid,
        carrname TYPE zsinfo-carrname,
        connid   TYPE zsinfo-connid,
        cityfrom TYPE zsinfo-cityfrom,
        cityro   TYPE zsinfo-cityto,
      END OF gs_info.

DATA gt_info LIKE TABLE OF gs_info.

PARAMETERS pa_air LIKE zsinfo-carrid.

SELECT *
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_info
  WHERE carrid = pa_air.


LOOP AT gt_info INTO gs_info.
  SELECT SINGLE carrname
    FROM scarr
    INTO gs_info-carrname
    WHERE carrid = gs_info-carrid.

  MODIFY gt_info FROM gs_info.
  CLEAR gs_info.

ENDLOOP.

cl_demo_output=>display_data( gt_info ).
