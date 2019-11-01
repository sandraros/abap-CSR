"! <p class="shorttext synchronized" lang="en"></p>
"!
CLASS zcl_csr_8859_9 DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_sbcs
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

*    DATA charmap_8859_9 TYPE ty_charmap_sbcs .

    METHODS constructor .

    METHODS get_name
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_8859_9 IMPLEMENTATION.


  METHOD constructor.

    super->constructor( ).
    CONCATENATE
    '2020202020202020'
    '2020202020202020'
    '2020202020202020'
    '2020202020202020'
    '2020202020202000'
    '2020202020202020'
    '2020202020202020'
    '2020202020202020'
    '2061626364656667'
    '68696A6B6C6D6E6F'
    '7071727374757677'
    '78797A2020202020'
    '2061626364656667'
    '68696A6B6C6D6E6F'
    '7071727374757677'
    '78797A2020202020'
    '2020202020202020'
    '2020202020202020'
    '2020202020202020'
    '2020202020202020'
    '2020202020202020'
    '2020AA2020202020'
    '2020202020B52020'
    '2020BA2020202020'
    'E0E1E2E3E4E5E6E7'
    'E8E9EAEBECEDEEEF'
    'F0F1F2F3F4F5F620'
    'F8F9FAFBFC69FEDF'
    'E0E1E2E3E4E5E6E7'
    'E8E9EAEBECEDEEEF'
    'F0F1F2F3F4F5F620'
    'F8F9FAFBFCFDFEFF'
    INTO charmap.
*    INTO charmap_8859_9.

  ENDMETHOD.


  METHOD get_name.

    IF have_c1_bytes = abap_true.
      name = 'windows-1254'.
    ELSE.
      name = 'ISO-8859-9'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
