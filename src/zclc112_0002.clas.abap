class ZCLC112_0002 definition
  public
  final
  create public .

public section.

  methods GER_MATERIAL_INFO
    importing
      !PI_MATNR type MAKT-MATNR
    exporting
      !PE_CODE type CHAR1
      !PE_MSG type CHAR100
    changing
      !ET_MAKTX type MAKT .
protected section.
private section.
ENDCLASS.



CLASS ZCLC112_0002 IMPLEMENTATION.


  method GER_MATERIAL_INFO.
  endmethod.
ENDCLASS.
