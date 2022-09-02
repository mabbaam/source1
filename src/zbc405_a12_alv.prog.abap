*&---------------------------------------------------------------------*
*& Report ZBC405_A12_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a12_alv.

TYPES : BEGIN OF typ_flt.
          INCLUDE TYPE sflight.
TYPES :   changes_possible TYPE icon-id.
TYPES : btn_text TYPE c LENGTH 10.
TYPES :   light TYPE c LENGTH 1.
TYPES : row_color TYPE c LENGTH 4.
TYPES : it_color TYPE lvc_t_scol.
TYPES : it_styl TYPE lvc_t_styl.
TYPES : END OF typ_flt.



DATA : gt_flt TYPE TABLE OF typ_flt. "sflight.
DATA : gs_flt TYPE typ_flt.
DATA : ok_code LIKE sy-ucomm.


"ALV DATA 선언
DATA : go_container TYPE REF TO cl_gui_custom_container,
       go_alv_grid  TYPE REF TO cl_gui_alv_grid,
       gv_variant   TYPE disvariant,
       gv_save      TYPE c LENGTH 1,
       gs_layout    TYPE LVC_s_layo,
       gt_sort      TYPE lvc_t_sort,
       gs_sort      TYPE lvc_s_sort,
       gs_color     TYPE lvc_s_scol,
       gt_exct      TYPE ui_functions,
       gt_fcat      TYPE lvc_t_fcat,
       gs_fcat      TYPE lvc_s_fcat,
       gs_styl      TYPE lvc_s_styl.


DATA : gs_stable       TYPE lvc_s_stbl,
       gv_soft_refresh TYPE abap_bool.



INCLUDE ZBC405_A12_ALV_class. "위치 중요



"Selection Screen

SELECT-OPTIONS : so_car FOR gs_flt-carrid MEMORY ID car,
                 so_con FOR gs_flt-connid MEMORY ID con,
                 so_dat FOR gs_flt-fldate.

SELECTION-SCREEN SKIP 1. " 공간을 준다

PARAMETERS : p_date TYPE sy-datum DEFAULT '20201001'.

PARAMETERS : pa_lv TYPE disvariant-variant.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_lv.

  gv_variant-report = sy-cprog.

  CALL FUNCTION 'LVC_VARIANT_SAVE_LOAD'
    EXPORTING
      i_save_load     = 'F'   " S ,F ,L
    CHANGING
      cs_variant      = gv_variant
    EXCEPTIONS
      not_found       = 1
      wrong_input     = 2
      fc_not_complete = 3
      OTHERS          = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here

  ELSE.
    pa_lv = gv_variant-variant.
  ENDIF.





START-OF-SELECTION.


  PERFORM get_data.


  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T10' WITH sy-datum sy-uname.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.

    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.

      CALL METHOD go_alv_grid->free.
      CALL METHOD go_container->free.

      FREE : go_alv_grid, go_container.

      LEAVE TO SCREEN 0. "Set screen 0.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CREATE_AND_TRANSFER OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_and_transfer OUTPUT.

  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'
      EXCEPTIONS
        OTHERS         = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.



    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent = go_container
      EXCEPTIONS
        OTHERS   = 5.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    PERFORM make_variant.
    PERFORM make_layout.
    PERFORM make_sort.
    PERFORM make_fieldcatalog.



    APPEND cl_gui_alv_grid=>mc_fc_filter TO gt_exct.
    APPEND cl_gui_alv_grid=>mc_fc_info TO gt_exct.

*    append cl_gui_alv_grid=>mc_fc_excl_all to gt_exct. "전체 툴바를 없앤다.

    "클래스의  어트리뷰트를 직접쓰는 문법 (이중 화살표를 쓴다)


    SET HANDLER lcl_handler=>on_doubleclick FOR go_alv_grid. "이벤트 트리거
*    SET HANDLER lcl_handler=>on_hotspot FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_toolbar FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_user_command FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_button_click FOR go_alv_grid.

    SET HANDLER lcl_handler=>on_toolbar_air FOR go_alv_grid.

    SET HANDLER lcl_handler=>on_context_menu_request FOR go_alv_grid.
    SET HANDLER lcl_handler=>on_before_user_com FOR go_alv_grid.



    CALL METHOD go_alv_grid->set_table_for_first_display
      EXPORTING
*       i_buffer_active               =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name              = 'SFLIGHT'
        is_variant                    = gv_variant
        i_save                        = gv_save       "X ,A, U
        i_default                     = 'X'
        is_layout                     = gs_layout
*       is_print                      =
*       it_special_groups             =
        it_toolbar_excluding          = gt_exct
*       it_hyperlink                  =
*       it_alv_graphics               =
*       it_except_qinfo               =
*       ir_salv_adapter               =
      CHANGING
        it_outtab                     = gt_flt
        it_fieldcatalog               = gt_fcat
        it_sort                       = gt_sort
*       it_filter                     =
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.
    IF sy-subrc <> 0.
