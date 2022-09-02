*&---------------------------------------------------------------------*
*& Include          SAPMZSA1210_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_conn_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA1280_CARRID
*&      --> ZSSA1280_CONNID
*&      <-- ZSSA0082
*&---------------------------------------------------------------------*
FORM get_conn_info  USING    VALUE(p_carrid)
                             VALUE(p_connid)
                    CHANGING ps_info TYPE zssa0082.
  CLEAR ps_info.
  SELECT SINGLE *
    FROM spfli
    INTO CORRESPONDING FIELDS OF ps_info
    WHERE carrid = p_carrid
    AND connid = p_connid.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_airline_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_airline_info .

clear zssa0081.
SELECT SINGLE *
  FROM scarr
  into CORRESPONDING FIELDS OF zssa0081
  WHERE carrid = zssa1280-carrid.


ENDFORM.
