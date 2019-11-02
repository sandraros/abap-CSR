"! <p class="shorttext synchronized" lang="en">UTF-32</p>
"!
CLASS zcl_csr_utf_32 DEFINITION
  PUBLIC
  ABSTRACT
  INHERITING FROM zcl_csr_unicode
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_name
        REDEFINITION .
    METHODS get_language
        REDEFINITION .
    METHODS match
        REDEFINITION .
  PROTECTED SECTION.
    TYPES ty_utf32_char TYPE x LENGTH 4.
    METHODS get_char ABSTRACT
      IMPORTING
        det         TYPE REF TO zcl_csr_input_text
        offset      TYPE i
      RETURNING
        VALUE(char) TYPE ty_utf32_char.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_utf_32 IMPLEMENTATION.


  METHOD get_language.


  ENDMETHOD.


  METHOD get_name.


  ENDMETHOD.


  METHOD match.

    IF xstrlen( det->f_raw_input ) < 4 OR xstrlen( det->f_raw_input ) MOD 4 <> 0.
      result = 0.
      RETURN.
    ENDIF.

    DATA(has_bom) = abap_false.
    IF get_char( det = det offset = 0 ) = '0000FEFF'.
      has_bom = abap_true.
    ENDIF.

    DATA(i) = 4.
    DATA(num_invalid) = 0.
    DATA(num_valid) = 0.
    WHILE i < xstrlen( det->f_raw_input ).
      DATA(ch) = get_char( det = det offset = i ).
      IF ch < 0 OR ch > '0010FFFF' OR ch BETWEEN '0000D800' AND '0000DFFF'.
        ADD 1 TO num_invalid.
      ELSE.
        ADD 1 TO num_valid.
      ENDIF.
      ADD 4 TO i.
    ENDWHILE.

    IF has_bom = abap_true AND num_invalid = 0.
      result = 100.
    ELSEIF has_bom = abap_true AND num_valid > num_invalid * 10.
      result = 80.
    ELSEIF num_valid > 3 AND num_invalid = 0.
      result = 100.
    ELSEIF num_valid > 0 AND num_invalid = 0.
      result = 80.
    ELSEIF num_valid > num_invalid * 10.
      " Probably corruput UTF-32BE data.  Valid sequences aren't likely by chance.
      result = 25.
    ELSE.
      result = 0.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
