*&---------------------------------------------------------------------*
*& Include          ZSTDA1201_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_0100 INPUT.

gcl_grid->free( ).

gcl_con->free( ).

free : gcl_grid, gcl_con.

leave to SCREEN 0.

ENDMODULE.