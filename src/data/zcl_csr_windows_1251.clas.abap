"! <p class="shorttext synchronized" lang="en">Russian</p>
"!
CLASS zcl_csr_windows_1251 DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_sbcs
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor .

    METHODS get_name
        REDEFINITION .
    METHODS get_language
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_windows_1251 IMPLEMENTATION.


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
    '9083208320202020'
    '20209A209C9D9E9F'
    '9020202020202020'
    '20209A209C9D9E9F'
    '20A2A2BC20B42020'
    'B820BA20202020BF'
    '2020B3B3B4B52020'
    'B820BA20BCBEBEBF'
    'E0E1E2E3E4E5E6E7'
    'E8E9EAEBECEDEEEF'
    'F0F1F2F3F4F5F6F7'
    'F8F9FAFBFCFDFEFF'
    'E0E1E2E3E4E5E6E7'
    'E8E9EAEBECEDEEEF'
    'F0F1F2F3F4F5F6F7'
    'F8F9FAFBFCFDFEFF'
    INTO charmap.

    CONCATENATE
    '20E22020E2EE20E4EE20E7E020E82020EAE020EAEE20EDE020EDE520EEE120EFEE20EFF020F0E020F1EE20F1F220F2EE'
    '20F7F220FDF2E0EDE8E0F2FCE3EE20E5EBFCE5EDE8E5F1F2E5F220E820EFE8E520E8E820E8FF20EBE5EDEBE820EBFCED'
    'EDE020EDE520EDE8E5EDE8FFEDEE20EDEEE2EE20E2EE20EFEE20F1EEE220EEE2E0EEE3EEEEE920EEEBFCEEEC20EEF1F2'
    'EFEEEBEFF0E5EFF0E8EFF0EEF0E0E2F0E5E4F1F2E0F1F2E2F1F2E8F1FF20F2E5EBF2EE20F2EEF0F2FC20F7F2EEFBF520'
    INTO ngrams.

  ENDMETHOD.


  METHOD get_language.

    language = 'ru'.

  ENDMETHOD.


  METHOD get_name.

    name = 'windows-1251'.

  ENDMETHOD.


ENDCLASS.
