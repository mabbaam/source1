*&---------------------------------------------------------------------*
*& Include          SAPMZSA1290_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_meal_info
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_meal_info USING VALUE(p_carrid)
                         VALUE(p_mealno)
                  CHANGING ps_meal_info TYPE zssa0091.


  CLEAR ps_meal_info.
  SELECT SINGLE *
    FROM smeal
    INTO CORRESPONDING FIELDS OF ps_meal_info
    WHERE carrid = p_carrid
    AND mealnumber = p_mealno.

  PERFORM get_airline_name USING ps_meal_info-carrid
                           CHANGING ps_meal_info-carrname.

  PERFORM get_meal_text USING ps_meal_info-carrid
                              ps_meal_info-mealnumber
                              sy-langu
                       CHANGING ps_meal_info-mealnumber_t.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_airline_name
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA0090_CARRID
*&      <-- ZSSA0090_CARRNAME
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_airline_name
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> PS_MEAL_INFO_CARRID
*&      <-- PS_MEAL_INFO_CARRNAME
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_airline_name
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> PS_MEAL_INFO_CARRID
*&      <-- PS_MEAL_INFO_CARRNAME
*&---------------------------------------------------------------------*
FORM get_airline_name  USING    VALUE(p_carrid)
                       CHANGING p_carrname.
  CLEAR p_carrname.
  SELECT SINGLE carrname
    FROM scarr
    INTO p_carrname
    WHERE carrid = p_carrid.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_meal_text
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> PS_MEAL_INFO_CARRID
*&      --> PS_MEAL_INFO_MEALNUMBER
*&      --> SY_LANGU
*&      <-- PS_MEAL_INFO_MEALNUMBER_T
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_meal_text
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ZSSA0090_CARRID
*&      --> ZSSA0090_MEALNUMBER
*&      --> SY_LANGU
*&      <-- ZSSA0090_MEALNUMBER_T
*&---------------------------------------------------------------------*
FORM get_meal_text  USING VALUE(p_carrid)
                          VALUE(p_mealno)
                          VALUE(p_langu)
                    CHANGING VALUE(p_meal_t).
  SELECT SINGLE text
    FROM smealt
    into p_meal_t
    WHERE carrid = p_carrid
    and mealnumber = p_mealno
    and sprache = p_langu.

ENDFORM.
