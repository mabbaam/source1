*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZSCARR_A12......................................*
DATA:  BEGIN OF STATUS_ZSCARR_A12                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSCARR_A12                    .
CONTROLS: TCTRL_ZSCARR_A12
            TYPE TABLEVIEW USING SCREEN '0017'.
*...processing: ZSFLIGHT_A12....................................*
DATA:  BEGIN OF STATUS_ZSFLIGHT_A12                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSFLIGHT_A12                  .
CONTROLS: TCTRL_ZSFLIGHT_A12
            TYPE TABLEVIEW USING SCREEN '0015'.
*...processing: ZSPFLI_A12......................................*
DATA:  BEGIN OF STATUS_ZSPFLI_A12                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSPFLI_A12                    .
CONTROLS: TCTRL_ZSPFLI_A12
            TYPE TABLEVIEW USING SCREEN '0019'.
*.........table declarations:.................................*
TABLES: *ZSCARR_A12                    .
TABLES: *ZSFLIGHT_A12                  .
TABLES: *ZSPFLI_A12                    .
TABLES: ZSCARR_A12                     .
TABLES: ZSFLIGHT_A12                   .
TABLES: ZSPFLI_A12                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
