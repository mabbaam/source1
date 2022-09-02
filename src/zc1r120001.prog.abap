*&---------------------------------------------------------------------*
*& Report ZC1R120001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZC1R120001_TOP                          .    " Global Data

 INCLUDE ZC1R120001_S01                          .  "selection screen
 INCLUDE ZC1R120001_O01                          .  " PBO-Modules
 INCLUDE ZC1R120001_I01                          .  " PAI-Modules
 INCLUDE ZC1R120001_F01                          .  " FORM-Routines

INITIALIZATION.
 PERFORM init_param.
