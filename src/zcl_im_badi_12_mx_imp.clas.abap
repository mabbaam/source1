class ZCL_IM_BADI_12_MX_IMP definition
  public
  final
  create public .

public section.

  interfaces IF_EX_BADI_12_MX .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_BADI_12_MX_IMP IMPLEMENTATION.


  method IF_EX_BADI_12_MX~EXIT_MENU_BOOK.

    set PARAMETER ID:
    'CAR' FIELD is_book-carrid,
    'CON' FIELD is_book-connid,
    'DAY' FIELD is_book-fldate,
    'BOK' FIELD is_book-bookid.

    call TRANSACTION 'BC425_BOOK_DET' AND SKIP FIRST SCREEN.
  endmethod.
ENDCLASS.
