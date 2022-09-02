*&---------------------------------------------------------------------*
*& Report ZRSA12_21
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_21.
TYPES: BEGIN OF ts_info,
         carrid    TYPE c LENGTH 3,
         carrname  TYPE scarr-carrname,
         connid    TYPE spfli-connid,
         countryfr TYPE spfli-countryfr,
         countryto TYPE spfli-countryto,
         atype, " TYPE c LENGH 1
         atype_t   TYPE c LENGTH 10,

       END OF ts_info.

*Connection Internal Table
DATA gt_info TYPE TABLE OF ts_info. "<table_Type>.

* Struncture Variable
DATA gs_info LIKE LINE OF gt_info.
*data gs_info TYPE ts_info. 위에줄이랑 똑같은 의미! 근데 위에가 더 좋음!

*DATA: gs_info TYPE ts_info,
*      gt_info LIKE TABLE OF gs_info.

PARAMETERS pa_car LIKE spfli-carrid.

PERFORM add_info USING 'AA'
                       '0017'
                       'US'
                       'US'.

SELECT carrid connid countryfr countryto
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_info
 WHERE carrid = pa_car.

LOOP AT gt_info INTO gs_info.
  " Get Atype(D,I)
  IF gs_info-countryfr = gs_info-countryto.
    gs_info-atype = 'D'.
  ELSE.
    gs_info-atype = 'I'.
  ENDIF.

  " Get Airline name
  SELECT SINGLE carrname
    FROM scarr
    INTO gs_info-carrname
    WHERE carrid = gs_info-carrid.

  MODIFY gt_info FROM gs_info TRANSPORTING carrname atype.
  CLEAR gs_info.

ENDLOOP.





cl_demo_output=>display_data( gt_info ).

*&---------------------------------------------------------------------*
*& Form fo_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM add_info USING VALUE(p_carrid)
                    VALUE(p_connid)
                    VALUE(p_countryfr)
                    VALUE(p_countryto).

  DATA ls_info LIKE LINE OF gt_info.
  CLEAR ls_info.

  ls_info-carrid = p_carrid.
  ls_info-connid = p_connid.
  ls_info-countryfr = p_countryfr.
  ls_info-countryto = p_countryto.
  APPEND ls_info TO gt_info.

  CLEAR ls_info.

ENDFORM.
