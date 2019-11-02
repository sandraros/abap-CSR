"! <p class="shorttext synchronized" lang="en"></p>
"!
CLASS zcl_csr_ngram_parser DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES ty_charmap_sbcs TYPE zif_csr_util=>ty_charmap_sbcs .
    TYPES ty_ngrams_sbcs TYPE zif_csr_util=>ty_ngrams_sbcs .
    TYPES:
      ty_ngram TYPE x LENGTH 3 .
    TYPES:
      ty_byte TYPE x LENGTH 1 .

    DATA:
      ngrams      TYPE SORTED TABLE OF ty_ngram WITH NON-UNIQUE KEY table_line .
    DATA:
      charmap     TYPE STANDARD TABLE OF ty_byte WITH DEFAULT KEY .
    DATA ngram TYPE ty_ngram .
    DATA ngram_count TYPE i .
    DATA hit_count TYPE i .

    METHODS constructor
      IMPORTING
        !ngrams  TYPE zif_csr_util=>ty_ngrams_sbcs
        !charmap TYPE zif_csr_util=>ty_charmap_sbcs .
    METHODS lookup
      IMPORTING
        !ngram TYPE ty_ngram .
    METHODS add_byte
      IMPORTING
        !byte TYPE ty_byte .
    METHODS parse
      IMPORTING
        !det              TYPE REF TO zcl_csr_input_text
      RETURNING
        VALUE(confidence) TYPE i .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_ngram_parser IMPLEMENTATION.


  METHOD add_byte.

    SHIFT ngram LEFT BY 1 PLACES IN BYTE MODE.
    ngram+2 = byte.
    lookup( ngram ).

  ENDMETHOD.


  METHOD constructor.

    DATA index TYPE i.
    DATA ngram TYPE ty_ngram.
    DATA offset TYPE i.
    DATA mb TYPE ty_byte.

    index = 0.
    DO 64 TIMES.
      ngram = ngrams+index(6).
      ADD 6 TO index.
      INSERT ngram INTO TABLE me->ngrams.
    ENDDO.

    index = 0.
    DO 256 TIMES.
      mb = charmap+index(2).
      ADD 2 TO index.
      APPEND mb TO me->charmap.
    ENDDO.

  ENDMETHOD.


  METHOD lookup.

    ADD 1 TO ngram_count.
    READ TABLE ngrams WITH TABLE KEY table_line = ngram TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      ADD 1 TO hit_count.
    ENDIF.

  ENDMETHOD.


  METHOD parse.

    DATA length TYPE i.
    DATA offset TYPE i.
    DATA byte TYPE x LENGTH 1.
    DATA ignore_space TYPE abap_bool.
    DATA mb TYPE x LENGTH 1.

    ignore_space = abap_false.
    length = xstrlen( det->f_raw_input ) .
    offset = 0.
    DO length TIMES.
      byte = det->f_raw_input+offset(1).
      READ TABLE charmap INDEX byte + 1 INTO mb.
      ASSERT sy-subrc = 0.
      IF mb IS NOT INITIAL.
        IF NOT ( mb = '20' AND ignore_space = abap_true ).
          add_byte( byte ).
        ENDIF.
        IF mb = '20'.
          ignore_space = abap_true.
        ELSE.
          ignore_space = abap_false.
        ENDIF.
      ENDIF.
      ADD 1 TO offset.
    ENDDO.
    add_byte( '20' ).
    confidence = 300 * hit_count / ngram_count.
    IF confidence > 99.
      confidence = 98.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
