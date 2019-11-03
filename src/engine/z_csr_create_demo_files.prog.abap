*&---------------------------------------------------------------------*
*& Report z_csr_create_demo_files
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_csr_create_demo_files.

CLASS lcl_app DEFINITION.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        p_file TYPE string.
    METHODS main.
  PRIVATE SECTION.

    DATA p_file TYPE string.
    METHODS utf.

    METHODS download
      IMPORTING
        name    TYPE csequence
        content TYPE xstring.
    METHODS iso_8859_1.
    METHODS iso_8859_2.
    METHODS iso_8859_others.
    METHODS others.

ENDCLASS.

CLASS lcl_app IMPLEMENTATION.

  METHOD constructor.

    me->p_file = p_file.

  ENDMETHOD.

  METHOD main.

    utf( ).
    iso_8859_1( ).
    iso_8859_2( ).
    iso_8859_others( ).
    others( ).

  ENDMETHOD.

  METHOD utf.

    download( name = 'utf_8_fr' content = cl_abap_codepage=>convert_to(
        source   = 'il était une fois une histoire véridique'
        codepage = 'UTF-8' ) ).
    download( name = 'utf_16be_en' content = cl_abap_codepage=>convert_to(
        source   = 'once upon a time there was a true story'
        codepage = 'utf-16be' ) ).
    download( name = 'utf_16be_fr' content = cl_abap_codepage=>convert_to(
        source   = 'il était une fois une histoire véridique'
        codepage = 'utf-16be' ) ).
    download( name = 'utf_16be_bom_fr' content = cl_bcs_convert=>string_to_xstring(
          iv_string   = 'il était une fois une histoire véridique'
          iv_codepage = '4102' " UTF-16BE
          iv_add_bom  = abap_true ) ).
    download( name = 'utf_16le_fr' content = cl_abap_codepage=>convert_to(
        source   = 'il était une fois une histoire véridique'
        codepage = 'utf-16le' ) ).
    download( name = 'utf_16le_bom_fr' content = cl_bcs_convert=>string_to_xstring(
          iv_string   = 'il était une fois une histoire véridique'
          iv_codepage = '4103' " UTF-16LE
          iv_add_bom  = abap_true ) ).
    download( name = 'utf_32be_fr' content = cl_bcs_convert=>string_to_xstring(
          iv_string   = 'il était une fois une histoire véridique'
          iv_codepage = '4104' ) ). " UTF-32BE
    download( name = 'utf_32be_bom_fr' content = cl_bcs_convert=>string_to_xstring(
          iv_string   = 'il était une fois une histoire véridique'
          iv_codepage = '4104' " UTF-32BE
          iv_add_bom  = abap_true ) ).
    download( name = 'utf_32le_fr' content = cl_bcs_convert=>string_to_xstring(
        iv_string   = 'il était une fois une histoire véridique'
        iv_codepage = '4105' ) ). " UTF-32LE
    download( name = 'utf_32le_bom_fr' content = cl_bcs_convert=>string_to_xstring(
          iv_string   = 'il était une fois une histoire véridique'
          iv_codepage = '4105' " UTF-32LE
          iv_add_bom  = abap_true ) ).

  ENDMETHOD.


  METHOD iso_8859_1.

    download( name = 'iso_8859_1_da' content = cl_abap_codepage=>convert_to(
        source   = 'engang var der en sand historie, som ikke var kendt af folket'
        codepage = 'iso-8859-1' ) ).
    download( name = 'iso_8859_1_en' content = cl_abap_codepage=>convert_to(
        source   = 'once upon a time there was a true story'
        codepage = 'iso-8859-1' ) ).
    download( name = 'iso_8859_1_fr' content = cl_abap_codepage=>convert_to(
        source   = 'il était une fois une histoire véridique'
        codepage = 'iso-8859-1' ) ).
    download( name = 'iso_8859_1_it' content = cl_abap_codepage=>convert_to(
        source   = 'c''era una volta una storia vera che non era conosciuta dalla gente'
        codepage = 'iso-8859-1' ) ).
    download( name = 'iso_8859_1_sv' content = cl_abap_codepage=>convert_to(
        source   = 'en gång i tiden var det en sann historia som inte var känd av folket'
        codepage = 'iso-8859-1' ) ).
    download( name = 'iso_8859_1_de' content = cl_abap_codepage=>convert_to(
        source   = 'Es war einmal eine wahre Geschichte, die das Volk nicht kannte'
        codepage = 'iso-8859-1' ) ).
    download( name = 'iso_8859_1_es' content = cl_abap_codepage=>convert_to(
        source   = 'Había una vez una historia real que la gente no conocía'
        codepage = 'iso-8859-1' ) ).
    download( name = 'iso_8859_1_nl' content = cl_abap_codepage=>convert_to(
        source   = 'er was eens een waargebeurd verhaal dat de mensen niet kenden'
        codepage = 'iso-8859-1' ) ).
    download( name = 'iso_8859_1_no' content = cl_abap_codepage=>convert_to(
        source   = 'Kongeriket Norge er et nordisk, europeisk land og en selvstendig stat vest på Den skandinaviske halvøy'
        codepage = 'iso-8859-1' ) ).
    download( name = 'iso_8859_1_pt' content = cl_abap_codepage=>convert_to(
        source   = 'Era uma vez uma história verdadeira que não era conhecida pelo povo'
        codepage = 'iso-8859-1' ) ).

  ENDMETHOD.


  METHOD iso_8859_2.

    download( name = 'iso_8859_2_cs' content = cl_abap_codepage=>convert_to(
        source   = 'kdysi byl skutečný příběh, který lidé neznali'
        codepage = 'iso-8859-2' ) ).
    download( name = 'iso_8859_2_hu' content = cl_abap_codepage=>convert_to(
        source   = 'egyszer volt egy igaz történet, amelyet az emberek nem ismertek'
        codepage = 'iso-8859-2' ) ).
    download( name = 'iso_8859_2_pl' content = cl_abap_codepage=>convert_to(
        source   = 'Dawno, dawno temu istniała prawdziwa historia, której ludzie nie znali'
        codepage = 'iso-8859-2' ) ).
    download( name = 'iso_8859_2_ro' content = cl_abap_codepage=>convert_to(
        source   = 'a fost odată o poveste adevărată care nu a fost cunoscută de oameni'
        codepage = 'iso-8859-2' ) ).

  ENDMETHOD.


  METHOD iso_8859_others.

    download( name = 'iso_8859_5_ru' content = cl_abap_codepage=>convert_to(
        source   = 'когда-то была правдивая история, которую люди не знали'
        codepage = 'iso-8859-5' ) ).
    download( name = 'iso_8859_6_ar' content = cl_abap_codepage=>convert_to(
        source   = 'ذات مرة كانت هناك قصة حقيقية لم يعرفها الناس'
        codepage = 'iso-8859-6' ) ).
    download( name = 'iso_8859_7_el' content = cl_abap_codepage=>convert_to(
        source   = 'μια φορά κι έναν καιρό υπήρχε μια αληθινή ιστορία που δεν ήταν γνωστή από τον λαό'
        codepage = 'iso-8859-7' ) ).
    download( name = 'iso_8859_8_he' content = cl_abap_codepage=>convert_to(
        source   = 'פעם היה סיפור אמיתי שלא היה ידוע על ידי האנשים'
        codepage = 'iso-8859-8' ) ).
    download( name = 'iso_8859_9_tr' content = cl_abap_codepage=>convert_to(
        source   = 'bir zamanlar halkın bilmediği gerçek bir hikaye vardı'
        codepage = 'iso-8859-9' ) ).

  ENDMETHOD.


  METHOD others.

    download( name = 'koi8_r_ru' content = cl_abap_codepage=>convert_to(
        source   = 'когда-то была правдивая история, которую люди не знали'
        codepage = 'KOI8-R' ) ).
    download( name = 'windows_1251_ru' content = cl_abap_codepage=>convert_to(
      source   = 'когда-то была правдивая история, которую люди не знали'
      codepage = 'windows-1251' ) ).
    download( name = 'windows_1256_ar' content = cl_abap_codepage=>convert_to(
        source   = 'ذات مرة كانت هناك قصة حقيقية لم يعرفها الناس'
        codepage = 'windows-1256' ) ).
    " Code pages ibm420 and ibm424 (ebcdic420 and ebcdic424) are not supplied by SAP.
    download( name = 'ibm424_ltr_he' content =
        '59516958414540515251405462406246525140455145404154694051485156414052466451594045514540596264' ).
    download( name = 'ibm424_rtl_he' content =
        '64625940455145405951644652404156514851406954414045514540515246624062544051525140454158695159' ).
    download( name = 'ibm420_ltr_ar' content =
        '775774BA564057CDAC40759DDE40BBBA4062DEAEDEAE7040628CAE40B05774CB40637457B0406275BC40635674' ).
    download( name = 'ibm420_rtl_ar' content =
        '74566340BC756240B057746340CB7457B040AE8C624070AEDEAEDE6240BABB40DE9D7540ACCD574056BA745777' ).

  ENDMETHOD.


  METHOD download.

    DATA lt_xstring TYPE TABLE OF x255.
    DATA l_length TYPE i.
    DATA l_filename TYPE string.

    CALL METHOD cl_swf_utl_convert_xstring=>xstring_to_table
      EXPORTING
        i_stream = content
      IMPORTING
        e_table  = lt_xstring
      EXCEPTIONS
        OTHERS   = 3.
    l_length = xstrlen( content ).

    l_filename = replace( val = p_file sub = '&1' with = name ).
    CALL METHOD cl_gui_frontend_services=>gui_download
      EXPORTING
        bin_filesize = l_length
        filename     = l_filename
        filetype     = 'BIN'
      CHANGING
        data_tab     = lt_xstring
      EXCEPTIONS
        OTHERS       = 3.

  ENDMETHOD.


ENDCLASS.

PARAMETERS p_file TYPE string LOWER CASE DEFAULT '\path\&1.txt'.

START-OF-SELECTION.
  NEW lcl_app( p_file )->main( ).
