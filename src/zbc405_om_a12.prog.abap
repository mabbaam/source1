*&---------------------------------------------------------------------*
*& Report ZBC405_OM_A12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_om_a12.

TABLES : spfli.


SELECT-OPTIONS : so_car FOR spfli-carrid MEMORY ID car,
                 so_con FOR spfli-connid MEMORY ID con.

DATA : gt_spfli TYPE TABLE OF spfli,
       gs_spfli TYPE spfli.

DATA : go_alv     TYPE REF TO cl_salv_table, " 메인 !
       go_func    TYPE REF TO cl_salv_functions_list,
       go_disp    TYPE REF TO cl_salv_display_settings,
       go_columns TYPE REF TO cl_salv_columns_table,
       go_column  TYPE REF TO cl_salv_column_table,
       go_cols    TYPE REF TO cl_salv_column,
       go_layout TYPE REF TO cl_salv_layout,
       go_selc  TYPE REF TO cl_salv_selections.



START-OF-SELECTION.

  SELECT *
    INTO TABLE gt_spfli
    FROM spfli
    WHERE carrid IN so_car
      AND connid IN so_con.


  TRY.
      CALL METHOD cl_salv_table=>factory
        EXPORTING
          list_display = ' ' " IF_SALV_C_BOOL_SAP=>FALSE
*         r_container  =
*         container_name =
        IMPORTING
          r_salv_table = go_alv
        CHANGING
          t_table      = gt_spfli.
    CATCH cx_salv_msg.
  ENDTRY. "try는 의도치 않는 덤프 방지용 !


  CALL METHOD go_alv->get_functions
    RECEIVING
      value = go_func.
  CALL METHOD go_func->set_filter
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP=>TRUE
    .
  CALL METHOD go_func->set_sort_asc
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP=>TRUE
    .
  CALL METHOD go_func->set_sort_desc
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP=>TRUE
    .
  CALL METHOD go_func->set_all
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP=>TRUE
    .

  "Display setting
  CALL METHOD go_alv->get_display_settings
    RECEIVING
      value = go_disp.


  CALL METHOD go_disp->set_list_header
    EXPORTING
      value = 'SALV DEMO!!!'.



  CALL METHOD go_alv->get_columns
    RECEIVING
      value = go_columns.

  CALL METHOD go_columns->set_optimize "압축 !
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP~TRUE
    .

  TRY.
      CALL METHOD go_columns->get_column "100번 클라이언트를 없애보자
        EXPORTING
          columnname = 'MANDT' "이걸 없애주는것은? 테크와 타입이 다르다 눈감아줘
        RECEIVING
          value      = go_cols.
    CATCH cx_salv_not_found.
  ENDTRY.



CALL METHOD go_cols->set_technical
*  EXPORTING
*    value  = IF_SALV_C_BOOL_SAP=>TRUE
  .


*  go_column ?= go_cols.  "casting type이 달라도 구문오류 없이 인정해줘!
*
*  CALL METHOD go_column->set_technical.

TRY.  "색상을 넣어보자.
CALL METHOD go_columns->get_column
  EXPORTING
    columnname ='FLTIME'
  receiving
    value      = go_cols.
  CATCH cx_salv_not_found.
ENDTRY.


go_column ?= go_cols.

data: g_color TYPE lvc_s_colo.

g_color-col = '5'.
g_color-int = '1'.
g_color-inv = '0'.


CALL METHOD go_column->set_color
  EXPORTING
    value = g_color.


CALL METHOD go_alv->get_layout
  RECEIVING
    value = go_layout.

data : g_program TYPE salv_s_layout_key.

g_program-report = sy-cprog.

CALL METHOD go_layout->set_key
  EXPORTING
    value = g_program.


CALL METHOD go_layout->set_save_restriction
  EXPORTING
    value  = IF_SALV_C_LAYOUT=>RESTRICT_NONE
  .

CALL METHOD go_layout->set_default
  EXPORTING
    value ='X'.


"selection mode
CALL METHOD go_alv->get_selections
  RECEIVING
    value = go_selc.


CALL METHOD go_selc->set_selection_mode
  EXPORTING
    value  = IF_SALV_C_SELECTION_MODE=>row_column.
  .

CALL METHOD go_selc->set_selection_mode
  EXPORTING
    value  = IF_SALV_C_SELECTION_MODE=>cell.
  .


  CALL METHOD go_alv->display.
