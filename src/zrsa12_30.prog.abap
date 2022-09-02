*&---------------------------------------------------------------------*
*& Report ZRSA12_30
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRSA12_30.

TYPES: BEGIN OF ts_info,
          stdno TYPE n LENGTH 8,
          sname TYPE c LENGTH 40,
      END OF ts_info.

data gs_std TYPE ts_info.

  gs_std-stdno = '20220001'.
  gs_std-sname = 'Kang SK'.
