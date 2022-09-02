*&---------------------------------------------------------------------*
*& Include          ZC1R120002_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .

  CLEAR   gs_data.
  REFRESH gt_data.

  SELECT pernr ename gender entdt depid
    INTO CORRESPONDING FIELDS OF TABLE gt_data
    FROM ztsa1201.

  IF sy-subrc <> 0.
    MESSAGE s001.
    LEAVE LIST-PROCESSING.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat_layout .
  gs_layout-zebra      = 'X'.
*  gs_layout-sel_mode   = 'D'.
  gs_layout-cwidth_opt = 'X'.

  IF gt_fcat IS INITIAL.

    PERFORM set_fcat USING :
    'X'   'PERNR'   ' '   'ztsa1201'    'PERNR'    'X'  10,
    ' '   'ENAME'   ' '   'ztsa1201'    'ENAME'    'X'  20,
    ' '   'ENTDT'   ' '   'ztsa1201'    'ENTDT'    'X'  10,
    ' '   'DEPID'   ' '   'ztsa1201'    'DEPID'    'X'  8.


  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_fcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat  USING pv_key
                     pv_field
                     pv_text
                     pv_ref_table
                     pv_ref_field
                     pv_edit
                     pv_length.



  gt_fcat = VALUE #( BASE gt_fcat
                     (
                       key       = pv_key
                       fieldname = pv_field
                       coltext   = pv_text
                       ref_table = pv_ref_table
                       ref_field = pv_ref_field
                       edit      = pv_edit
                       outputlen = pv_length
                     )
                   ).


ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_data .

  IF gcl_container IS NOT BOUND.

    CREATE OBJECT gcl_container
      EXPORTING
        repid     = sy-repid
        dynnr     = sy-dynnr
        side      = gcl_container->dock_at_left
        extension = 3000.

    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_container.

    gs_variant-report = sy-repid.

    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant      = gs_variant
        i_save          = 'A'
        i_default       = 'X'
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_fcat.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_row
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_row .
  CLEAR gs_data.

  APPEND gs_data TO gt_data.

  PERFORM refresh_grid.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form refresh_grid
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM refresh_grid .

 gs_stable-row = 'X'.
  gs_stable-col = 'X'.

  CALL METHOD gcl_grid->refresh_table_display
    EXPORTING
      is_stable      = gs_stable
      i_soft_refresh = space.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form save_emp
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM save_emp .
 DATA : lt_save TYPE TABLE OF ztsa1201,
         lv_error.

  REFRESH lt_save.

  CALL METHOD gcl_grid->check_changed_data. "ALV의 입력된 값을 ITAB으로 반영시킴

  CLEAR lv_error. "필수 입력값 입력 여부 체크
  LOOP AT gt_data INTO gs_data.

    IF gs_data-pernr IS INITIAL.
      MESSAGE s000 WITH TEXT-e01 DISPLAY LIKE 'E'.
      lv_error = 'X'.   "에러발생 했을 경우 저장 플로우 수행방지 위해서 값을 세팅
      EXIT.             "현재 수행중인 루틴을 빠져나감 : 지금은 LOOP 를 빠져나감
    ENDIF.

    lt_save = VALUE #( BASE lt_save "에러 없는 데이터는 저장할 ITAB에 데이터 저장
                       (
                         pernr  = gs_data-pernr
                         ename  = gs_data-ename
                         entdt  = gs_data-entdt
                         depid  = gs_data-depid

                       )
                     ).
  ENDLOOP.

*  CHECK lv_error IS INITIAL. " 에러가 없었으면 아래 로직 수행
  IF lv_error IS NOT INITIAL. " 에러가 있었으면 현재 루틴 빠져나감
    EXIT.
  ENDIF.

  IF lt_save IS NOT INITIAL.

    MODIFY ztsa1201 FROM TABLE lt_save.

    IF sy-dbcnt > 0.
      COMMIT WORK AND WAIT.
      MESSAGE s002. "Data 저장 성공 메시지
    ENDIF.

  ENDIF.


ENDFORM.
