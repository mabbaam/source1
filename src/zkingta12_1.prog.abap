*&---------------------------------------------------------------------*
*& Report ZKINGTA12_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zkingta12_1.

                                                            "ZSSA1271

DATA : BEGIN OF ls_data,
         bukrs TYPE zssa1271-bukrs,
         belnr TYPE zssa1271-belnr,
       END OF ls_data,

       lt_data like TABLE OF ls_data,
       ls_data_tmp like ls_data,

       ls_loekz TYPE ekpo-loekz.
