*&---------------------------------------------------------------------*
*& Report ZRSA12_26
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zrsa12_26_top                           .    " Global Data

* INCLUDE ZRSA12_26_O01                           .  " PBO-Modules
* INCLUDE ZRSA12_26_I01                           .  " PAI-Modules
INCLUDE zrsa12_26_f01                           .  " FORM-Routines.

"Event

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  CLEAR gt_info.
  SELECT *
    FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_info
    WHERE carrid = pa_car
    AND connid = pa_con1
   OR carrid = pa_car AND connid = pa_con2.

  CLEAR gs_info.

  LOOP AT gt_info INTO gs_info.
    SELECT SINGLE carrname
      FROM scarr
      INTO gs_info-carrname
      WHERE carrid = gs_info-carrid.

    SELECT SINGLE cityfrom cityto
      FROM spfli
      INTO CORRESPONDING FIELDS OF gs_info
      WHERE carrid = gs_info-carrid
      AND connid = gs_info-connid.

   gs_info-seatremain = gs_info-SEATSMAX - gs_info-SEATSOCC.


    MODIFY gt_info FROM gs_info.
    CLEAR gs_info.


  ENDLOOP.


  cl_demo_output=>display_data( gt_info ).
