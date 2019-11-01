"! <p class="shorttext synchronized" lang="en"></p>
"!
CLASS zcl_csr_euc_jp DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_mbcs
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



CLASS zcl_csr_euc_jp IMPLEMENTATION.


  METHOD get_language.

    language = 'ja'.

  ENDMETHOD.


  METHOD get_name.


  ENDMETHOD.


  METHOD match.


  ENDMETHOD.
ENDCLASS.
