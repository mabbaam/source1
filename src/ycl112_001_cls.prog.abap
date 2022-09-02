*&---------------------------------------------------------------------*
*& Include          YCL112_001_CLS
*&---------------------------------------------------------------------*

"ALV
"1. LIST
"   ㄴ WRITE
"2. Functional ALV
"   ㄴ reuse
"3. Class ALV
"   ㄴ Simple ALV (SALV, 편집불가)
"   ㄴ Grid ALV   ( 대다수 사용)
"   ㄴ ALV with IDA ( 최신 )


" Container
" 1. custom container
" 2. docking container
" 3. Splitter container

DATA : gr_con     TYPE REF TO cl_gui_docking_container,
       gr_split   TYPE REF TO cl_gui_splitter_container,
       gr_con_top TYPE REF TO cl_gui_container,
       gr_con_alv TYPE REF TO cl_gui_container.

DATA : gr_alv      TYPE REF TO cl_gui_alv_grid,
       gs_layout   TYPE lvc_s_layo,
       gt_fieldcat TYPE lvc_t_fcat,
       gs_fieldcat TYPE lvc_s_fcat,

       gs_variant TYPE disvariant,
       gv_save    TYPE c.
