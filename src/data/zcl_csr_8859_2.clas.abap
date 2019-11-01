"! <p class="shorttext synchronized" lang="en"></p>
"!
CLASS zcl_csr_8859_2 DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_sbcs
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

*  data CHARMAP_8859_2 type TY_CHARMAP_SBCS .

    METHODS constructor .

    METHODS get_name
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_8859_2 IMPLEMENTATION.


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
    '20B120B320B5B620'
    '20B9BABBBC20BEBF'
    '20B120B320B5B6B7'
    '20B9BABBBC20BEBF'
    'E0E1E2E3E4E5E6E7'
    'E8E9EAEBECEDEEEF'
    'F0F1F2F3F4F5F620'
    'F8F9FAFBFCFDFEDF'
    'E0E1E2E3E4E5E6E7'
    'E8E9EAEBECEDEEEF'
    'F0F1F2F3F4F5F620'
    'F8F9FAFBFCFDFE20'
    INTO charmap.
*    INTO charmap_8859_2.

  ENDMETHOD.


  METHOD get_name.

    IF have_c1_bytes = abap_true.
      name = 'windows-1250'.
    ELSE.
      name = 'ISO-8859-2'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
