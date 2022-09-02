class ZCL_IM_BC425IM112 definition
  public
  final
  create public .

public section.

  interfaces IF_EX_BADI_BOOK12 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_BC425IM112 IMPLEMENTATION.


  method IF_EX_BADI_BOOK12~CHANGE_VLINE.

    c_pos = c_pos + 37.
  endmethod.


  method IF_EX_BADI_BOOK12~OUTPUT.


      data: name TYPE s_custname.
      SELECT SINGLE name FROM scustom into name
        where id = i_booking-customid.
        WRITE: name, i_booking-order_date.

  endmethod.
ENDCLASS.
