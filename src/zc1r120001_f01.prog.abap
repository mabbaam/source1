*&---------------------------------------------------------------------*
*& Include          ZC1R120001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form init_param
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_param .

  pa_carr = 'KA'.

ENDFORM.
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

  SELECT carrid connid fldate price currency planetype
     INTO CORRESPONDING FIELDS OF TABLE gt_data
     FROM sflight
    WHERE carrid = pa_carr
    AND connid IN so_conn.

  IF sy-subrc NE 0.
    MESSAGE s001.
    LEAVE LIST-PROCESSING. "stop
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

  gs_layout-zebra        = 'X'.
  gs_layout-sel_mode     = 'D'.
  gs_layout-cwidth_opt   = 'X'.

  IF gt_fcat IS INITIAL.
      PERFORM set_fcat USING :
      'X'  'CARRID'      ' '   'SFLIGHT'  'CARRID',
      'X'  'CONNID'      ' '   'SFLIGHT'  'CONNID',
      'X'  'FLDATE'      ' '   'SFLIGHT'  'FLDATE',
      'X'  'PRICE'       ' '   'SFLIGHT'  'PRICE',
      'X'  'CURRENCY'    ' '   'SFLIGHT'  'CURRENCY',
      'X'  'PLANETYPE'   ' '   'SFLIGHT'  'PLANETYPE'.

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
FORM set_fcat  USING pv_key pv_field pv_text pv_ref_table pv_ref_field.


  gt_fcat = VALUE #( BASE gt_fcat
                     (
                     key       = pv_key
                     fieldname = pv_field
                     coltext   = pv_text
                     ref_table = pv_ref_table
                     ref_field = pv_ref_field
                     )
                     ).

*  gs_fcat-key = pv_key.
*  gs_fcat-fieldname = pv_field.
*  gs_fcat-coltext = pv_text.
*  gs_fcat-ref_table = pv_ref_table.
*  gs_fcat-ref_field = pv_ref_field.






ENDFORM.
