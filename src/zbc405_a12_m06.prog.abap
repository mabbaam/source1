*&---------------------------------------------------------------------*
*& Report ZBC405_A12_M06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_a12_m06.


  "ZTSA2001

TYPES : BEGIN OF ts_emp,
          pernr  TYPE ztsa2001-pernr,
          ename  TYPE ztsa2001-ename,
          depid  TYPE ztsa2001-depid,
          gender TYPE ztsa2001-gender,
          gender_t TYPE c LENGTH 10,
          phone TYPE ztsa2002-phone,
        END OF ts_emp.

DATA : gs_emp TYPE ts_emp,
       gt_emp LIKE TABLE OF gs_emp,
       gs_dep TYPE ztsa2002, "스트럭처타입의 변수
       gt_dep TYPE TABLE OF ztsa2002.

*select SINGLE pernr ename depid gender
*  FROM ztsa2001 "진짜 데이터베이스
*  into gs_emp
*  WHERE pernr = '20220001'.   "조건은 key
*
*  WRITE : '사원명' , gs_emp-pernr.
*  NEW-LINE.
*  WRITE : 'ENAME' , gs_emp-ENAME.
*  NEW-LINE.
*  WRITE : '부서코드' , gs_emp-depid.
*  WRITE : /'성별' , gs_emp-gender.



" Loop
SELECT *
  FROM ztsa2001
  into CORRESPONDING FIELDS OF TABLE gt_emp.

*  loop at gt_emp into gs_emp. "스트럭처를 활용해야 데이터핸들링 가능
*
*  case gs_emp-gender.
*    when '1'.
*      gs_emp-gender_t = '남성'.
*    WHEN '2'.
*      gs_emp-gender_t = '여성'.
*      ENDCASE.
*
*      SELECT SINGLE phone
*        FROM ztsa2002
*        INTO CORRESPONDING FIELDS OF gs_emp
*        WHERE depid = gs_emp-depid.
*
*  MODIFY gt_emp FROM gs_emp.
*  CLEAR gs_emp.
*  ENDLOOP.


SELECT *
  FROM ztsa2002
  into CORRESPONDING FIELDS OF table gt_dep
  where depid BETWEEN 'D001' and 'D003'. " 이렇게 만들어 놓고

"loop
  CLEAR gs_emp.
  loop at gt_emp into gs_emp.

    read TABLE gt_dep into gs_dep
    with key depid = gs_emp-depid.

    gs_emp-phone = gs_dep-phone.


    MODIFY gt_emp FROM gs_emp.
    CLEAR : gs_emp,gs_dep.
   ENDLOOP.

  cl_demo_output=>display_data( gt_emp ).