* Implement suitable error handling here

    ELSE.

      gv_soft_refresh = 'X'.
      gs_stable-row = 'X'.
      gs_stable-col = 'X'.

      CALL METHOD go_alv_grid->refresh_table_display
        EXPORTING
          is_stable      = gs_stable
          i_soft_refresh = gv_soft_refresh
        EXCEPTIONS
          finished       = 1
          OTHERS         = 2.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

    ENDIF.





  ENDIF.

ENDMODULE.
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
     FROM sflight
     INTO CORRESPONDING FIELDS OF TABLE gt_flt
     WHERE carrid IN so_car
     AND connid IN so_con
     AND  fldate IN so_dat.



  LOOP AT gt_flt INTO gs_flt.

    IF gs_flt-seatsocc < 5.
      gs_flt-light = 1. " red

    ELSEIF gs_flt-seatsocc < 100.
      gs_flt-light = 2. "yellow

    ELSE.
      gs_flt-light = 3. "green.
    ENDIF.


    IF gs_flt-fldate+4(2) = sy-datum+4(2).
      gs_flt-row_color = 'C311'.
    ENDIF.


    IF gs_flt-planetype = '747-400'.

      gs_color-fname = 'PLANETYPE'.
      gs_color-color-col = col_total. "total 은 노란색
      gs_color-color-int = '0'. "0주면 연하게 ... 1주면 진하게
      gs_color-color-inv = '0'. "배경색이 바뀌는...
      APPEND gs_color TO gs_flt-it_color.
    ENDIF.

    IF gs_flt-seatsocc_b = 0.
      gs_color-fname = 'SEATSOCC_B'.
      gs_color-color-col = col_negative. "negative 은 빨간색
      gs_color-color-int = '1'.
      gs_color-color-inv = '0'.
      APPEND gs_color TO gs_flt-it_color.

    ENDIF.


    IF gs_flt-fldate < p_date.

      gs_flt-changes_possible = icon_space.
    ELSE.
      gs_flt-changes_possible = icon_okay.
    ENDIF.


    IF gs_flt-seatsmax_b = gs_flt-seatsocc_b.
      gs_flt-btn_text = 'FullSeats!'.

      gs_styl-fieldname = 'BTN_TEXT'.
      gs_styl-style = cl_gui_alv_grid=>mc_style_button.
      APPEND gs_styl TO gs_flt-it_styl.

    ENDIF.


    MODIFY gt_flt FROM gs_flt.
  ENDLOOP.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_variant
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_variant .
  gv_variant-report = sy-cprog.
  gv_variant-variant = pa_lv.
  gv_save = 'A'.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_layout .


  gs_layout-zebra = 'X'. "줄마다 색이 다르게보여 가시성 좋아짐
  gs_layout-cwidth_opt = 'X'. "화면 크기에 맞춰서 보이게함
  gs_layout-sel_mode = 'D'. "A, B, C, D .. 셀렉션필드,멀티플row,선택...

  gs_layout-excp_fname = 'LIGHT'. " exception handling field 설정
  gs_layout-excp_led = 'X'.  "다른 스타일의 신호등!

  gs_layout-info_fname = 'ROW_COLOR'.

  gs_layout-ctab_fname = 'IT_COLOR'.

  gs_layout-stylefname = 'IT_STYL'.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form make_sort
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM make_sort .

  CLEAR gs_sort.

  gs_sort-fieldname = 'CARRID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 1.
  APPEND gs_sort TO gt_sort.


  gs_sort-fieldname = 'CONNID'.
  gs_sort-up = 'X'.
  gs_sort-spos = 2.
  APPEND gs_sort TO gt_sort.


  gs_sort-fieldname = 'FLDATE'.
  gs_sort-up = 'X'.
  gs_sort-spos = 3.
  APPEND gs_sort TO gt_sort.


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
  gs_fcat-fieldname = 'CARRID'.
  gs_fcat-hotspot = 'X'.
  APPEND gs_fcat TO gt_fcat.



  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'LIGHT'.
  gs_fcat-coltext = 'Info'.
  APPEND gs_fcat TO gt_fcat.


  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'PRICE'.
*  gs_fcat-emphasize = 'C610'.
  gs_fcat-no_out = 'X'.
  gs_fcat-edit = 'X'. "입력 혹은 변경이 가능하게된다.
  APPEND gs_fcat TO gt_fcat.

  CLEAR : gs_fcat.
  gs_fcat-fieldname = 'CHANGES_POSSIBLE'.
  gs_fcat-coltext = 'Chang.Poss'.
  gs_fcat-col_opt = 'X'.
  gs_fcat-col_pos = 5. "5번째 안주면 맨앞으로 감
*  gs_fcat-icon = 'X'.
  APPEND gs_fcat TO gt_fcat.



  CLEAR: gs_fcat.
  gs_fcat-fieldname = 'BTN_TEXT'.
  gs_fcat-coltext = 'Status'.
  gs_fcat-col_pos =  12.
  APPEND gs_fcat TO gt_fcat.

ENDFORM.
