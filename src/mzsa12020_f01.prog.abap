*&---------------------------------------------------------------------*
*& Include          MZSA12020_F01
*&---------------------------------------------------------------------*


FORM set_default .
  CLEAR zssa0060.
  SELECT SINGLE *
    FROM spfli
    INTO CORRESPONDING FIELDS OF zssa0060.
endform.
