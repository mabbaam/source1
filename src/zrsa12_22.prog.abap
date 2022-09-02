*&---------------------------------------------------------------------*
*& Report ZRSA12_22
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_22.

DATA : gs_list TYPE scarr,
       gt_list LIKE TABLE OF gs_list.

CLEAR: gt_list, gs_list.

SELECT carrid carrname
  FROM scarr
  INTO TABLE gt_list
  WHERE carrid BETWEEN 'AA' AND 'UA'.
  APPEND gs_list TO gt_list.
  CLEAR: gs_list.

*WRITE sy-subrc.
*WRITE sy-dbcnt.

cl_demo_output=>display_data( gt_list ).
