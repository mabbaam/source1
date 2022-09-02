*&---------------------------------------------------------------------*
*& Report ZRSA12_12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_12.

DATA gv_carrname TYPE scarr-carrname.
PARAMETERS pa_carr TYPE scarr-carrid.

PERFORM sel_carrname USING pa_carr
                     CHANGING gv_carrname.

WRITE gv_carrname.

FORM sel_carrname USING p_code
                  CHANGING VALUE(p_carrname).
  SELECT SINGLE carrname
    FROM scarr
    INTO p_carrname
    WHERE carrid = p_code.
    WRITE 'Test GV_CARRNAME'.
    WRITE gv_carrname.
ENDFORM.




*SELECT SINGLE carrname
*  FROM scarr
*  INTO gv_carrname
*  WHERE carrid = pa_carr.


*&---------------------------------------------------------------------*
*& Form sel_carrname
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
