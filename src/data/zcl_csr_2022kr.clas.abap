"! <p class="shorttext synchronized" lang="en"></p>
"!
CLASS zcl_csr_2022kr DEFINITION
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



CLASS zcl_csr_2022kr IMPLEMENTATION.


  METHOD get_language.

    language = 'kr'.

  ENDMETHOD.


  METHOD get_name.

    name = 'ISO-2022-KR'.

  ENDMETHOD.


  METHOD match.


  ENDMETHOD.
ENDCLASS.
