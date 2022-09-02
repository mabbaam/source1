*&---------------------------------------------------------------------*
*& Include          SAPMZSA1204_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_emp_name
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA0073_PERNR
*&      <-- ZSSA0073_ENAME
*&---------------------------------------------------------------------*
FORM get_emp_name  USING    VALUE(p_pernr)
                   CHANGING VALUE(p_ename).
*  CLEAR p_ename.
*  SELECT SINGLE ename
*   FROM ztsa0001
*  INTO p_ename
* WHERE pernr = p_pernr.

  CALL FUNCTION 'ZFSA00_01'
    EXPORTING
      iv_pernr = p_pernr
    IMPORTING
      ev_ename = p_ename.
  .
ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_default
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_default CHANGING ps_default TYPE zssa0073 .

  CLEAR ps_default.
  SELECT pernr ename
     FROM ztsa0001 UP TO 1 ROWS
    INTO CORRESPONDING FIELDS OF ps_default.
  ENDSELECT.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_emp_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA0073_PERNR
*&      <-- ZSSA0070
*&---------------------------------------------------------------------*
FORM get_emp_info  USING    VALUE(p_pernr)
                   CHANGING ps_info TYPE zssa0070. "call by reference

  CLEAR ps_info.
  SELECT SINGLE *
    FROM ztsa0001
    into CORRESPONDING FIELDS OF ps_info
    WHERE pernr = p_pernr.

ENDFORM.
