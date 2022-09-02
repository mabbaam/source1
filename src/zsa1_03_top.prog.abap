*&---------------------------------------------------------------------*
*& Include ZSA1_03_TOP                              - Report ZSA1_03
*&---------------------------------------------------------------------*
REPORT zsa1_03.


TABLES : mast.

DATA: BEGIN OF gs_data,
        matnr TYPE mast-matnr,
        maktx TYPE makt-maktx,
        stlan TYPE mast-stlan,
        stlnr TYPE mast-stlnr,
        stlal TYPE mast-stlal,
        mtart TYPE mara-mtart,
        matkl TYPE mara-matkl,
      END OF gs_data,

      gt_data LIKE TABLE OF gs_data.


"ALV

DATA : gv_okcode TYPE ok_code.

DATA : gcl_container TYPE REF TO cl_gui_docking_container,
       gcl_grid      TYPE REF TO cl_gui_alv_grid,
       gs_fcat       TYPE lvc_s_fcat,
       gt_fcat       TYPE lvc_t_fcat,
       gs_layout     type lvc_s_layo.
