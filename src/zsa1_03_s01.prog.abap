*&---------------------------------------------------------------------*
*& Include          ZSA1_03_S01
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.

  PARAMETERS     : pa_werks TYPE mast-werks OBLIGATORY DEFAULT '1010'.
  SELECT-OPTIONS : so_matnr FOR mast-matnr.

SELECTION-SCREEN end of BLOCK b1.
