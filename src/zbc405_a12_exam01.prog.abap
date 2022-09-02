*&---------------------------------------------------------------------*
*& Report ZBC405_A12_EXAM01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_a12_exam01_top                   .    " Global Data

* INCLUDE ZBC405_A12_EXAM01_O01                   .  " PBO-Modules
* INCLUDE ZBC405_A12_EXAM01_I01                   .  " PAI-Modules
* INCLUDE ZBC405_A12_EXAM01_F01                   .  " FORM-Routines


TABLES : ztspfli_A12.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.

  SELECT-OPTIONS : so_car FOR ztspfli_a12-carrid MEMORY ID car,
                   so_con FOR ztspfli_a12-connid MEMORY ID con.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(14) TEXT-t02.
    SELECTION-SCREEN POSITION POS_LOW.
    PARAMETERS p_layout TYPE disvariant-variant.

    SELECTION-SCREEN COMMENT pos_high(10) FOR FIELD p_edit.
    PARAMETERS p_edit AS CHECKBOX.


  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b2.

PARAMETERS : p_screen AS CHECKBOX.


TYPES: BEGIN OF gty_spfli.
         INCLUDE TYPE ztspfli_a12.

TYPES:   light TYPE c LENGTH 1.
TYPES:   it_color TYPE lvc_t_scol.
TYPES:   row_color TYPE c LENGTH 4.
TYPES:   flty TYPE c LENGTH 1.
TYPES:  flty_icon TYPE icon-id.
TYPES:  f_tzone TYPE sairport-time_zone.
TYPES:  t_tzone TYPE sairport-time_zone.
TYPES:  modified    TYPE c LENGTH 1.
TYPES: END OF gty_spfli.

DATA : gt_spfli TYPE TABLE OF gty_spfli,
       gs_spfli TYPE          gty_spfli.


DATA: gs_airport TYPE sairport,
      gt_airport LIKE TABLE OF gs_airport.


DATA : ok_code TYPE sy-ucomm.


TABLES : sairport.

DATA : gt_tzone TYPE TABLE OF sairport,
       gs_tzone TYPE sairport.


"ALV
DATA : go_container TYPE REF TO cl_gui_custom_container,
       go_alv       TYPE REF TO cl_gui_alv_grid.

DATA : gs_variant TYPE disvariant,
       gs_layout  TYPE lvc_s_layo,
       gt_fcat    TYPE lvc_t_fcat,
       gs_fcat    TYPE lvc_s_fcat,
       gt_exct    TYPE ui_functions,
       gs_color   TYPE lvc_s_scol.


INCLUDE zbc405_a12_exam01_class.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_layout.

  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
    EXPORTING
      i_save_load = 'F'
    CHANGING
      cs_variant  = gs_variant.
  IF sy-subrc <> 0.
  ELSE.
    p_layout = gs_variant-variant.
  ENDIF.


INITIALIZATION.
  gs_variant-report = sy-cprog.







START-OF-SELECTION.

  PERFORM get_data.
  PERFORM make_fieldcatalog.

*if p_screen = 'X'.
*CLEAR : ztspfli_a12.
*  CALL SCREEN 200.
*  ELSE.
  CALL SCREEN 100.
*
*    endif.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .

  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    FROM ztspfli_a12
    WHERE carrid IN so_car
     AND  connid IN so_con.

  "sairport data.

  SELECT *
    INTO TABLE gt_tzone
    FROM sairport.



  LOOP AT gt_spfli INTO gs_spfli.

    READ TABLE gt_tzone INTO gs_tzone WITH KEY id = gs_spfli-airpfrom.
    IF sy-subrc = 0.
      gs_spfli-f_tzone = gs_tzone-time_zone.
    ENDIF.

    READ TABLE gt_tzone INTO gs_tzone WITH KEY id = gs_spfli-airpto.
    IF sy-subrc = 0.
      gs_spfli-t_tzone = gs_tzone-time_zone.
    ENDIF.




    CLEAR : gs_color.
    IF gs_spfli-countryfr = gs_spfli-countryto.
      gs_spfli-flty = 'D'. "domestic
      gs_color-fname = 'FLTY'.
      gs_color-color-col = col_positive.
      gs_color-color-int = '1'.
      gs_color-color-inv = '0'.
      APPEND gs_color TO gs_spfli-it_color.
    ELSE.
      gs_spfli-flty = 'I'.
      gs_color-fname = 'FLTY'.
      gs_color-color-col = col_total.
      gs_color-color-int = '1'.
      gs_color-color-inv = '0'.
      APPEND gs_color TO gs_spfli-it_color.
    ENDIF.


    CASE gs_spfli-fltype.
      WHEN 'X'.
        gs_spfli-flty_icon = icon_ws_plane.
      WHEN OTHERS.
        gs_spfli-flty_icon = icon_space.
    ENDCASE.




    IF gs_spfli-period >= 2.
      gs_spfli-light = 1.
    ELSEIF gs_spfli-period = 1.
      gs_spfli-light = 2.
    ELSE.
      gs_spfli-period = 0.
      gs_spfli-light = 3.
    ENDIF.









    MODIFY gt_spfli FROM gs_spfli.
  ENDLOOP.


