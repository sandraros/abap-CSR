"! <p class="shorttext synchronized" lang="en">UTF-32LE</p>
"!
CLASS zcl_csr_utf_32_le DEFINITION
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



CLASS zcl_csr_utf_32_le IMPLEMENTATION.


  METHOD get_char.

    char = det->f_raw_input+offset(4).
    CONCATENATE
        char+3(1)
        char+2(1)
        char+1(1)
        char+0(1)
        INTO char
        IN BYTE MODE.

  ENDMETHOD.


  METHOD get_name.

    name = 'UTF-32LE'.

  ENDMETHOD.
ENDCLASS.
