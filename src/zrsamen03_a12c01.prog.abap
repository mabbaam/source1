*&---------------------------------------------------------------------*
*& Include          ZRSAMEN03_A12C01
*&---------------------------------------------------------------------*

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      on_toolbar_high FOR EVENT toolbar
        OF cl_gui_alv_grid
        IMPORTING e_object.

ENDCLASS.



CLASS lcl_handler IMPLEMENTATION.
 METHOD on_toolbar_high.

 data: ls_button type stb_button.
 ls_button-function = 'SELECT'.
 ls_button-butn_type = '0'.
 ls_button-text = 'SELECT ALL'.
 append ls_button to e_object->mt_toolbar.

 clear ls_button.
  ls_button-function = 'SELECT'.
 ls_button-butn_type = '0'.
 ls_button-text = 'DESELECT ALL'.
 append ls_button to e_object->mt_toolbar.

 ENDMETHOD.

ENDCLASS.
