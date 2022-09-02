*&---------------------------------------------------------------------*
*& Report ZBC401_A12_CL_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC401_A12_CL_02.

INTERFACE intf.

data : ch1 TYPE i,
      ch2 TYPE i.

METHODs : met1. "선언만 interface안에... 구현은 class

  endinterface.

  class c11 DEFINITION.
    PUBLIC SECTION.
    INTERFACES intf. " 항상 public에 선언.
    ENDCLASS.

    class c11 IMPLEMENTATION.

      METHOD intf~met1.
        data : rel TYPE i.
        rel = intf~ch1 + intf~ch2.

        WRITE : / 'result + :',rel.
        ENDMETHOD.
        ENDclass.

        class c12 DEFINITION.
          PUBLIC SECTION.
          INTERFACES intf.
          ENDCLASS.

          class c12 IMPLEMENTATION.
            METHOD intf~met1.

              data: rel TYPE i.
              rel = intf~ch1 * intf~ch2.

              WRITE : / 'result * : ', rel.
              ENDMETHOD.
              endclass.

             START-OF-SELECTION.

             data : clobj TYPE REF TO c11.
             CREATE OBJECT clobj.

             clobj->intf~ch1 = 10.
             clobj->intf~ch2 = 20.

             call METHOD clobj->intf~met1.

             data : clobj1 TYPE REF TO c12.

             CREATE OBJECT clobj1.

             clobj1->intf~ch1 = 10.
             clobj1->intf~ch2 = 20.

             call METHOD clobj1->intf~met1.
