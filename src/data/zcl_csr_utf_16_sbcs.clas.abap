"! <p class="shorttext synchronized" lang="en">UTF-8</p>
"!
CLASS zcl_csr_utf_16_sbcs DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_unicode
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      "! Number of bytes for representing one character
      char_size       TYPE i VALUE 2,
      offset_3rd_char TYPE i VALUE 4,
      "! N-Gram = 3 characters
      ngram_size      TYPE i VALUE 6.
    TYPES:
      ty_ngram_x  TYPE x LENGTH ngram_size,
      ty_ngrams_x TYPE x LENGTH 384, " 64 N-Grams each made of 6 bytes
      " Some N-Grams may occur twice
      ty_ngrams   TYPE SORTED TABLE OF ty_ngram_x WITH NON-UNIQUE KEY table_line,
      ty_char     TYPE x LENGTH char_size,
      BEGIN OF ty_charmap_line,
        from TYPE ty_char,
        to   TYPE ty_char,
      END OF ty_charmap_line,
      ty_charmap TYPE HASHED TABLE OF ty_charmap_line WITH UNIQUE KEY from.
    DATA:
      csr_sbcs      TYPE REF TO zcl_csr_sbcs READ-ONLY,
      big_endian    TYPE abap_bool READ-ONLY,
      little_endian TYPE abap_bool READ-ONLY,
      ngrams        TYPE ty_ngrams READ-ONLY,
      charmap       TYPE ty_charmap READ-ONLY.

    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    "! @parameter csr_sbcs | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter big_endian | <p class="shorttext synchronized" lang="en"></p>
    "! @raising cx_parameter_invalid_range | Code page is not defined in SAP
    METHODS constructor
      IMPORTING
        !csr_sbcs   TYPE REF TO zcl_csr_sbcs
        !big_endian TYPE abap_bool DEFAULT abap_true
      RAISING
        cx_parameter_invalid_range.

    METHODS: match REDEFINITION,
      get_name REDEFINITION,
      get_language REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS lookup
      IMPORTING
        !ngram TYPE ty_ngram_x .
    METHODS add_char
      IMPORTING
        !char TYPE ty_char.

    DATA:
      "! Current N-Gram during parsing
      ngram           TYPE ty_ngram_x,
      " Space
      space_x         TYPE ty_char,
      "! Does not count invalid characters
      ngram_count     TYPE i,
      hit_count       TYPE i,
      codepage_utf_16 TYPE string.

ENDCLASS.



CLASS zcl_csr_utf_16_sbcs IMPLEMENTATION.


  METHOD add_char.

    SHIFT ngram LEFT BY char_size PLACES IN BYTE MODE.
    ngram+offset_3rd_char = char.
    lookup( ngram ).

  ENDMETHOD.


  METHOD constructor.

    super->constructor( ).

    me->csr_sbcs = csr_sbcs.
    me->big_endian = big_endian.

    " If the code page does not exist, raise the exception CX_PARAMETER_INVALID_RANGE
    cl_abap_codepage=>sap_codepage( csr_sbcs->get_name( ) ).


    codepage_utf_16 = COND string( WHEN big_endian = abap_true THEN 'utf-16be' ELSE 'utf-16le' ).

    space_x = cl_abap_codepage=>convert_to( source = ` ` codepage = codepage_utf_16 ).

    me->charmap = VALUE #(
        FOR i = 0 WHILE i < 256
        LET char_from   = cl_abap_codepage=>convert_from( source = CONV #( i ) codepage = csr_sbcs->get_name( ) )
            char_from_2 = cl_abap_codepage=>convert_to( source = char_from codepage = codepage_utf_16 )
            offset_char = i * 2
            char_to     = cl_abap_codepage=>convert_from( source = CONV #( csr_sbcs->charmap+offset_char(char_size) ) codepage = csr_sbcs->get_name( ) )
            char_to_2   = cl_abap_codepage=>convert_to( source = char_to codepage = codepage_utf_16 )
        IN ( from = char_from_2
             to   = char_to_2 ) ).

    me->ngrams = VALUE #(
        LET ngrams_string = cl_abap_codepage=>convert_from( source = CONV #( csr_sbcs->ngrams ) codepage = csr_sbcs->get_name( ) )
            ngrams_utf_16 = CONV ty_ngrams_x( cl_abap_codepage=>convert_to( source = ngrams_string codepage = codepage_utf_16 ) )
        IN  FOR i = 0 WHILE i < 64
            LET offset_ngram = i * 6
            IN ( ngrams_utf_16+offset_ngram(6) ) ).

  ENDMETHOD.


  METHOD get_language.

    language = csr_sbcs->get_language( ).

  ENDMETHOD.


  METHOD get_name.

    name = codepage_utf_16.

  ENDMETHOD.


  METHOD lookup.

    ADD 1 TO ngram_count.
    READ TABLE ngrams WITH TABLE KEY table_line = ngram TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      ADD 1 TO hit_count.
    ENDIF.

  ENDMETHOD.


  METHOD match.

    DATA: length       TYPE i,
          offset       TYPE i,
          ignore_space TYPE abap_bool,
          mb           TYPE x LENGTH 1.

    ignore_space = abap_false.
    length = xstrlen( det->f_raw_input ) .
    IF length MOD 2 = 1.
      result = 0.
      RETURN.
    ENDIF.

    offset = 0.
    WHILE offset < length.
      DATA(charmap_line) = VALUE ty_charmap_line( from = det->f_raw_input+offset(char_size) ).
      READ TABLE charmap WITH TABLE KEY from = charmap_line-from INTO charmap_line.
      " no need to test SY-SUBRC, it may be <> 0 i.e. not part of checked SBCS -> charmap_line-to is initial in that case.
      IF charmap_line-to IS NOT INITIAL.
        IF NOT ( charmap_line-to = space_x AND ignore_space = abap_true ).
          add_char( charmap_line-to ).
        ENDIF.
        IF charmap_line-to = space_x.
          ignore_space = abap_true.
        ELSE.
          ignore_space = abap_false.
        ENDIF.
      ENDIF.
      ADD char_size TO offset.
    ENDWHILE.
    add_char( space_x ).

    result = 300 * hit_count / ngram_count.
    IF result > 99.
      result = 98.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
