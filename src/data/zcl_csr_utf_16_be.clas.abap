"! <p class="shorttext synchronized" lang="en">UTF-16BE</p>
"!
CLASS zcl_csr_utf_16_be DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_utf_16
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      get_name REDEFINITION,
      match REDEFINITION.

  PROTECTED SECTION.

    METHODS get_char
        REDEFINITION .

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_utf_16_be IMPLEMENTATION.


  METHOD get_name.

    name = 'UTF-16BE'.

  ENDMETHOD.


  METHOD match.

    IF xstrlen( det->f_raw_input ) >= 2
        AND det->f_raw_input(1) = 'FE'
        AND det->f_raw_input+1(1) = 'FF'.
      result = 100.
    ELSE.
      " TODO: Do some statastics to check for unsigned UTF-16BE
      result = 0.
    ENDIF.

  ENDMETHOD.


  METHOD get_char.

    char = det->f_raw_input+offset(2).

  ENDMETHOD.


ENDCLASS.
