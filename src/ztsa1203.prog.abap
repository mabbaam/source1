*&---------------------------------------------------------------------*
*& Report ZTSA1203
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztsa1203.



*TABLES sbuspart.
*
*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.
*  PARAMETERS :    pa_abc  TYPE sbuspart-buspartnum OBLIGATORY.
*  SELECT-OPTIONS so_abc   FOR sbuspart-contact     NO INTERVALS.
*SELECTION-SCREEN END OF BLOCK b1.
*
*
*
*
*PARAMETERS : p_rad1 RADIOBUTTON GROUP rd1,
*             p_rad2 RADIOBUTTON GROUP rd1,
*             p_rad3 RADIOBUTTON GROUP rd1.




*TABLES : sbook.
*
*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.
*  PARAMETERS : pa_car TYPE sbook-carrid DEFAULT 'AA' OBLIGATORY.
*  SELECT-OPTIONS : so_con FOR sbook-connid OBLIGATORY.
*  PARAMETERS : pa_cust TYPE sbook-custtype as LISTBOX VISIBLE LENGTH 10 OBLIGATORY.
*  SELECT-OPTIONS : so_fld FOR sbook-fldate DEFAULT sy-datum.
*  SELECT-OPTIONS : so_book FOR sbook-bookid.
*  SELECT-OPTIONS : so_cust FOR sbook-customid NO-EXTENSION NO INTERVALS.
*SELECTION-SCREEN END OF BLOCK b1.
*
*
*
*DATA : BEGIN OF gs_data,
*         carrid   TYPE sbook-carrid,
*         connid   TYPE sbook-connid,
*         custtype TYPE sbook-custtype,
*         fldate   TYPE sbook-fldate,
*         bookid   TYPE sbook-bookid,
*         customid TYPE sbook-customid,
*         invoice  TYPE sbook-invoice,
*         class    TYPE sbook-class,
*       END OF gs_data,
*       gt_data LIKE TABLE OF gs_data.
*
*
*REFRESH gt_data.
*
*SELECT carrid connid fldate bookid customid custtype invoice class
*  INTO CORRESPONDING FIELDS OF TABLE gt_data
*  FROM sbook
*  WHERE carrid = pa_car
*  and   connid in so_con
*  and   custtype = pa_cust
*  and   fldate in so_fld
*  and   bookid in so_book
*  and   customid in so_cust.
*
*LOOP AT gt_data INTO gs_data.
*
*  CASE gs_data-invoice.
*    WHEN 'X'.
*      gs_data-class = 'F'.
*      MODIFY gt_data FROM gs_data.
*  ENDCASE.
*
*ENDLOOP.
*
*cl_demo_output=>display_data( gt_data ).


TABLES : sflight.
TABLES : sbook.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.

  PARAMETERS : pa_carr TYPE sflight-carrid OBLIGATORY.
  SELECT-OPTIONS : so_conn FOR sflight-connid OBLIGATORY.
  PARAMETERS : pa_plan TYPE sflight-planetype AS LISTBOX VISIBLE LENGTH 20.
  SELECT-OPTIONS : so_book FOR sbook-bookid.

SELECTION-SCREEN END OF BLOCK b1.

DATA : BEGIN OF gs_itab1,
         carrid    TYPE sflight-carrid,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         planetype TYPE sflight-planetype,
         currency  TYPE sflight-currency,
         bookid    TYPE sbook-bookid,
         customid  TYPE sbook-customid,
         custtype  TYPE sbook-custtype,
         class     TYPE sbook-class,
         agencynum TYPE sbook-agencynum,
       END OF gs_itab1,
       gt_itab1 LIKE TABLE OF gs_itab1.

DATA : BEGIN OF gs_itab2,
         carrid    TYPE sflight-carrid,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         bookid    TYPE sbook-bookid,
         customid  TYPE sbook-customid,
         custtype  TYPE sbook-custtype,
         agencynum TYPE sbook-agencynum,
       END OF gs_itab2,
       gt_itab2 LIKE TABLE OF gs_itab2.

SELECT b~carrid a~connid a~fldate a~planetype
       a~currency b~bookid b~customid b~custtype
       b~class b~agencynum
FROM sflight as a INNER JOIN sbook as b
  ON a~carrid = b~carrid
INTO CORRESPONDING FIELDS OF TABLE gt_itab1.


  cl_demo_output=>display_data( gt_itab1 ).
