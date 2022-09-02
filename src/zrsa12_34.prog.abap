*&---------------------------------------------------------------------*
*& Report ZRSA12_34
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrsa12_34.

"Dep info
DATA gs_dep TYPE zssa1211.
DATA gt_dep LIKE TABLE OF gs_dep.

"Emp info (structure Variable )
DATA gs_emp LIKE LINE OF gs_dep-emp_list. " 스트럭처안에 인터널테이블 그것을가지고 변수를 선언

PARAMETERS pa_dep TYPE ztsa1202-depid.


START-OF-SELECTION.
  SELECT SINGLE *
    FROM ztsa1202 "Dep Table
    INTO CORRESPONDING FIELDS OF gs_dep
    WHERE depid = pa_dep.

  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  " Get Employee List
  SELECT *
    FROM ztsa0001 "Employee table
    INTO CORRESPONDING FIELDS OF TABLE gs_dep-emp_list
    WHERE depid = gs_dep-depid.

  LOOP AT gs_dep-emp_list INTO gs_emp.

    MODIFY gs_dep-emp_list FROM gs_emp.
    CLEAR gs_emp.
  ENDLOOP.
