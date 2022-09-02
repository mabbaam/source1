*&---------------------------------------------------------------------*
*& Report ZC1R120002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZC1R120002_TOP                          .    " Global Data

 INCLUDE ZC1R120002_S01                         . "select screen
 INCLUDE ZC1R120002_C01                         . "local class
 INCLUDE ZC1R120002_O01                          .  " PBO-Modules
 INCLUDE ZC1R120002_I01                          .  " PAI-Modules
 INCLUDE ZC1R120002_F01                          .  " FORM-Routines

 START-OF-SELECTION.
  PERFORM get_data.

  call screen '0100'.
