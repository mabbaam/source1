*&---------------------------------------------------------------------*
*& Include          ZSTDA1201_F01
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

  SELECT a~carrid a~carrname a~url
         b~connid b~fldate b~planetype b~price b~currency
    FROM       scarr   AS a
    INNER JOIN sflight AS b
    ON    a~carrid = b~carrid
    INTO CORRESPONDING FIELDS OF TABLE gt_data
    WHERE a~carrid    IN so_carr
    AND   b~connid    IN so_conn
    AND   b~planetype IN so_plan.


  IF sy-subrc NE 0.
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
  gs_layout-sel_mode   = 'D'.
  gs_layout-cwidth_opt = 'X'.

  "key field coltext ref_t ref_f currnecy
  PERFORM set_fcat USING :
        'X'  'CARRID'    '바꿈'  'SCARR'    'CARRID'    ' ',
        'X'  'CARRNAME'  '  '   'SCARR'    'CARRNAME'  ' ',
        'X'  'CONNID'    '  '   'SFLIGHT'  'CONNID'    ' ',
        'X'  'FLDATE'    '  '   'SFLIGHT'  'FLDATE'    ' ',
        'X'  'PLANETYPE' '  '   'SFLIGHT'  'PLANETYPE' ' ',
        'X'  'PRICE'     '  '   'SFLIGHT'  'PRICE'     ' ',
        'X'  'CURRENCY'  '  '   'SCARR'    'CURRENCY'  ' ',
        'X'  'URL'       '  '   'SCARR'    'URL'       ' '.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
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
*&      --> P_
*&---------------------------------------------------------------------*
FORM set_fcat  USING pv_key pv_fname pv_text pv_ref_t pv_ref_f pv_curr.

  CLEAR gs_fcat.

  gs_fcat-key        = pv_key.
  gs_fcat-fieldname  = pv_fname.
  gs_fcat-coltext    = pv_text.
  gs_fcat-ref_table  = pv_ref_t.
  gs_fcat-ref_field  = pv_ref_f.
  gs_fcat-cfieldname = pv_curr.

  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_screen
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_screen .

  IF gcl_con IS NOT BOUND. "is initial.

    CREATE OBJECT gcl_con
      EXPORTING
        repid     = sy-repid
        dynnr     = sy-dynnr
        side      = gcl_con->dock_at_left
        extension = 3000.

    CREATE OBJECT gcl_grid
      EXPORTING
        i_parent = gcl_con.

    gs_variant-report = sy-repid.

    CALL METHOD gcl_grid->set_table_for_first_display
      EXPORTING
        is_variant      = gs_variant
        i_save          = 'A'
        i_default       = 'X'
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_fcat.


  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form on_double_click
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW
*&      --> E_COLUMN
*&---------------------------------------------------------------------*
FORM on_double_click  USING ps_row    TYPE lvc_s_row
                            ps_column TYPE lvc_s_col.

  READ TABLE gt_data INTO gs_data INDEX ps_row-index.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  IF ps_column-fieldname NE 'PLANETYPE'.
    SELECT carrid connid fldate bookid customid custtype
           luggweight wunit

     FROM sbook
      INTO CORRESPONDING FIELDS OF TABLE gt_sbook
      WHERE carrid = gs_data-carrid
      AND connid = gs_data-connid
      AND fldate = gs_data-fldate.

cl_demo_output=>display_data( GT_SBOOK ).

  ENDIF.


ENDFORM.
