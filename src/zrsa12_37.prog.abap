*&---------------------------------------------------------------------*
*& Report ZRSA12_37
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_37.

DATA: gs_info TYPE zvsa0002, "Databse View
      gt_info LIKE TABLE OF gs_info.

PARAMETERS pa_dep LIKE gs_info-depid.

START-OF-SELECTION.

SELECt *
  from ztsa0002 as dep left OUTER join ztsa0001 as emp
  on dep~depid = emp~depid
into CORRESPONDING FIELDS OF TABLE gt_info.



  cl_demo_output=>display_data( gt_info ).
