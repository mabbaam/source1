*&---------------------------------------------------------------------*
*& Report ZC1R26A1201
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE ZC1R26A1201_TOP                         .    " Global Data


 INCLUDE ZC1R26A1201_O01                         .  " PBO-Modules
 INCLUDE ZC1R26A1201_c01                         .  "local class
 INCLUDE ZC1R26A1201_s01                         .  "selection screen
 INCLUDE ZC1R26A1201_I01                         .  " PAI-Modules
 INCLUDE ZC1R26A1201_F01                         .  " FORM-Routines

 START-OF-SELECTION.
  PERFORM get_flight_list.
  PERFORM set_carrname.

  call screen 100.
