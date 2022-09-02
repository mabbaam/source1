*&---------------------------------------------------------------------*
*& Include ZC1R120002_TOP                           - Report ZC1R120002
*&---------------------------------------------------------------------*
REPORT zc1r120002 MESSAGE-ID zc226.

TABLES : ztsa1201.


DATA : BEGIN OF gs_data,
         pernr  TYPE ztsa1201-pernr,
         ename  TYPE ztsa1201-ename,
         gender TYPE ztsa1201-gender,
         entdt  TYPE ztsa1201-entdt,
         depid  TYPE ztsa1201-depid,
       END OF gs_data,

       gt_data LIKE TABLE OF gs_data.

"ALV
DATA : gcl_container TYPE REF TO cl_gui_docking_container,
       gcl_grid      TYPE REF TO cl_gui_alv_grid,
       gs_fcat       TYPE lvc_s_fcat,
       gt_fcat       TYPE lvc_t_fcat,
       gs_layout     TYPE lvc_s_layo,
       gs_variant    TYPE disvariant,
       gs_stable     TYPE lvc_s_stbl.

DATA:  gv_okcode TYPE ok_code.
