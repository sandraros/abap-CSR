"! <p class="shorttext synchronized" lang="en">ABSTRACT parent for UTF</p>
"!
CLASS zcl_csr_unicode DEFINITION
  PUBLIC
  ABSTRACT
  INHERITING FROM zcl_csr_super
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      get_language REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CSR_UNICODE IMPLEMENTATION.


  METHOD get_language.


  ENDMETHOD.
ENDCLASS.
