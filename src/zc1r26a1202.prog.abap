*&---------------------------------------------------------------------*
*& Report ZC1R260004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZC1R26A1202_TOP.
*INCLUDE zc1r260004_top                          .    " Global Data

INCLUDE ZC1R26A1202_S01.
*INCLUDE zc1r260004_s01                          .  " Selection Screen
INCLUDE ZC1R26A1202_C01.
*INCLUDE zc1r260004_c01                          .  " Local Class
INCLUDE ZC1R26A1202_O01.
*INCLUDE zc1r260004_o01                          .  " PBO-Modules
INCLUDE ZC1R26A1202_I01.
*INCLUDE zc1r260004_i01                          .  " PAI-Modules
INCLUDE ZC1R26A1202_F01.
*INCLUDE zc1r260004_f01                          .  " FORM-Routines


START-OF-SELECTION.
  PERFORM get_bom_data.

  CALL SCREEN '0100'.
