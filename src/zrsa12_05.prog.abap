*&---------------------------------------------------------------------*
*& Report ZRSA12_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_05.


PARAMETERS:pa_carr TYPE scarr-carrid.

DATA gs_scarr TYPE scarr.

SELECT single *
   FROM scarr
   INTO gs_scarr
  WHERE carrid = pa_carr.

IF sy-subrc = 0.
  NEW-LINE.
  WRITE: gs_scarr-carrid, gs_scarr-carrname,
         gs_scarr-url.

ELSE.
  WRITE 'Sorry, no data found'(M01).



ENDIF.



*WRITE 'First Name'(t02).
*WRITE 'New Name'(t02).



*WRITE text-t01. "Last Name
*WRITE text-t01. "Last Name


*WRITE 'Last Name:'.
*
*WRITE 'Last Name:'.




*DATA gv_ecode TYPE c LENGTH 4 VALUE 'SYNC'.
*CONSTANTS gc_ecode TYPE c LENGTH 4 VALUE 'SYNC'.
*
*WRITE gv_ecode.
*
*gv_ecode = 'Test'.



*TYPES t_name TYPE c LENGTH 40.
*
*DATA gv_name TYPE t_name.
*DATA gv_cname TYPE t_name.



*DATA: gv_name TYPE c LENGTH 20,
*      gv_cname LIKE gv_name.



*DATA gv_p TYPE p LENGTH 2 DECIMALS 2.
*gv_p = '1.23'. "소수점뒤는 Decimals 2자리. 앞에는 Length는  2n-1
*WRITE gv_p.




*DATA: gv_n1 TYPE n,
*      gv_n2 TYPE n LENGTH 2,
*      gv_i TYPE i.
*
*WRITE: gv_n1, gv_n2, gv_i.



*DATA: gv_c1 TYPE c LENGTH 1,
*      gv_c2(1) TYPE c,
*      gv_c3 TYPE c,
*      gv_c4.
** 위의것들은 모두 타입c의 1자리수!



*DATA gv_d1 TYPE d.
*DATA gv_d2 TYPE sy-datum.
*
*WRITE: gv_d1, gv_d2.
