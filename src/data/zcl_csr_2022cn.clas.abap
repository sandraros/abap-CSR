"! <p class="shorttext synchronized" lang="en">Chinese</p>
"!
CLASS zcl_csr_2022cn DEFINITION
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



CLASS zcl_csr_2022cn IMPLEMENTATION.


  METHOD get_language.

    language = 'zh'.

  ENDMETHOD.


  METHOD get_name.

    name = 'ISO-2022-CN'.

  ENDMETHOD.


  METHOD match.


  ENDMETHOD.
ENDCLASS.
