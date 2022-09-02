*&---------------------------------------------------------------------*
*& Report ZRSA12_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_01.

PARAMETERS pa_carr TYPE scarr-carrid.
PARAMETERS pa_carr1(3) TYPE c.

DATA gs_scarr TYPE scarr.

PERFORM get_data.

SELECT SINGLE * FROM scarr
                INTO gs_scarr
                WHERE carrid = pa_carr.


IF sy-subrc IS NOT INITIAL.

ELSE.

ENDIF.



*IF sy-subrc = 0.
*    NEW-LINE.
*
*    WRITE: gs_scarr-carrid,
*           gs_scarr-carrname,
*           gs_scarr-url.
*
*  ELSE.
*
**    WRITE 'Sorry, no data found!'.
*MESSAGE 'Sorry, no data found' type 'I'.
*
*  ENDIF.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .

  IF sy-subrc = 0.
    NEW-LINE.

    WRITE: gs_scarr-carrid,
           gs_scarr-carrname,
           gs_scarr-url.

  ELSE.

*    WRITE 'Sorry, no data found!'.
    MESSAGE 'Sorry, no data found' TYPE 'I'.

  ENDIF.

ENDFORM.
