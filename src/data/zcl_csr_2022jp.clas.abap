"! <p class="shorttext synchronized" lang="en"></p>
"!
CLASS zcl_csr_2022jp DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_2022
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_name
        REDEFINITION .
    METHODS get_language
        REDEFINITION .
    METHODS match
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_2022jp IMPLEMENTATION.


  METHOD get_language.

    language = 'jp'.

  ENDMETHOD.


  METHOD get_name.

    name = 'ISO-2022-JP'.

  ENDMETHOD.


  METHOD match.


  ENDMETHOD.
ENDCLASS.
