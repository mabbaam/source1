*&---------------------------------------------------------------------*
*& Include          ZBC405_A12_EXAM01_CLASS
*&---------------------------------------------------------------------*

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.

    CLASS-METHODS : on_toolbar FOR EVENT
      toolbar OF cl_gui_alv_grid
      IMPORTING e_object,

      on_usercommand FOR EVENT
        user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm,

*      on_doubleclick FOR EVENT
*        double_click OF cl_gui_alv_grid
*        IMPORTING e_row e_column es_row_no,

      on_data_changed FOR EVENT
        data_changed OF cl_gui_alv_grid
        IMPORTING er_data_changed,

      on_data_changed_finish FOR EVENT
        data_changed_finished OF cl_gui_alv_grid
        IMPORTING e_modified et_good_cells.





ENDCLASS.


CLASS lcl_handler IMPLEMENTATION.

*  METHOD on_doubleclick.
*    DATA : ls_col    TYPE lvc_s_col,
*           ls_row_no TYPE lvc_s_roid,
*           lv_value  TYPE c LENGTH 20.
*
*    CALL METHOD go_alv->get_current_cell
*      IMPORTING
**       e_row     =
*        e_value   = lv_value
**       e_col     =
**       es_row_id =
*        es_col_id = ls_col
*        es_row_no = ls_row_no.
*
*    CASE ls_col-fieldname.
*      WHEN 'CARRID' OR 'CONNID'.
*        READ TABLE gt_spfli INTO gs_spfli INDEX ls_row_no-row_id.
*        SUBMIT bc405_event_s4 WITH so_car = gs_spfli-carrid
*                              WITH so_con = gs_spfli-connid.
*
*    ENDCASE.
*  ENDMETHOD.

  METHOD on_data_changed_finish.
    DATA : ls_mod_cells TYPE lvc_s_modi.
    CHECK e_modified = 'X'.
    LOOP AT et_good_cells INTO ls_mod_cells.


      PERFORM changed_finished USING ls_mod_cells.
   ENDLOOP.
    ENDMETHOD.




  METHOD on_data_changed.
    DATA : ls_mod_cells TYPE lvc_s_modi.

    LOOP AT er_data_changed->mt_good_cells INTO ls_mod_cells.


      CASE ls_mod_cells-fieldname.

        WHEN 'FLTIME' OR 'DEPTIME'.


          PERFORM calculate_change USING er_data_changed
                                          ls_mod_cells.
      ENDCASE.


    ENDLOOP.
  ENDMETHOD.



  METHOD on_usercommand.
    DATA : ls_col  TYPE lvc_s_col,
           ls_roid TYPE lvc_s_roid.

    DATA: lt_rows  TYPE lvc_t_row,
          ls_rows  LIKE LINE OF lt_rows,
          xt_spfli TYPE TABLE OF spfli,
          ws_spfli LIKE LINE OF  xt_spfli.

    DATA : carrname TYPE scarr-carrname.

    CALL METHOD go_alv->get_current_cell
      IMPORTING
*       e_row     =
*       e_value   =
*       e_col     =
*       es_row_id =
        es_col_id = ls_col
        es_row_no = ls_roid.

    CALL METHOD go_alv->get_selected_rows
      IMPORTING
        et_index_rows = lt_rows.
*        et_row_no     =



    CASE e_ucomm.
      WHEN 'BUTTONMESSAGE'.
        READ TABLE gt_spfli INTO gs_spfli
              INDEX ls_roid-row_id.

        IF sy-subrc = 0.

          SELECT SINGLE carrname
            INTO carrname
            FROM scarr
            WHERE carrid = gs_spfli-carrid.
          IF sy-subrc = 0.
            MESSAGE i000(zt03_msg) WITH carrname.
          ENDIF.
        ENDIF.

      WHEN 'BUTTONINFO'.

        LOOP AT lt_rows INTO ls_rows.
          READ TABLE gt_spfli INTO gs_spfli INDEX ls_rows-index.

          IF sy-subrc = 0.
            MOVE-CORRESPONDING gs_spfli TO ws_spfli.
            APPEND ws_spfli TO xt_spfli.
          ENDIF.
        ENDLOOP.

        IF sy-subrc = 0.
          EXPORT mem_it_spfli FROM xt_spfli TO MEMORY ID 'BC405'.

          SUBMIT bc405_call_flights AND RETURN.
        ENDIF.


      WHEN 'BUTTONDATA'.
        READ TABLE gt_spfli INTO gs_spfli
        INDEX ls_roid-row_id.
        IF sy-subrc = 0.
          SET PARAMETER ID 'CAR' FIELD gs_spfli-carrid.
          SET PARAMETER ID 'CON' FIELD gs_spfli-connid.

          CALL TRANSACTION 'SAPBC410A_INPUT_FIEL'.

        ENDIF.
    ENDCASE.


  ENDMETHOD.






  METHOD on_toolbar.
    DATA : fb_button TYPE stb_button,
           fi_button TYPE stb_button,
           fd_button TYPE stb_button.

    fb_button-butn_type = '3'.
    INSERT fb_button INTO TABLE e_object->mt_toolbar.

    CLEAR : fb_button.
    fb_button-butn_type = '0'.
    fb_button-function = 'BUTTONMESSAGE'.
    fb_button-icon = ICON_Flight.
    fb_button-quickinfo = 'Information Message'.
    fb_button-text = 'Flight'.
    INSERT fb_button INTO TABLE e_object->mt_toolbar.

    CLEAR : fi_button.
    fi_button-butn_type = '0'.
    fi_button-function = 'BUTTONINFO'.
    fi_button-quickinfo = 'Goto Flight list info'.
    fi_button-text = 'Flight Info'.
    INSERT fi_button INTO TABLE e_object->mt_toolbar.

    CLEAR : fd_button.
    fd_button-butn_type = '0'.
    fd_button-function = 'BUTTONDATA'.
    fd_button-quickinfo = 'Flight Data'.
    fd_button-text = 'Flight Data'.
    INSERT fd_button INTO TABLE e_object->mt_toolbar.





  ENDMETHOD.


ENDCLASS.
