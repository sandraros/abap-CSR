"! <p class="shorttext synchronized" lang="en"></p>
"!
CLASS zcl_csr_8859_5 DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_sbcs
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor .

    METHODS get_name
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_8859_5 IMPLEMENTATION.


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
    '20F1F2F3F4F5F6F7'
    'F8F9FAFBFC20FEFF'
    'D0D1D2D3D4D5D6D7'
    'D8D9DADBDCDDDEDF'
    'E0E1E2E3E4E5E6E7'
    'E8E9EAEBECEDEEEF'
    'D0D1D2D3D4D5D6D7'
    'D8D9DADBDCDDDEDF'
    'E0E1E2E3E4E5E6E7'
    'E8E9EAEBECEDEEEF'
    '20F1F2F3F4F5F6F7'
    'F8F9FAFBFC20FEFF'
    INTO charmap.

  ENDMETHOD.


  METHOD get_name.

    name = 'ISO-8859-5'.

  ENDMETHOD.


ENDCLASS.
