*&---------------------------------------------------------------------*
*& Include          ZBC405_A12_LE01
*&---------------------------------------------------------------------*

*select * from dv_flights
*   into gs_flt.
*
*
*  write : /10(5) gs_flt-carrid,16(5) gs_flt-connid,22(10) gs_flt-fldate,
*            gs_flt-price CURRENCY gs_flt-currency.
*  endselect.

INITIALIZATION.

  MOVE: 'AA' TO so_car-low,
        'QF' TO so_car-high,
        'BT' TO so_car-option,
        'I' TO so_car-sign.
  APPEND so_car.

  CLEAR so_car.
  MOVE: 'AZ' TO so_car-low,
        'EQ' TO so_car-option,
        'E' TO so_car-sign.
  APPEND so_car.
