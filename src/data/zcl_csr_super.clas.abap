"! <p class="shorttext synchronized" lang="en">Super class of all data classes</p>
"!
CLASS zcl_csr_super DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_name ABSTRACT
      RETURNING
        VALUE(name) TYPE string .
    METHODS get_language ABSTRACT
      RETURNING
        VALUE(language) TYPE string .
    METHODS match ABSTRACT
      IMPORTING
        !det          TYPE REF TO zcl_csr_input_text
      RETURNING
        VALUE(result) TYPE i .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_super IMPLEMENTATION.
ENDCLASS.
