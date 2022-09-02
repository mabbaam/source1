*&---------------------------------------------------------------------*
*& Include ZRSA12_26_TOP                            - Report ZRSA12_26
*&---------------------------------------------------------------------*
REPORT zrsa12_26.

DATA: BEGIN OF gs_info,
        carrid     TYPE sflight-carrid,
        connid     TYPE sflight-connid,
        fldate     TYPE sflight-fldate,
        price      TYPE sflight-price,
        currency   TYPE sflight-currency,
        seatsocc   TYPE sflight-seatsocc,
        seatsmax   TYPE sflight-seatsmax,
        seatremain TYPE c LENGTH 3,
        seatsocc_b TYPE sflight-seatsocc_b,
        seatsmax_b TYPE sflight-seatsmax_b,
        seatsocc_f TYPE sflight-seatsocc_f,
        seatsmax_f TYPE sflight-seatsmax_f,
        cityfrom   TYPE spfli-cityfrom,
        cityto     TYPE spfli-cityto,
        carrname   TYPE scarr-carrname,

      END OF gs_info.

data gt_info LIKE TABLE OF gs_info.

      PARAMETERS: pa_car TYPE sbook-carrid,
                  pa_con1 TYPE sbook-connid,
                  pa_con2 TYPE sbook-connid.
