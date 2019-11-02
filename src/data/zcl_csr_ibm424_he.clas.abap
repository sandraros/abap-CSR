"! <p class="shorttext synchronized" lang="en">Hebrew</p>
"!
CLASS zcl_csr_ibm424_he DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_sbcs
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor .

    METHODS get_language
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CSR_IBM424_HE IMPLEMENTATION.


  METHOD constructor.

    super->constructor( ).
    CONCATENATE
    '40404040404040404040404040404040'
    '40404040404040404040404040404040'
    '40404040404040404040404040404040'
    '40404040404040404040404040404040'
    '40414243444546474849404040404040'
    '40515253545556575859404040404040'
    '40406263646566676869404040404040'
    '40714040404040404040404040004040'
    '40818283848586878889404040404040'
    '40919293949596979899404040404040'
    'A040A2A3A4A5A6A7A8A9404040404040'
    '40404040404040404040404040404040'
    '40818283848586878889404040404040'
    '40919293949596979899404040404040'
    '4040A2A3A4A5A6A7A8A9404040404040'
    '40404040404040404040404040404040'
    INTO charmap.

  ENDMETHOD.


  METHOD get_language.

    language = 'he'.

  ENDMETHOD.
ENDCLASS.
