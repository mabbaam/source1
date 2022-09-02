class ZCL_AIRPLANE_A12 definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IV_NAME type STRING
      !IV_PLANETYPE type SAPLANE-PLANETYPE
    exceptions
      WRONG_PLANETYPE .
  methods DISPLAY_ATTRIBUTES .
  class-methods CLASS_CONSTRUCTOR .
  class-methods DISPLAY_N_O_AIRPLANES .
protected section.
private section.

  constants C_POS_I type I value 30 ##NO_TEXT.
  data MV_NAME type STRING .
  data MV_PLANETYPE type SAPLANE-PLANETYPE .
  data MV_WEIGHT type SAPLANE-WEIGHT .
  data MV_TANKCAP type SAPLANE-TANKCAP .
  class-data GV_N_O_AIRPLANES type I .
  class-data MT_PLANETYPES type TY_PLANETYPES .
ENDCLASS.



CLASS ZCL_AIRPLANE_A12 IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.

    select *
      into TABLE MT_PLANEtypes
      FROM saplane.


  endmethod.


  METHOD constructor.

    mv_name = iv_name.
    mv_planetype = iv_planetype.

    DATA : ls_planetype TYPE saplane.

    READ TABLE mt_planetypes INTO ls_planetype
            WITH KEY planetype = iv_planetype.

    IF sy-subrc = 0.
      gv_n_o_airplanes = gv_n_o_airplanes + 1.
      mv_weight = ls_planetype-weight.
      mv_tankcap = ls_planetype-tankcap.
    ELSE.

      RAISE wrong_planetype.

    ENDIF.

  ENDMETHOD.


  method DISPLAY_ATTRIBUTES.

      WRITE : / icon_ws_plane as ICON,
            / 'Name of airplane', AT c_pos_i mv_name,
            / 'Type of airplane', AT c_pos_i mv_planetype.

  endmethod.


  method DISPLAY_N_O_AIRPLANES.
    write : / 'number of airplane', at c_pos_i gv_n_o_airplanes.

  endmethod.
ENDCLASS.
