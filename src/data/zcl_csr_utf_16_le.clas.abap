"! <p class="shorttext synchronized" lang="en">UTF-16LE</p>
"!
CLASS zcl_csr_utf_16_le DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_unicode
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      get_name REDEFINITION,
      match REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_utf_16_le IMPLEMENTATION.


  METHOD get_name.

    name = 'UTF-16LE'.

  ENDMETHOD.


  METHOD match.

    IF det->f_raw_input(1) = 'FF'
          AND det->f_raw_input+1(1) = 'FE'
          AND ( det->f_raw_input+2(1) <> '00'
            OR det->f_raw_input+3(1) <> '00' ).
      result = 100.
    ELSE.
      " TODO: Do some statastics to check for unsigned UTF-16BE
      result = 0.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
