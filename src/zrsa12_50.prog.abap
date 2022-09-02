
*&---------------------------------------------------------------------*
*& Report ZRSA12_50
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa12_50_top                           .    " Global Data

INCLUDE zrsa12_50_o01                           .  " PBO-Modules
INCLUDE zrsa12_50_i01                           .  " PAI-Modules
INCLUDE zrsa12_50_f01                           .  " FORM-Routines

INITIALIZATION.
 pa_car = 'AA'.
 pa_con = '0017'.
 so_dat-low = sy-datum.
Append so_dat.

AT SELECTION-SCREEN OUTPUT. "PBO"

AT SELECTION-SCREEN. "PAI"

START-OF-SELECTION.

  CALL SCREEN 100.