ENDFORM.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  IF p_edit = 'X'.
    SET PF-STATUS 'S100'.
  ELSE.
    SET PF-STATUS 'S100' EXCLUDING 'SAVE'.
  ENDIF.

  SET TITLEBAR 'T100' WITH sy-datum sy-uname.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.
  LEAVE TO SCREEN 0.
ENDMODULE.

MODULE user_command_0100 INPUT.



ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_ALV_OBJECT OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_alv_object OUTPUT.

  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'.
    IF sy-subrc EQ 0.
      CREATE OBJECT go_alv
        EXPORTING
          i_parent = go_container.

      IF sy-subrc EQ 0.

        gs_layout-sel_mode = 'D'.
        gs_layout-excp_fname = 'LIGHT'.
        gs_layout-excp_led ='X'.
        gs_layout-zebra ='X'.
        gs_layout-cwidth_opt = 'X'.
        gs_layout-info_fname = 'ROW_COLOR'.
        gs_layout-ctab_fname = 'IT_COLOR'.

        SET HANDLER lcl_handler=>on_toolbar FOR go_alv.
        SET HANDLER lcl_handler=>on_usercommand FOR go_alv.
*        SET HANDLER lcl_handler=>on_doubleclick         FOR go_alv.
        SET HANDLER lcl_handler=>on_data_changed        FOR go_alv.
        SET HANDLER lcl_handler=>on_data_changed_finish FOR go_alv.


      call METHOD go_alv->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.



        APPEND cl_gui_alv_grid=>mc_fc_filter TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_info TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_cut TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_copy TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_mb_paste TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_append_row TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_insert_row TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_delete_row TO gt_exct.
        APPEND cl_gui_alv_grid=>mc_fc_loc_copy_row TO gt_exct.

        CALL METHOD go_alv->set_table_for_first_display
          EXPORTING
*           i_buffer_active      =
*           i_bypassing_buffer   =
*           i_consistency_check  =
            i_structure_name     = 'ztspfli_a12'
            is_variant           = gs_variant
            i_save               = 'A'
            i_default            = 'X'
            is_layout            = gs_layout
*           is_print             =
*           it_special_groups    =
            it_toolbar_excluding = gt_exct
*           it_hyperlink         =
*           it_alv_graphics      =
*           it_except_qinfo      =
*           ir_salv_adapter      =
          CHANGING
            it_outtab            = gt_spfli
            it_fieldcatalog      = gt_fcat
*           it_sort              =
*           it_filter            =
*  EXCEPTIONS
*           invalid_parameter_combination = 1
*           program_error        = 2
*           too_many_lines       = 3
*           others               = 4
          .
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.

      ENDIF.
    ENDIF.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form make_fieldcatalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_fieldcatalog .

* ------- 추가 필드
  CLEAR : gs_fcat.
  gs_fcat-fieldname ='FLTY'.
  gs_fcat-coltext = 'I&D'.
  gs_fcat-col_opt = 'X'.
  gs_fcat-col_pos = 6.
  gs_fcat-just = 'C'.
  APPEND gs_fcat TO gt_fcat.


  CLEAR : gs_fcat.
  gs_fcat-fieldname ='FLTY_ICON'.
  gs_fcat-coltext = 'FLIGHT'.
  gs_fcat-col_pos = 10.
  APPEND gs_fcat TO gt_fcat.


  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'F_TZONE'.
  gs_fcat-coltext = 'From TZ'.
  gs_fcat-ref_table = 'SAIRPORT'.
  gs_fcat-ref_field = 'TIME_ZONE'.
  gs_fcat-col_pos = 17.
  APPEND gs_fcat TO gt_fcat.


  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'T_TZONE'.
  gs_fcat-coltext = 'To TZ'.
  gs_fcat-ref_table = 'SAIRPORT'.
  gs_fcat-ref_field = 'TIME_ZONE'.
  gs_fcat-col_pos = 18.
  APPEND gs_fcat TO gt_fcat.

