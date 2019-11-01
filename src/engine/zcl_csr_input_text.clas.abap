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
*void InputText::MungeInput(UBool fStripTags) {
*    int     srci = 0;
*    int     dsti = 0;
*    uint8_t b;
*    bool    inMarkup = FALSE;
*    int32_t openTags = 0;
*    int32_t badTags  = 0;
*
*    //
*    //  html / xml markup stripping.
*    //     quick and dirty, not 100% accurate, but hopefully good enough, statistically.
*    //     discard everything within < brackets >
*    //     Count how many total '<' and illegal (nested) '<' occur, so we can make some
*    //     guess as to whether the input was actually marked up at all.
*    // TODO: Think about how this interacts with EBCDIC charsets that are detected.
*    if (fStripTags) {
*        for (srci = 0; srci < fRawLength && dsti < BUFFER_SIZE; srci += 1) {
*            b = fRawInput[srci];
*
*            if (b == (uint8_t)0x3C) { /* Check for the ASCII '<' */
*                if (inMarkup) {
*                    badTags += 1;
*                }
*
*                inMarkup = TRUE;
*                openTags += 1;
*            }
*
*            if (! inMarkup) {
*                fInputBytes[dsti++] = b;
*            }
*
*            if (b == (uint8_t)0x3E) { /* Check for the ASCII '>' */
*                inMarkup = FALSE;
*            }
*        }
*
*        fInputLen = dsti;
*    }
*
*    //
*    //  If it looks like this input wasn't marked up, or if it looks like it's
*    //    essentially nothing but markup abandon the markup stripping.
*    //    Detection will have to work on the unstripped input.
*    //
*    if (openTags<5 || openTags/5 < badTags ||
*        (fInputLen < 100 && fRawLength>600))
*    {
*        int32_t limit = fRawLength;
*
*        if (limit > BUFFER_SIZE) {
*            limit = BUFFER_SIZE;
*        }
*
*        for (srci=0; srci<limit; srci++) {
*            fInputBytes[srci] = fRawInput[srci];
*        }
*
*        fInputLen = srci;
*    }
*
*    //
*    // Tally up the byte occurence statistics.
*    // These are available for use by the various detectors.
*    //
*
*    uprv_memset(fByteStats, 0, (sizeof fByteStats[0]) * 256);
*
*    for (srci = 0; srci < fInputLen; srci += 1) {
*        fByteStats[fInputBytes[srci]] += 1;
*    }
    DATA byte_stats TYPE TABLE OF i.
    DO 256 TIMES.
      APPEND 0 TO byte_stats.
    ENDDO.
    i = 0.
    WHILE i <= xstrlen( f_raw_input ).
      b = f_raw_input+i.
      READ TABLE byte_stats INDEX b ASSIGNING FIELD-SYMBOL(<stat>).
      ADD 1 TO <stat>.
      ADD 1 TO i.
    ENDWHILE.

*    for (int32_t i = 0x80; i <= 0x9F; i += 1) {
*        if (fByteStats[i] != 0) {
*            fC1Bytes = TRUE;
*            break;
*        }
*    }
    f_c1_bytes = abap_false.
    i = 128.
    WHILE i <= 159.
      READ TABLE byte_stats INDEX i ASSIGNING <stat>.
      IF <stat> <> 0.
        f_c1_bytes = abap_true.
      ENDIF.
      ADD 1 TO i.
    ENDWHILE.


  ENDMETHOD.


  METHOD set_text.

    f_raw_input = in.

  ENDMETHOD.
ENDCLASS.
