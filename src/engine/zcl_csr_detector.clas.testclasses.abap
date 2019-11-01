*"* use this source file for your ABAP unit test classes
CLASS ltc_aunit DEFINITION
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA csr_det TYPE REF TO zcl_csr_detector .
    DATA result TYPE zcl_csr_detector=>ty_charset_match .

    METHODS test_utf8 FOR TESTING.
    METHODS test_utf_16_be FOR TESTING.
    METHODS test_utf_16_le FOR TESTING.
    METHODS test_8859_1_da FOR TESTING.
    METHODS test_8859_1_de FOR TESTING.
    METHODS test_8859_1_en FOR TESTING.
    METHODS test_8859_1_es FOR TESTING.
    METHODS test_8859_1_fr FOR TESTING.
    METHODS test_8859_1_it FOR TESTING.
    METHODS test_8859_1_nl FOR TESTING.
    METHODS test_8859_1_no FOR TESTING.
    METHODS test_8859_1_pt FOR TESTING.
    METHODS test_8859_1_sv FOR TESTING.
    METHODS test_8859_2_cs FOR TESTING.
    METHODS test_8859_2_hu FOR TESTING.
    METHODS test_8859_2_pl FOR TESTING.
    METHODS test_8859_2_ro FOR TESTING.
    METHODS test_8859_5_ru FOR TESTING.
    METHODS test_8859_6_ar FOR TESTING.
    METHODS test_8859_7_el FOR TESTING.
    METHODS test_8859_8_he FOR TESTING.
    METHODS test_8859_9_tr FOR TESTING.
    METHODS test_windows_1251 FOR TESTING.
    METHODS test_windows_1256 FOR TESTING.
    METHODS test_koi8_r FOR TESTING.
*    METHODS test_ibm424_he_rtl FOR TESTING.
*    METHODS test_ibm424_he_ltr FOR TESTING.
*    METHODS test_ibm420_ar_rtl FOR TESTING.
*    METHODS test_ibm420_ar_ltr FOR TESTING.

    METHODS setup .

    TYPES: BEGIN OF ty_exp_result,
             confidence TYPE i,
             language   TYPE laiso,
             charset    TYPE string,
           END OF ty_exp_result,
           ty_exp_results TYPE STANDARD TABLE OF ty_exp_result WITH EMPTY KEY.
    DATA exp_results TYPE ty_exp_results.

ENDCLASS.



