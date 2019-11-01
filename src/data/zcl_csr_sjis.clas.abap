"! <p class="shorttext synchronized" lang="en">Japanese</p>
"!
CLASS zcl_csr_sjis DEFINITION
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



CLASS zcl_csr_sjis IMPLEMENTATION.


  METHOD get_language.

    language = 'ja'.

  ENDMETHOD.


  METHOD get_name.

    name = 'Shift_JIS'.

  ENDMETHOD.


  METHOD match.


  ENDMETHOD.
ENDCLASS.
