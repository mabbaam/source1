*&---------------------------------------------------------------------*
*& Report ZRSA12_32
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_32.


DATA gs_emp TYPE zssa0004.

PARAMETERS pa_pernr LIKE gs_emp-pernr.

INITIALIZATION.
  pa_pernr = '22020001'.

START-OF-SELECTION.
  SELECT SINGLE *
    FROM ztsa0001
INTO CORRESPONDING FIELDS OF gs_emp
WHERE pernr = pa_pernr.

  IF  sy-subrc <> 0.
    MESSAGE i001(zmca12).
    RETURN.
  ENDIF.
  cl_demo_output=>display_data( gs_emp ).
