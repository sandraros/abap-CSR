"! <p class="shorttext synchronized" lang="en">Swedish</p>
"!
CLASS zcl_csr_8859_1_sv DEFINITION
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



CLASS zcl_csr_8859_1_sv IMPLEMENTATION.


  METHOD constructor.

    super->constructor( ).
    CONCATENATE
    '20617420617620646520656E2066F620686120692020696E206B6F206D65206F632070E520736B20736F207374207469'
    '20766120766920E472616465616E20616E6461722061747463682064652064656E646572646574656420656E20657220'
    '65742066F67267656E696C6C696E676B61206C6C206D65646E20736E61206E64656E67206E67656E696E6F63686F6D20'
    '6F6E2070E520722061722073726120736B61736F6D74207374612074652074657274696C747420766172E47220F67220'
    INTO ngrams.

  ENDMETHOD.


  METHOD get_language.

    language = 'sv'.

  ENDMETHOD.


ENDCLASS.
