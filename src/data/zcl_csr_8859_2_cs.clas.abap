"! <p class="shorttext synchronized" lang="en">Czech</p>
"!
CLASS zcl_csr_8859_2_cs DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_8859_2
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor .

    METHODS get_language
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_8859_2_cs IMPLEMENTATION.


  METHOD constructor.

    super->constructor( ).
    CONCATENATE
    '20612020627920646F206A65206E61206E65206F20206F6420706F2070722070F820726F20736520736F20737420746F'
    '207620207679207A61612070636520636820652070652073652076656D20656EED686F20686F646973746A65206B7465'
    '6C65206C69206E61206EE9206EEC206EED206F20706F646E6F6A696F73746F75206F7661706F64706F6A70726F70F865'
    '736520736F7573746173746973746E746572746EED746F20752070BE6520E16EEDE9686FED2070ED2073ED6D20F86564'
    INTO ngrams.

  ENDMETHOD.


  METHOD get_language.

    language = 'cs'.

  ENDMETHOD.


ENDCLASS.
