*&---------------------------------------------------------------------*
*& Include          YCL112_001_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME
                                    TITLE textt01.

  SELECT-OPTIONS s_carrid FOR gs_scarr-carrid.
  SELECT-OPTIONS s_carrnm for scarr-carrname.


  SELECTION-SCREEN END OF BLOCK b01.
