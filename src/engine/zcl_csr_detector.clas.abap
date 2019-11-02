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
      END OF ty_charset_match,
      ty_charset_matches TYPE STANDARD TABLE OF ty_charset_match WITH DEFAULT KEY,
      ty_csrecognizers TYPE STANDARD TABLE OF REF TO zcl_csr_super WITH DEFAULT KEY.

    DATA: f_fresh_text_set TYPE abap_bool,
    text_in TYPE REF TO zcl_csr_input_text,
    csrecognizers    TYPE ty_csrecognizers,
    f_strip_tags TYPE abap_bool VALUE abap_false ##NO_TEXT.

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

    csrecognizers = value #(
        ( NEW zcl_csr_utf8( ) )
        ( NEW zcl_csr_utf_16_be( ) )
        ( NEW zcl_csr_utf_16_le( ) )
        ( NEW zcl_csr_utf_32_be( ) )
        ( NEW zcl_csr_utf_32_le( ) )

        ( NEW zcl_csr_8859_1_en( ) )
        ( NEW zcl_csr_8859_1_da( ) )
        ( NEW zcl_csr_8859_1_de( ) )
        ( NEW zcl_csr_8859_1_es( ) )
        ( NEW zcl_csr_8859_1_fr( ) )
        ( NEW zcl_csr_8859_1_it( ) )
        ( NEW zcl_csr_8859_1_nl( ) )
        ( NEW zcl_csr_8859_1_no( ) )
        ( NEW zcl_csr_8859_1_pt( ) )
        ( NEW zcl_csr_8859_1_sv( ) )
        ( NEW zcl_csr_8859_2_cs( ) )
        ( NEW zcl_csr_8859_2_hu( ) )
        ( NEW zcl_csr_8859_2_pl( ) )
        ( NEW zcl_csr_8859_2_ro( ) )
        ( NEW zcl_csr_8859_5_ru( ) )
        ( NEW zcl_csr_8859_6_ar( ) )
        ( NEW zcl_csr_8859_7_el( ) )
        ( NEW zcl_csr_8859_8_i_he( ) )
        ( NEW zcl_csr_8859_8_he( ) )
        ( NEW zcl_csr_8859_9_tr( ) )
        ( NEW zcl_csr_windows_1251( ) )
        ( NEW zcl_csr_windows_1256( ) )
        ( NEW zcl_csr_koi8_r( ) )
        ( NEW zcl_csr_ibm424_he_rtl( ) )
        ( NEW zcl_csr_ibm424_he_ltr( ) )
        ( NEW zcl_csr_ibm420_ar_rtl( ) )
        ( NEW zcl_csr_ibm420_ar_ltr( ) ) ).

*        ( NEW zcl_csr_sjis( ) )
*        ( NEW zcl_csr_gb_18030( ) )
*        ( NEW zcl_csr_euc_jp( ) )
*        ( NEW zcl_csr_euc_kr( ) )
*        ( NEW zcl_csr_big5( ) )

*        ( NEW zcl_csr_2022jp( ) )
*        ( NEW zcl_csr_2022kr( ) )
*        ( NEW zcl_csr_2022cn( ) )

*loop at csrecognizers into data(csr).
*if csr is instance of zcl_csr_sbcs.
*data(csr_utf_16_be) = zcl_csr_utf_16=>create_csr_from_sbcs( csr_sbcs = csr_sbcs be = abap_true ).
*data(csr_utf_16_le) = zcl_csr_utf_16=>create_csr_from_sbcs( csr_sbcs = csr_sbcs be = abap_false ).
*APPEND NEW zcl_csr_utf16( csr2 ) TO csrecognizers.
*endif.
*endloop.

  ENDMETHOD.


  METHOD set_strip_tags_flag.


  ENDMETHOD.


  METHOD set_text.

    text_in->set_text( in ).
    f_fresh_text_set = abap_true.

  ENDMETHOD.
ENDCLASS.
