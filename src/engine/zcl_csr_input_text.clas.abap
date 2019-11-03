"! <p class="shorttext synchronized" lang="en"></p>
"!
CLASS zcl_csr_input_text DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA f_raw_input TYPE xstring READ-ONLY .
    "! True if there is at least one byte from 0x80 to 0x9F in the input text.
    DATA f_c1_bytes TYPE abap_bool READ-ONLY .

    METHODS set_text
      IMPORTING
        !in TYPE xsequence .
    METHODS munge_input
      IMPORTING
        !f_strip_tags TYPE abap_bool .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_input_text IMPLEMENTATION.


  METHOD munge_input.

    DATA: srci TYPE i,
          dsti TYPE i,
          b    TYPE x LENGTH 1,
          i    TYPE i.
    DATA byte_stats TYPE TABLE OF i.

    byte_stats = VALUE #( FOR j = 0 WHILE j < 256 ( 0 ) ).
    i = 0.
    WHILE i < xstrlen( f_raw_input ).
      b = f_raw_input+i.
      ASSIGN byte_stats[ b + 1 ] TO FIELD-SYMBOL(<stat>).
      ADD 1 TO <stat>.
      ADD 1 TO i.
    ENDWHILE.

    " Is there at least one byte from 0x80 to 0x9F in the input text
    f_c1_bytes = abap_false.
    i = 128.
    WHILE i <= 159.
      READ TABLE byte_stats INDEX i INTO DATA(stat).
      IF stat <> 0.
        f_c1_bytes = abap_true.
        EXIT.
      ENDIF.
      ADD 1 TO i.
    ENDWHILE.

  ENDMETHOD.


  METHOD set_text.

    " First 1000 bytes should suffice for good detection
    DATA(len) = nmIN( val1 = 1000 val2 = xstrlen( in ) ).
    f_raw_input = in(len).

  ENDMETHOD.
ENDCLASS.
