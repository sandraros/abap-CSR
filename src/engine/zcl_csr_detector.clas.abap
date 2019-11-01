"! <p class="shorttext synchronized" lang="en">Character set &amp; Language Detector</p>
"!
CLASS zcl_csr_detector DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_charset_match,
        text_in    TYPE REF TO zcl_csr_input_text,
        csr        TYPE REF TO zcl_csr_super,
        confidence TYPE i,
      END OF ty_charset_match .
    TYPES:
      ty_charset_matches TYPE STANDARD TABLE OF ty_charset_match WITH DEFAULT KEY .

    DATA f_fresh_text_set TYPE abap_bool .
    DATA text_in TYPE REF TO zcl_csr_input_text .
    DATA:
      csrecognizers    TYPE TABLE OF REF TO zcl_csr_super .
    DATA f_strip_tags TYPE abap_bool VALUE abap_false ##NO_TEXT.

    METHODS set_recognizers .
    METHODS constructor .
    METHODS set_text
      IMPORTING
        !in TYPE xsequence .
    METHODS set_strip_tags_flag .
    METHODS get_strip_tags_flag .
    METHODS set_declared_encoding .
    METHODS get_detectable_count .
    METHODS detect
      RETURNING
        VALUE(result) TYPE ty_charset_match .
    METHODS detect_all
      RETURNING
        VALUE(results) TYPE ty_charset_matches .
    METHODS get_charset_name .
    CLASS-METHODS get_sap_language
      IMPORTING
        !iso_code           TYPE laiso
      RETURNING
        VALUE(sap_language) TYPE sylangu .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_detector IMPLEMENTATION.


  METHOD constructor.

    set_recognizers( ).
    CREATE OBJECT text_in.

  ENDMETHOD.


  METHOD detect.

    DATA results TYPE ty_charset_matches.
    results = detect_all( ).
    READ TABLE results INDEX 1 INTO result.

  ENDMETHOD.


  METHOD detect_all.

    DATA csr TYPE REF TO zcl_csr_super.
**        int32_t            detectResults;
    DATA confidence TYPE i.
    DATA i TYPE i.
    DATA ls_result TYPE ty_charset_match.
    DATA lt_result TYPE ty_charset_matches.

    CLEAR results.
    IF text_in IS INITIAL.
      " RAISE EXCEPTION TYPE U_MISSING_RESOURCE_ERROR;// TODO:  Need to set proper status code for input text not set
    ELSEIF f_fresh_text_set = abap_true.

      text_in->munge_input( f_strip_tags ).
*
*        // Iterate over all possible charsets, remember all that
*        // give a match quality > 0.
*        result_Count = 0.
      i = 0.
      LOOP AT csrecognizers INTO csr.
        confidence = csr->match( text_in ).
        IF confidence > 0.
          ls_result-text_in = text_in.
          ls_result-csr = csr.
          ls_result-confidence = confidence.
          APPEND ls_result TO results.
*              resultArray[ resultCount++ ]->set(textIn, csr, confidence);
        ENDIF.
      ENDLOOP.

      SORT results BY confidence DESCENDING.

*        for(i = resultCount; i < fCSRecognizers_size; i += 1) {
*            resultArray[i]->set(textIn, 0, 0);
*        }
*
*        uprv_sortArray(resultArray, resultCount, sizeof resultArray[0], charsetMatchComparator, NULL, TRUE, &status);
*
**        // Remove duplicate charsets from the results.
**        // Simple minded, brute force approach - check each entry against all that follow.
**        // The first entry of any duplicated set is the one that should be kept because it will
**        // be the one with the highest confidence rating.
**        //   (Duplicate matches have different languages, only the charset is the same)
**        // Because the resultArray contains preallocated CharsetMatch objects, they aren't actually
**        // deleted, just reordered, with the unwanted duplicates placed after the good results.
*        int32_t j, k;
*        for (i=0; i<resultCount; i++) {
*            const char *charSetName = resultArray[i]->getName();
*            for (j=i+1; j<resultCount; ) {
*                if (uprv_strcmp(charSetName, resultArray[j]->getName()) != 0) {
**                    // Not a duplicate.
*                    j++;
*                } else {
**                    // Duplicate entry at index j.
*                    CharsetMatch *duplicate = resultArray[j];
*                    for (k=j; k<resultCount-1; k++) {
*                        resultArray[k] = resultArray[k+1];
*                    }
*                    resultCount--;
*                    resultArray[resultCount] = duplicate;
*                }
*            }
*        }
*
      f_fresh_text_set = abap_false.
    ENDIF.
*
*    maxMatchesFound = resultCount;
*
*    return resultArray;

  ENDMETHOD.


  METHOD get_charset_name.


  ENDMETHOD.


  METHOD get_detectable_count.


  ENDMETHOD.


  METHOD get_sap_language.

    CALL FUNCTION 'LANGUAGE_CODE_ISO_TO_SAP'
      EXPORTING
        iso_code  = iso_code
      IMPORTING
        sap_code  = sap_language
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.
    IF sy-subrc <> 0.
      " TODO
    ENDIF.

  ENDMETHOD.


  METHOD get_strip_tags_flag.


  ENDMETHOD.


  METHOD set_declared_encoding.


  ENDMETHOD.


  METHOD set_recognizers.

    DATA csr TYPE REF TO zcl_csr_super.
    DEFINE mnew.
      CREATE OBJECT csr TYPE &1.
      APPEND csr TO csrecognizers.
    END-OF-DEFINITION.
    mnew :
            zcl_csr_utf8,
            zcl_csr_utf_16_be,
            zcl_csr_utf_16_le,
*            zcl_csr_utf_32_be,
*            zcl_csr_utf_32_le,

            zcl_csr_8859_1_en,
            zcl_csr_8859_1_da,
            zcl_csr_8859_1_de,
            zcl_csr_8859_1_es,
            zcl_csr_8859_1_fr,
            zcl_csr_8859_1_it,
            zcl_csr_8859_1_nl,
            zcl_csr_8859_1_no,
            zcl_csr_8859_1_pt,
            zcl_csr_8859_1_sv,
            zcl_csr_8859_2_cs,
            zcl_csr_8859_2_hu,
            zcl_csr_8859_2_pl,
            zcl_csr_8859_2_ro,
            zcl_csr_8859_5_ru,
            zcl_csr_8859_6_ar,
            zcl_csr_8859_7_el,
            zcl_csr_8859_8_i_he,
            zcl_csr_8859_8_he,
            zcl_csr_windows_1251,
            zcl_csr_windows_1256,
            zcl_csr_koi8_r,
            zcl_csr_8859_9_tr,
*            zcl_csr_sjis,
*            zcl_csr_gb_18030,
*            zcl_csr_euc_jp,
*            zcl_csr_euc_kr,
*            zcl_csr_big5,

*            zcl_csr_2022jp,
*            zcl_csr_2022kr,
*            zcl_csr_2022cn,

            zcl_csr_ibm424_he_rtl,
            zcl_csr_ibm424_he_ltr,
            zcl_csr_ibm420_ar_rtl,
            zcl_csr_ibm420_ar_ltr.
    "APPEND csr TO csrecognizers. WHAT FOR?

  ENDMETHOD.


  METHOD set_strip_tags_flag.


  ENDMETHOD.


  METHOD set_text.

    text_in->set_text( in ).
    f_fresh_text_set = abap_true.

  ENDMETHOD.
ENDCLASS.
