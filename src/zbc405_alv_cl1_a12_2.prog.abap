*&---------------------------------------------------------------------*
*& Report ZBC405_ALV_CL1_A12_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_alv_cl1_a12_2_top                .    " Global Data

* INCLUDE ZBC405_ALV_CL1_A12_2_O01                .  " PBO-Modules
* INCLUDE ZBC405_ALV_CL1_A12_2_I01                .  " PAI-Modules
* INCLUDE ZBC405_ALV_CL1_A12_2_F01                .  " FORM-Routines

TABLES : ztsbook_a12.

SELECT-OPTIONS : so_car FOR ztsbook_a12-carrid OBLIGATORY MEMORY ID car.


TYPES : BEGIN OF gty_sbook.
          INCLUDE TYPE ztsbook_a12.
TYPES :   email TYPE ztscustom_a12-email.
TYPES : END OF gty_sbook.

DATA : gt_sbook TYPE TABLE OF gty_sbook,
       gs_sbook TYPE          gty_sbook.

 DATA : gt_custom TYPE TABLE OF ztscustom_a12,
         gs_custom TYPE          ztscustom_a12.

DATA : ok_code TYPE sy-ucomm.




" ALV

DATA : go_container TYPE REF TO cl_gui_custom_container,
       go_alv       TYPE REF TO cl_gui_alv_grid.

DATA : gt_fcat TYPE lvc_t_fcat,
       gs_fcat TYPE lvc_s_fcat.


include ZBC405_ALV_CL1_A12_2_class.



START-OF-SELECTION.

  PERFORM get_date.
  PERFORM make_fieldcatalog.

  CALL SCREEN 100.




*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100' WITH sy-datum.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
  ENDCASE.

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
    .

    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_container.

    IF sy-subrc = 0.


 call METHOD go_alv->register_edit_event
 EXPORTING
   i_event_id = cl_gui_alv_grid=>mc_evt_modified.


      set HANDLER lcl_handler=>on_doubleclick for go_alv.
      set HANDLER lcl_handler=>on_toolbar for go_alv.
      set HANDLER lcl_handler=>on_usercommand for go_alv.
      set HANDLER lcl_handler=>on_data_changed for go_alv.


      CALL METHOD go_alv->set_table_for_first_display
        EXPORTING
*         i_buffer_active  =
*         i_bypassing_buffer            =
*         i_consistency_check           =
          i_structure_name = 'ZTSBOOK_A12'
*         is_variant       =
*         i_save           =
*         i_default        = 'X'
*         is_layout        =
*         is_print         =
*         it_special_groups             =
*         it_toolbar_excluding          =
*         it_hyperlink     =
*         it_alv_graphics  =
*         it_except_qinfo  =
*         ir_salv_adapter  =
        CHANGING
          it_outtab        = gt_sbook
          it_fieldcatalog  = gt_fcat
*         it_sort          =
*         it_filter        =
*    EXCEPTIONS
*         invalid_parameter_combination = 1
*         program_error    = 2
*         too_many_lines   = 3
*         others           = 4
        .
      IF sy-subrc <> 0.
*   Implement suitable error handling here
      ENDIF.




    ENDIF.

  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form get_date
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_date .

*  DATA : gt_custom TYPE TABLE OF ztscustom_a12,
*         gs_custom TYPE          ztscustom_a12.
  DATA : gt_temp   TYPE TABLE OF gty_sbook.

  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE gt_sbook FROM ztsbook_a12
    WHERE carrid IN so_car.

  IF sy-subrc = 0.

    gt_temp = gt_sbook.
    DELETE gt_temp WHERE customid = space.

    SORT gt_temp BY customid.
    DELETE ADJACENT DUPLICATES FROM gt_temp COMPARING customid.

    SELECT *
      INTO TABLE gt_custom
      FROM ztscustom_a12
      FOR ALL ENTRIES IN gt_temp
      WHERE id = gt_temp-customid.
  ENDIF.

  LOOP AT gt_sbook INTO gs_sbook.
    READ TABLE gt_custom INTO gs_custom
    WITH KEY id = gs_sbook-customid.
    IF sy-subrc EQ 0.
      gs_sbook-email = gs_custom-email.
    ENDIF.

  ENDLOOP.






  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE gt_sbook
    FROM ztsbook_A12
    WHERE carrid IN so_car.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_fieldcatalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_fieldcatalog .

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'SMOKER'.
  gs_fcat-checkbox = 'X'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'EMAIL'.
  gs_fcat-ref_table = 'ZTSCUSTOM_A12'.
  gs_fcat-ref_field = 'EMAIL'.
  gs_fcat-col_pos = '30'.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'CUSTOMID'.
  gs_fcat-edit = 'X'.
  APPEND gs_fcat TO gt_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form customer_change_part
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ER_DATA_CHANGED
*&---------------------------------------------------------------------*
FORM customer_change_part  USING    per_data_changed
                          TYPE ref to cl_alv_changed_data_protocol
                                     ps_mod_cells
                          TYPE lvc_s_modi.

  DATA : l_customid TYPE ztsbook_a12-customid.
  data : l_email TYPE ztscustom_a12-email.

CALL METHOD per_data_changed->get_cell_value
  EXPORTING
    i_row_id    = ps_mod_cells-row_id
*    i_tabix     =
    i_fieldname ='CUSTOMID'
  IMPORTING
    e_value     = l_customid
    .

    if l_customid is NOT INITIAL.
      READ TABLE gt_custom into gs_custom
        with key id = l_customid.
      if sy-subrc = 0.
        l_email = gs_custom-email.
        else.
          SELECT SINGLE email
            into l_email
            FROM ztscustom_a12
            WHERE id = l_customid.
            ENDIF.
            else.
              clear : l_email.
              endif.

                CALL METHOD per_data_changed->modify_cell
                EXPORTING
                 i_row_id    = ps_mod_cells-row_id

                 i_fieldname = 'EMAIL'
                  i_value = l_email.

gs_sbook-email = l_email.

MODIFY gt_sbook FROM gs_sbook INDEX ps_mod_cells-row_id.


ENDFORM.
