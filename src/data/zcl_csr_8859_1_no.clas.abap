"! <p class="shorttext synchronized" lang="en">Norwegian</p>
"!
CLASS zcl_csr_8859_1_no DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_8859_1
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor .

    METHODS get_language
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_8859_1_no IMPLEMENTATION.


  METHOD constructor.

    super->constructor( ).
    CONCATENATE
    '20617420617620646520656E20657220666F206861206920206D65206F672070E520736520736B20736F207374207469'
    '20766920E520616E6461722061742064652064656E646574652073656420656E20656E65657220657265657420657474'
    '666F7267656E696B6B696C20696E676B65206B6B656C65206C6C656D65646D656E6E20736E65206E67206E67656E6E65'
    '6F67206F6D206F722070E520722073726520736F6D73746574207374652074656E74657274696C747420747465766572'
    INTO ngrams.

  ENDMETHOD.


  METHOD get_language.

    language = 'no'.

  ENDMETHOD.


ENDCLASS.
