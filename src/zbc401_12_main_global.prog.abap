*&---------------------------------------------------------------------*
*& Report ZBC401_12_MAIN_GLOBAL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC401_12_MAIN_GLOBAL.

DATA : go_airplane TYPE ref to zcl_airplane_a12.
data : gt_airplanes TYPE TABLE of ref to zcl_airplane_a12.

START-OF-SELECTION.

call METHOD zcl_airplane_a12=>display_n_o_airplanes.


CREATE OBJECT go_airplane
  EXPORTING
    iv_name      = 'LH Berlin'
    iv_planetype = 'A321'
  EXCEPTIONS
   wrong_planetype = 1
   others       = 2
  .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

  else.
    APPEND go_airplane to gt_airplanes.
ENDIF.




CREATE OBJECT go_airplane
  EXPORTING
    iv_name      = 'AA New York'
    iv_planetype = '747-400'
  EXCEPTIONS
   wrong_planetype = 1
   others       = 2
  .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

else.

  APPEND go_airplane to gt_airplanes.
  endif.



CREATE OBJECT go_airplane
  EXPORTING
    iv_name      = 'US Herculs'
    iv_planetype = '747-200F'
  EXCEPTIONS
   wrong_planetype = 1
   others       = 2
  .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

else.
  APPEND go_airplane to gt_airplanes.
  ENDIF.

  loop at gt_airplanes into go_airplane.
    call METHOD go_airplane->display_attributes.
    ENDLOOP.

    call METHOD zcl_airplane_a12=>display_n_o_airplanes.
