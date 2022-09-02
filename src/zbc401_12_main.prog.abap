*&---------------------------------------------------------------------*
*& Report ZBC401_12_MAIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_12_main.

TYPE-POOLS : icon.


CLASS lcl_airplane DEFINITION.


  PUBLIC SECTION.
    METHODS : set_attributes
      IMPORTING iv_name      TYPE string
                iv_planetype TYPE saplane-planetype,

      display_attributes.
    CLASS-METHODS : display_n_o_airplanes.
    CLASS-METHODS : get_n_o_airplanes
      RETURNING VALUE(rv_count) TYPE i.



  PRIVATE SECTION.
    DATA : mv_name      TYPE string,
           mv_planetype TYPE saplane-planetype.
    CLASS-DATA : gv_n_o_airplanes  TYPE i.

    CONSTANTS : c_pos_i TYPE i VALUE 30.

ENDCLASS.

CLASS lcl_airplane IMPLEMENTATION.
  METHOD get_n_o_airplanes.
    rv_count = gv_n_o_airplanes .
  ENDMETHOD.

  METHOD set_attributes.

    mv_name = iv_name.
    mv_planetype = iv_planetype.

    gv_n_o_airplanes = gv_n_o_airplanes  + 1.
  ENDMETHOD.


  METHOD display_attributes.
    WRITE : / icon_ws_plane as ICON,
            / 'Name of airplane', AT c_pos_i mv_name,
            / 'Type of airplane', AT c_pos_i mv_planetype.

  ENDMETHOD.

  METHOD display_n_o_airplanes.
    WRITE : / 'Number of Airplanes', AT c_pos_i gv_n_o_airplanes.
  ENDMETHOD.

ENDCLASS.

DATA : go_airplane TYPE REF TO  lcl_airplane.
DATA : gt_airplanes TYPE TABLE OF REF TO lcl_airplane.


START-OF-SELECTION.

  CALL METHOD lcl_airplane=>display_n_o_airplanes.


  lcl_airplane=>display_n_o_airplanes( ).


  CREATE OBJECT go_airplane.

  CALL METHOD go_airplane->set_attributes
    EXPORTING
      iv_name      = 'LH Berlin'
      iv_planetype = 'A321'.


  APPEND go_airplane TO gt_airplanes.




  CREATE OBJECT go_airplane.
  APPEND go_airplane TO gt_airplanes.


  CALL METHOD go_airplane->set_attributes
    EXPORTING
      iv_name      = 'AA New York'
      iv_planetype = '747-400'.


  CREATE OBJECT go_airplane.
  APPEND go_airplane TO gt_airplanes.

  CALL METHOD go_airplane->set_attributes
    EXPORTING
      iv_name      = 'US Herculs'
      iv_planetype = '747-200F'.


  LOOP AT gt_airplanes INTO go_airplane.

    CALL METHOD go_airplane->display_attributes.
  ENDLOOP.

  data : gv_count type i.

  gv_count = lcl_airplane=>get_n_o_airplanes( ).
  write : / 'Number of airplane',  gv_count.
