"! <p class="shorttext synchronized" lang="en">UTF-16LE</p>
"!
CLASS zcl_csr_utf_16_le DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_utf_16
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      get_name REDEFINITION,
      match REDEFINITION.

  PROTECTED SECTION.

    METHODS get_char REDEFINITION .

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_utf_16_le IMPLEMENTATION.


  METHOD get_name.

    name = 'UTF-16LE'.

  ENDMETHOD.


  METHOD match.

    IF xstrlen( det->f_raw_input ) >= 2
        AND det->f_raw_input(1) = 'FF'
        AND det->f_raw_input+1(1) = 'FE'.
      IF xstrlen( det->f_raw_input ) >= 4
        AND det->f_raw_input+2(1) = '00'
        AND det->f_raw_input+3(1) = '00'.
        " FFFE0000 is the BOM of UTF-32LE
        result = 0.
      ELSE.
        " BOM of UTF-16LE
        result = 100.
      ENDIF.
    ELSE.
      " TODO: Do some statastics to check for unsigned UTF-16BE
      result = 0.
    ENDIF.

  ENDMETHOD.


  METHOD get_char.

    char = det->f_raw_input+offset(2).
    CONCATENATE
        char+1(1)
        char+0(1)
        INTO char
        IN BYTE MODE.

  ENDMETHOD.


ENDCLASS.
