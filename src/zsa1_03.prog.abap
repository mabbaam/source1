*&---------------------------------------------------------------------*
*& Report ZSA1_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZSA1_03_TOP                             .    " Global Data

 INCLUDE zsa1_03_S01.
 INCLUDE ZSA1_03_O01                             .  " PBO-Modules
 INCLUDE ZSA1_03_I01                             .  " PAI-Modules
 INCLUDE ZSA1_03_F01                             .  " FORM-Routines

 INITIALIZATION.
* PERFORM init_mantr.

 START-OF-SELECTION.

 call SCREEN '0100'.
