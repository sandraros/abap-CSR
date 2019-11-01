"! <p class="shorttext synchronized" lang="en">UTF-8</p>
"!
CLASS zcl_csr_utf8 DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_unicode
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      get_name REDEFINITION,
      match REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_utf8 IMPLEMENTATION.


  METHOD get_name.

    name = 'UTF-8'.

  ENDMETHOD.


  METHOD match.

    DATA has_bom TYPE abap_bool.
    DATA num_valid TYPE i.
    DATA num_invalid TYPE i.
*    const uint8_t *input = det->fRawInput;
    DATA i TYPE i.
    DATA b TYPE x LENGTH 1.
    DATA trail_bytes TYPE i.
    DATA confidence TYPE i.
    CONSTANTS x80 TYPE x LENGTH 1 VALUE '80'.
    CONSTANTS xc0 TYPE x LENGTH 1 VALUE 'C0'.
    CONSTANTS xe0 TYPE x LENGTH 1 VALUE 'E0'.
    CONSTANTS xf0 TYPE x LENGTH 1 VALUE 'F0'.
    CONSTANTS xf8 TYPE x LENGTH 1 VALUE 'F8'.

    trail_bytes = 0.
    num_valid = 0.
    num_invalid = 0.

    has_bom = abap_false.
    IF xstrlen( det->f_raw_input ) >= 3
        AND det->f_raw_input(1) = 'EF'
        AND det->f_raw_input(1) = 'BB'
        AND det->f_raw_input(1) = 'BF'.
      has_bom = abap_true.
    ENDIF.

    " Scan for multi-byte sequences
    i = 0.
    WHILE i < xstrlen( det->f_raw_input ).
      b = det->f_raw_input+i(1).
      IF b Z x80.
        " bit de poids lourd est zéro
        ADD 1 TO i.
        CONTINUE. " ASCII
      ENDIF.

      " Hi bit on char found.  Figure out how long the sequence should be
      IF b BIT-AND xe0 = xc0.
        trail_bytes = 1.
      ELSEIF b BIT-AND xf0 = xe0.
        trail_bytes = 2.
      ELSEIF b BIT-AND xf8 = xf0.
        trail_bytes = 3.
      ELSE.
        ADD 1 TO num_invalid.

        IF num_invalid > 5.
          EXIT.
        ENDIF.
        trail_bytes = 0.
      ENDIF.

      " Verify that we've got the right number of trail bytes in the sequence
      DO.
        ADD 1 TO i.
        IF i >= xstrlen( det->f_raw_input ).
          EXIT.
        ENDIF.

        b = det->f_raw_input+i(1).

        IF b BIT-AND xc0 <> x80.
          ADD 1 TO num_invalid.
          EXIT.
        ENDIF.

        SUBTRACT 1 FROM trail_bytes.
        IF trail_bytes = 0.
          ADD 1 TO num_valid.
          EXIT.
        ENDIF.

      ENDDO.

      ADD 1 TO i.
    ENDWHILE.

    " Cook up some sort of confidence score, based on presense of a BOM
    "    and the existence of valid and/or invalid multi-byte sequences.
    confidence = 0.
    IF has_bom = abap_true AND num_invalid = 0.
      confidence = 100.
    ELSEIF has_bom = abap_true AND num_valid > num_invalid * 10.
      confidence = 80.
    ELSEIF num_valid > 3 AND num_invalid = 0.
      confidence = 100.
    ELSEIF num_valid > 0 AND num_invalid = 0.
      confidence = 80.
    ELSEIF num_valid = 0 AND num_invalid = 0.
      " Plain ASCII.
      confidence = 10.
    ELSEIF num_valid > num_invalid * 10.
      " Probably corruput utf-8 data.  Valid sequences aren't likely by chance.
      confidence = 25.
    ENDIF.

    result = confidence.


  ENDMETHOD.

ENDCLASS.