CLASS ltc_aunit IMPLEMENTATION.


  METHOD setup.

    CREATE OBJECT csr_det.

  ENDMETHOD.


  METHOD test_8859_1_da.

    " DANISH
    " engang var der en sand historie, som ikke var kendt af folket
    csr_det->set_text( cl_abap_codepage=>convert_to( source = 'engang var der en sand historie, som ikke var kendt af folket' codepage = 'iso-8859-1' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'da' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-1' act = result-csr->get_name( ) ).

  ENDMETHOD.


  METHOD test_8859_1_en.

    " ENGLISH
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'once upon a time there was a true story'
        codepage = 'iso-8859-1' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals(
        exp = abap_true
        act = xsdbool( result-csr->get_language( ) = 'en' AND result-csr->get_name( ) = 'ISO-8859-1' ) ).

  ENDMETHOD.


  METHOD test_8859_1_fr.

    " FRENCH
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'il était une fois une histoire véridique'
        codepage = 'iso-8859-1' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals(
        exp = abap_true
        act = xsdbool( result-csr->get_language( ) = 'fr' AND result-csr->get_name( ) = 'ISO-8859-1' ) ).

  ENDMETHOD.


  METHOD test_8859_1_it.

    " ITALIAN
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'c''era una volta una storia vera che non era conosciuta dalla gente'
        codepage = 'iso-8859-1' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals(
        exp = abap_true
        act = xsdbool( result-csr->get_language( ) = 'it' AND result-csr->get_name( ) = 'ISO-8859-1' ) ).

  ENDMETHOD.


  METHOD test_8859_1_sv.

    " SWEDISH
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'en gång i tiden var det en sann historia som inte var känd av folket'
        codepage = 'iso-8859-1' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals(
        exp = abap_true
        act = xsdbool( result-csr->get_language( ) = 'sv' AND result-csr->get_name( ) = 'ISO-8859-1' ) ).

  ENDMETHOD.


  METHOD test_utf8.

    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'il était une fois une histoire véridique'
        codepage = 'UTF-8' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals(
        exp = abap_true
        act = xsdbool( result-csr->get_language( ) = '' AND result-csr->get_name( ) = 'UTF-8' ) ).

  ENDMETHOD.

  METHOD test_utf_16_be.

    csr_det->set_text( in = cl_bcs_convert=>string_to_xstring(
          iv_string     = 'il était une fois une histoire véridique'
          iv_codepage   = '4102' " UTF-16BE
          iv_add_bom    = abap_true ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals(
        exp = abap_true
        act = xsdbool( result-csr->get_language( ) = '' AND result-csr->get_name( ) = 'UTF-16BE' ) ).

  ENDMETHOD.

  METHOD test_utf_16_le.

    csr_det->set_text( in = cl_bcs_convert=>string_to_xstring(
          iv_string     = 'il était une fois une histoire véridique'
          iv_codepage   = '4103' " UTF-16LE
          iv_add_bom    = abap_true ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals(
        exp = abap_true
        act = xsdbool( result-csr->get_language( ) = '' AND result-csr->get_name( ) = 'UTF-16LE' ) ).

  ENDMETHOD.

  METHOD test_8859_1_de.

    " GERMAN
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'Es war einmal eine wahre Geschichte, die das Volk nicht kannte'
        codepage = 'iso-8859-1' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals(
        exp = abap_true
        act = xsdbool( result-csr->get_language( ) = 'de' AND result-csr->get_name( ) = 'ISO-8859-1' ) ).

  ENDMETHOD.

  METHOD test_8859_1_es.

    " SPANISH
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'Había una vez una historia real que la gente no conocía'
        codepage = 'iso-8859-1' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals(
        exp = abap_true
        act = xsdbool( result-csr->get_language( ) = 'es' AND result-csr->get_name( ) = 'ISO-8859-1' ) ).

  ENDMETHOD.

  METHOD test_8859_1_nl.

    " NEDERLANDS / DUTCH
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'er was eens een waargebeurd verhaal dat de mensen niet kenden'
        codepage = 'iso-8859-1' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'nl' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-1' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_8859_1_no.

    " NORWEGIAN
    " Kingdom of Norway is a Nordic, European country and an independent state west of the Scandinavian Peninsula
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'Kongeriket Norge er et nordisk, europeisk land og en selvstendig stat vest på Den skandinaviske halvøy'
        codepage = 'iso-8859-1' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'no' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-1' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_8859_1_pt.

    " PORTUGUESE
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'Era uma vez uma história verdadeira que não era conhecida pelo povo'
        codepage = 'iso-8859-1' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'pt' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-1' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_8859_2_cs.

    " CZECH
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'kdysi byl skutečný příběh, který lidé neznali'
        codepage = 'iso-8859-2' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'cs' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-2' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_8859_2_hu.

    " HUNGARIAN
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'egyszer volt egy igaz történet, amelyet az emberek nem ismertek'
        codepage = 'iso-8859-2' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'hu' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-2' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_8859_2_pl.

    " POLISH
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'Dawno, dawno temu istniała prawdziwa historia, której ludzie nie znali'
        codepage = 'iso-8859-2' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'pl' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-2' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_8859_2_ro.

    " ROMANIAN
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'a fost odată o poveste adevărată care nu a fost cunoscută de oameni'
        codepage = 'iso-8859-2' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'ro' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-2' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_8859_5_ru.

    " RUSSIAN
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'когда-то была правдивая история, которую люди не знали'
        codepage = 'iso-8859-5' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'ru' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-5' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_8859_6_ar.

    " ARABIC
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'ذات مرة كانت هناك قصة حقيقية لم يعرفها الناس'
        codepage = 'iso-8859-6' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'ar' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-6' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_8859_7_el.

    " GREEK
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'μια φορά κι έναν καιρό υπήρχε μια αληθινή ιστορία που δεν ήταν γνωστή από τον λαό'
        codepage = 'iso-8859-7' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'el' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-7' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_8859_8_he.

    " HEBREW
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'פעם היה סיפור אמיתי שלא היה ידוע על ידי האנשים'
        codepage = 'iso-8859-8' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'he' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-8' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_8859_9_tr.

    " TURKISH
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'bir zamanlar halkın bilmediği gerçek bir hikaye vardı'
        codepage = 'iso-8859-9' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'tr' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'ISO-8859-9' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_koi8_r.

    " RUSSIAN
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'когда-то была правдивая история, которую люди не знали'
        codepage = 'KOI8-R' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'ru' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'KOI8-R' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_windows_1251.

    " RUSSIAN
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'когда-то была правдивая история, которую люди не знали'
        codepage = 'windows-1251' ) ).
    result = csr_det->detect( ).
    cl_abap_unit_assert=>assert_equals( exp = 'ru' act = result-csr->get_language( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 'windows-1251' act = result-csr->get_name( ) ).

  ENDMETHOD.

  METHOD test_windows_1256.

    " ARABIC
    " once upon a time there was a true story which was not known by the people
    csr_det->set_text( cl_abap_codepage=>convert_to(
        source   = 'ذات مرة كانت هناك قصة حقيقية لم يعرفها الناس'
        codepage = 'windows-1256' ) ).
    DATA(results) = csr_det->detect_all( ).
    exp_results = VALUE #(
        ( confidence = 63 language = 'ar' charset = 'ISO-8859-6' )
        ( confidence = 53 language = 'ar' charset = 'windows-1256' ) ).
    LOOP AT results ASSIGNING FIELD-SYMBOL(<result>).
      READ TABLE exp_results INDEX sy-tabix ASSIGNING FIELD-SYMBOL(<exp_result>).
      cl_abap_unit_assert=>assert_subrc( exp = 0 act = sy-subrc ).
      cl_abap_unit_assert=>assert_equals( exp = <exp_result>-confidence act = <result>-confidence ).
      cl_abap_unit_assert=>assert_equals( exp = <exp_result>-language   act = <result>-csr->get_language( ) ).
      cl_abap_unit_assert=>assert_equals( exp = <exp_result>-charset    act = <result>-csr->get_name( ) ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