** -------


  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'DEPTIME'.
  gs_fcat-edit = p_edit.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'FLTIME'.
  gs_fcat-edit = p_edit.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'PERIOD'.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'FLTYPE'.
  gs_fcat-no_out = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'ARRTIME'.
  gs_fcat-emphasize = 'C610'.
  APPEND gs_fcat TO gt_fcat.


  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'PERIOD'.
  gs_fcat-emphasize = 'C610'.
  APPEND gs_fcat TO gt_fcat.



ENDFORM.


*&---------------------------------------------------------------------*
*&      Module  CREATE_DROPDOWN_BOX  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form calculate_change
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ER_DATA_CHANGED
*&      --> LS_MOD_CELLS
*&---------------------------------------------------------------------*
FORM calculate_change  USING    p_changed TYPE REF TO cl_alv_changed_data_protocol
                                p_mod_cell TYPE lvc_s_modi.

  DATA: l_fltime  TYPE ztspfli_a12-fltime,
        l_deptime TYPE ztspfli_a12-deptime,
        l_arrtime TYPE ztspfli_a12-arrtime,
        l_period  TYPE n,
        l_light   TYPE c LENGTH 1.

  READ TABLE gt_spfli INTO gs_spfli INDEX p_mod_cell-row_id.

  CALL METHOD p_changed->get_cell_value
    EXPORTING
      i_row_id    = p_mod_cell-row_id
      i_fieldname = 'FLTIME'
    IMPORTING
      e_value     = l_fltime.

  CALL METHOD p_changed->get_cell_value
    EXPORTING
      i_row_id    = p_mod_cell-row_id
      i_fieldname = 'DEPTIME'
    IMPORTING
      e_value     = l_deptime.

  "펑션

  CALL FUNCTION 'ZBC405_CALC_ARRTIME'
    EXPORTING
      iv_fltime       = l_fltime
      iv_deptime      = l_deptime
      iv_utc          = gs_spfli-f_tzone
      iv_utc1         = gs_spfli-t_tzone
    IMPORTING
      ev_arrival_time = l_arrtime
      ev_period       = l_period.
  .

  IF l_period >= 2.
    l_light = '1'.

  ELSEIF l_period = 1.
    l_light = '2'.

  ELSEIF l_period = 0.
    l_light = '3'.
  ENDIF.

  CALL METHOD p_Changed->modify_cell
    EXPORTING
      i_row_id    = p_mod_cell-row_id
      i_fieldname = 'ARRTIME'
      i_value     = l_arrtime.

  CALL METHOD p_changed->modify_cell
    EXPORTING
      i_row_id    = p_mod_cell-row_id
      i_fieldname = 'PERIOD'
      i_value     = l_period.

  CALL METHOD p_changed->modify_cell
    EXPORTING
      i_row_id    = p_mod_cell-row_id
      i_fieldname = 'LIGHT'
      i_value     = l_light.

  gs_spfli-arrtime = l_arrtime.
  gs_spfli-period = l_period.
  gs_spfli-light = l_light.

  MODIFY gt_spfli FROM gs_spfli INDEX p_mod_cell-row_id.





ENDFORM.
*&---------------------------------------------------------------------*
*& Form changed_finished
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LS_MOD_CELLS
*&---------------------------------------------------------------------*
FORM changed_finished  USING    p_mod_cells TYPE lvc_s_modi.


  READ TABLE gt_spfli INTO gs_spfli INDEX p_mod_cells-row_id.

  IF sy-subrc EQ 0.
    gs_spfli-modified = 'X'.
    MODIFY gt_spfli FROM gs_spfli INDEX p_mod_cells-row_id.
  ENDIF.

ENDFORM.
