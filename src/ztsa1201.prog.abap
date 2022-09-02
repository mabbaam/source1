*&---------------------------------------------------------------------*
*& Report ZTSA1201
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztsa1201.

*DATA: gs_ztsa1201 TYPE ztsa1201.
*DATA: gt_table LIKE TABLE OF gs_ztsa1201.
*
*DATA: BEGIN OF gs_abc,
*        matnr type mara-matnr,
*        werks type marc-werks,
*        mtart type mara-mtart,
*        matkl type mara-matkl,
*        ekgrp type marc-ekgrp,
*        pstat type marc-pstat,
*      END OF gs_abc.
*
*data: gt_abc like TABLE OF gs_abc.



*DATA : gs_sbook TYPE sbook.
*DATA : gt_sbook LIKE TABLE OF gs_sbook.
*
*SELECT carrid connid fldate bookid
*       customid custtype invoice class smoker
*  INTO CORRESPONDING FIELDS OF TABLE gt_sbook
*  FROM sbook
*  WHERE carrid = 'DL' AND
*        custtype = 'P' AND
*        order_date = '20201227'.
*
*LOOP AT gt_sbook INTO gs_sbook.
*  IF gs_sbook-smoker = 'X' AND gs_sbook-invoice = 'X'.
*    gs_sbook-class = 'F'.
*    MODIFY gt_sbook FROM gs_sbook.
*  ENDIF.
*ENDLOOP.
*
*
*cl_demo_output=>display_data( gt_sbook ).



*DATA : BEGIN OF gs_abc,
*         carrid     TYPE sflight-carrid,
*         connid     TYPE sflight-connid,
*         fldate     TYPE sflight-fldate,
*         currency   TYPE sflight-currency,
*         planetype  TYPE sflight-planetype,
*         seatsocc_b TYPE sflight-seatsocc_b,
*       END OF gs_abc.
*
*DATA : gt_abc LIKE TABLE OF gs_abc.
*DATA : lv_tabix TYPE sy-tabix.
*
*CLEAR gs_abc.
*REFRESH gt_abc.
*
*SELECT carrid connid fldate currency planetype seatsocc_b
*  INTO CORRESPONDING FIELDS OF TABLE gt_abc
*  FROM sflight
*  WHERE currency = 'USD' AND
*        planetype = '747-400'.
*
*LOOP AT gt_abc INTO gs_abc.
*
*        lv_tabix = sy-tabix.
*
*  CASE gs_abc-carrid.
*    WHEN 'UA'.
*      gs_abc-seatsocc_b  = gs_abc-seatsocc_b + 5.
*      MODIFY gt_abc FROM gs_abc INDEX lv_tabix TRANSPORTING seatsocc_b.
*  ENDCASE.
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_abc ).



*DATA: BEGIN OF gs_mara,
*        matnr TYPE mara-matnr,
*        maktx TYPE makt-maktx,
*        mtart TYPE mara-mtart,
*        matkl TYPE mara-matkl,
*      END OF gs_mara,
*
*      gt_mara LIKE TABLE OF gs_mara,
*
*      BEGIN OF gs_makt,
*        matnr TYPE makt-matnr,
*        maktx TYPE makt-maktx,
*      END OF gs_makt,
*
*      gt_makt LIKE TABLE OF gs_makt.
*
*DATA : lv_tabix TYPE sy-tabix.
*
*SELECT matnr mtart matkl
*  INTO CORRESPONDING FIELDS OF TABLE gt_mara
*  FROM mara.
*
*SELECT matnr maktx
*  INTO CORRESPONDING FIELDS OF TABLE gt_makt
*  FROM makt
*  WHERE spras = sy-langu.
*
*LOOP AT gt_mara INTO gs_mara.
*  lv_tabix = sy-tabix.
*
*  READ TABLE gt_makt INTO gs_makt WITH KEY matnr = gs_mara-matnr.
*
*  IF sy-subrc = 0.
*    gs_mara-maktx = gs_makt-maktx.
*
*    MODIFY gt_mara FROM gs_mara
*    INDEX lv_tabix TRANSPORTING maktx.
*  ENDIF.
*
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_mara ).



