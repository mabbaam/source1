*&---------------------------------------------------------------------*
*& Include ZSTDA1201_TOP                            - Report ZSTDA1201
*&---------------------------------------------------------------------*
REPORT zstda1201 MESSAGE-ID zmcsa20.

TABLES : scarr,sflight.

DATA: BEGIN OF gs_data,
        carrid    TYPE scarr-carrid,
        carrname  TYPE scarr-carrname,
        connid    TYPE sflight-connid,
        fldate    TYPE sflight-fldate,
        planetype TYPE sflight-planetype,
        price     TYPE sflight-price,
        currency  TYPE sflight-currency,
        url       TYPE scarr-url,
      END OF gs_data,

      gt_data LIKE TABLE OF gs_data,

      BEGIN OF gs_sbook,
        carrid     TYPE sbook-carrid,
        connid     TYPE sbook-connid,
        fldate     TYPE sbook-fldate,
        bookid     TYPE sbook-bookid,
        stomid     TYPE sbook-customid,
        custtype   TYPE sbook-custtype,
        luggewight TYPE sbook-luggweight,
        wunit      TYPE sbook-wunit,
      END OF gs_sbook,

      gt_sbook LIKE TABLE OF gs_sbook.


"ALV
DATA : gcl_con    TYPE REF TO cl_gui_docking_container,
       gcl_grid   TYPE REF TO cl_gui_alv_grid,
       gs_fcat    TYPE lvc_s_fcat,
       gt_fcat    LIKE TABLE OF gs_fcat,
       gs_layout  TYPE lvc_s_layo,
       gs_variant TYPE disvariant.

DATA : gv_okcode TYPE sy-ucomm.
