"! <p class="shorttext synchronized" lang="en">UTF-32BE</p>
"!
CLASS zcl_csr_utf_32_be DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_utf_32
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_name
        REDEFINITION .

  PROTECTED SECTION.

    METHODS get_char
        REDEFINITION .

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_utf_32_be IMPLEMENTATION.


  METHOD get_char.

    char = det->f_raw_input+offset(4).

  ENDMETHOD.


  METHOD get_name.

    name = 'UTF-32BE'.

  ENDMETHOD.

ENDCLASS.
