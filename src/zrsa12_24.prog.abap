*&---------------------------------------------------------------------*
*& Report ZRSA12_24
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa12_24_top                           .    " Global Data

* INCLUDE ZRSA12_24_O01                           .  " PBO-Modules
* INCLUDE ZRSA12_24_I01                           .  " PAI-Modules
INCLUDE zrsa12_24_f01                           .  " FORM-Routines


" Event
INITIALIZATION.

AT SELECTION-SCREEN OUTPUT. "PBO

AT SELECTION-SCREEN. "PAI

START-OF-SELECTION.
clear: gt_info, gs_info.
