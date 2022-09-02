*&---------------------------------------------------------------------*
*& Include ZBC405_A12_TOP                           - Report ZBC405_A12
*&---------------------------------------------------------------------*
REPORT zbc405_a12.

DATA : gs_flight TYPE dv_flights.

CONSTANTS gc_mark VALUE 'X'.

SELECT-OPTIONS: so_car FOR gs_flight-carrid MEMORY ID car,
                so_con FOR gs_flight-connid.

SELECT-OPTIONS so_fdt FOR gs_flight-fldate NO-EXTENSION.

SELECTION-SCREEN BEGIN OF BLOCK radio WITH FRAME.
  PARAMETERS : pa_all RADIOBUTTON GROUP rd1,
               pa_nat RADIOBUTTON GROUP rd1,
               pa_int RADIOBUTTON GROUP rd1 DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK radio.
