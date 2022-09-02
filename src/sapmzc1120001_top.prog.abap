*&---------------------------------------------------------------------*
*& Include SAPMZC1120001_TOP                        - Module Pool      SAPMZC1120001
*&---------------------------------------------------------------------*
PROGRAM sapmzc1120001 MESSAGE-ID zc226.

DATA : BEGIN OF gs_data,
         matnr TYPE zc1tt12003-matnr, "material
         werks TYPE zc1tt12003-werks, "Plant
         mtart TYPE zc1tt12003-mtart, "mat.type
         matkl TYPE zc1tt12003-matkl, "mat.gtoup
         menge TYPE zc1tt12003-menge, "quantity
         meins TYPE zc1tt12003-meins, "unit
         dmbtr TYPE zc1tt12003-dmbtr, "price
         waers TYPE zc1tt12003-waers, "currency
       END OF gs_data,

       gv_okcode TYPE sy-ucomm.