*DATA : BEGIN OF gs_spfli,
*         carrid   TYPE spfli-carrid,
*         carrname TYPE scarr-carrname,
*         url      TYPE scarr-url,
*         connid   TYPE spfli-connid,
*         airpfrom TYPE spfli-airpfrom,
*         airpto   TYPE spfli-airpto,
*         deptime  TYPE spfli-deptime,
*         arrtime  TYPE spfli-arrtime,
*       END OF gs_spfli,
*
*       gt_spfli LIKE TABLE OF gs_spfli,
*
*       BEGIN OF gs_scarr,
*         carrid   TYPE scarr-carrid,
*         carrname TYPE scarr-carrname,
*         url      TYPE scarr-url,
*       END OF gs_scarr,
*
*       gt_scarr LIKE TABLE OF gs_scarr.
*
*DATA: lv_tabix TYPE sy-tabix.
*
*SELECT carrid connid airpfrom airpto deptime arrtime
*  INTO CORRESPONDING FIELDS OF TABLE gt_spfli
*  FROM spfli.
*
*SELECT carrid carrname url
*  INTO CORRESPONDING FIELDS OF TABLE gt_scarr
*  FROM scarr.
*
*LOOP AT gt_spfli INTO gs_spfli.
*  lv_tabix = sy-tabix.
*
*  READ TABLE gt_scarr INTO gs_scarr WITH KEY carrid = gs_spfli-carrid.
*
*  IF sy-subrc = 0.
*    gs_spfli-carrname = gs_scarr-carrname.
*    gs_spfli-url = gs_scarr-url.
*
*  ENDIF.
*
*  MODIFY gt_spfli FROM gs_spfli
*  INDEX lv_tabix TRANSPORTING carrname url.
*
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_spfli ).


DATA : BEGIN OF gs_data,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
         mtart TYPE mara-mtart,
         mtbez TYPE t134t-mtbez,
         mbrsh TYPE mara-mbrsh,
         mbbez TYPE t137t-mbbez,
         tragr TYPE mara-tragr,
         vtext TYPE ttgrt-vtext,
       END OF gs_data,

       gt_data  LIKE TABLE OF gs_data,
       lv_tabix TYPE sy-tabix,

       gs_mtbez TYPE t134t,
       gt_mtbez LIKE TABLE OF gs_mtbez,
       gs_mbbez TYPE t137t,
       gt_mbbez LIKE TABLE OF gs_mbbez,
       gs_vtext TYPE ttgrt,
       gt_vtext LIKE TABLE OF gs_vtext.


SELECT a~matnr b~maktx a~mtart a~mbrsh a~tragr
  FROM mara AS a INNER JOIN makt AS b ON a~matnr = b~matnr
  INTO CORRESPONDING FIELDS OF TABLE gt_data
  WHERE spras = sy-langu.


*       SELECT matnr mtart mbrsh tragr
*         into CORRESPONDING FIELDS OF TABLE gt_data
*         FROM mara.
*
*
*       SELECT maktx
*         into CORRESPONDING FIELDS OF TABLE gt_data
*         FROM makt.

SELECT mtbez mtart
  INTO CORRESPONDING FIELDS OF TABLE gt_mtbez
  FROM t134t
  WHERE spras = sy-langu.

SELECT mbbez mbrsh
  INTO CORRESPONDING FIELDS OF TABLE gt_mbbez
  FROM t137t
  WHERE spras = sy-langu.

SELECT vtext tragr
  INTO CORRESPONDING FIELDS OF TABLE gt_vtext
  FROM ttgrt
  WHERE spras = sy-langu.

LOOP AT gt_data INTO gs_data.
  lv_tabix = sy-tabix.

  READ TABLE gt_mtbez INTO gs_mtbez WITH KEY mtart = gs_data-mtart.
  IF sy-subrc = 0.
    gs_data-mtbez = gs_mtbez-mtbez.
    MODIFY gt_data FROM gs_data INDEX lv_tabix TRANSPORTING mtbez.
  ENDIF.

  READ TABLE gt_mbbez INTO gs_mbbez WITH KEY mbrsh = gs_data-mbrsh.
  IF sy-subrc = 0.
    gs_data-mbbez = gs_mbbez-mbbez.
    MODIFY gt_data FROM gs_data INDEX lv_tabix TRANSPORTING mbbez.
  ENDIF.


  READ TABLE gt_vtext INTO gs_vtext WITH KEY tragr = gs_data-tragr.

  IF sy-subrc = 0.
    gs_data-vtext = gs_vtext-vtext.
    MODIFY gt_data FROM gs_data INDEX lv_tabix TRANSPORTING vtext.
  ENDIF.
ENDLOOP.

cl_demo_output=>display_data( gt_data ).
