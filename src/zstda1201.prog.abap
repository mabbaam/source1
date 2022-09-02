*&---------------------------------------------------------------------*
*& Report ZSTDA1201
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZSTDA1201_TOP                           .    " Global Data

 INCLUDE ZSTDA1201_S01                           ."selection screen
 INCLUDE ZSTDA1201_C01                           ."local class
 INCLUDE ZSTDA1201_O01                           .  " PBO-Modules
 INCLUDE ZSTDA1201_I01                           .  " PAI-Modules
 INCLUDE ZSTDA1201_F01                           .  " FORM-Routines


START-OF-SELECTION.
 PERFORM get_data.

 call SCREEN '100'.
