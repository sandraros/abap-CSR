"! <p class="shorttext synchronized" lang="en">Single-Byte Character Sets (ISO-8859-*, etc.)</p>
"!
CLASS zcl_csr_sbcs DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_super
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: ty_charmap_sbcs TYPE zif_csr_util=>ty_charmap_sbcs,
           ty_ngrams_sbcs  TYPE zif_csr_util=>ty_ngrams_sbcs.

    DATA: have_c1_bytes TYPE abap_bool READ-ONLY,
          charmap       TYPE ty_charmap_sbcs READ-ONLY,
          ngrams        TYPE ty_ngrams_sbcs  READ-ONLY.

    METHODS match REDEFINITION .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_sbcs IMPLEMENTATION.


  METHOD match.

    DATA parser TYPE REF TO zcl_csr_ngram_parser.

    CREATE OBJECT parser
      EXPORTING
        ngrams  = ngrams
        charmap = charmap.
    have_c1_bytes = det->f_c1_bytes.
    result = parser->parse( det ).

  ENDMETHOD.

ENDCLASS.
