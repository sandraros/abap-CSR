*&---------------------------------------------------------------------*
*& Report z_csr_display_maps
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_csr_display_maps.

DATA laiso TYPE laiso.
SELECT-OPTIONS s_langu FOR laiso LOWER CASE.

START-OF-SELECTION.
  DATA csr_det TYPE REF TO zcl_csr_detector.
  DATA in TYPE xstring.
  DATA result TYPE zcl_csr_detector=>ty_charset_match.
  DATA results TYPE zcl_csr_detector=>ty_charset_matches.

  CREATE OBJECT csr_det.
*  in = '4142425945'.
*  csr_det->set_text( in ).
*  results = csr_det->detect_all( ).
*  result = csr_det->detect( ).

  LOOP AT csr_det->csrecognizers INTO DATA(csr).
    CASE TYPE OF csr.
      WHEN TYPE zcl_csr_sbcs.
        DATA(csr_sbcs) = CAST zcl_csr_sbcs( csr ).
        IF csr_sbcs->get_language( ) IN s_langu.
          PERFORM sbcs USING csr_sbcs.
        ENDIF.
    ENDCASE.
*  DATA charmap_8859_1 TYPE zcl_csr_sbcs=>ty_charmap_sbcs.
*  charmap_8859_1 = NEW zcl_csr_8859_1_en( )->charmap_8859_1.
*  DATA ngrams_8859_1_en TYPE zcl_csr_sbcs=>ty_ngrams_sbcs.
*  ngrams_8859_1_en = NEW zcl_csr_8859_1_en( )->ngrams_8859_1_en.
*  PERFORM x USING charmap_8859_1 ngrams_8859_1_fr.
  ENDLOOP.

FORM sbcs
    USING
        sbcs TYPE REF TO zcl_csr_sbcs.
*    charmap TYPE zcl_csr_sbcs=>ty_charmap_sbcs
*    ngrams TYPE zcl_csr_sbcs=>ty_ngrams_sbcs.

  DATA index TYPE i.
  DATA byte TYPE x LENGTH 1.
  DATA charmap_x TYPE x LENGTH 256.
  DO 256 TIMES.
    charmap_x+index(1) = index.
    ADD 1 TO index.
  ENDDO.

  DATA charmap_xstring TYPE xstring.
  DATA char_256 TYPE c LENGTH 256.
  charmap_xstring = charmap_x.
  TRY.
      char_256 = cl_abap_codepage=>convert_from( source = charmap_xstring codepage = sbcs->get_name( ) ).
    CATCH cx_parameter_invalid_range.
      WRITE : / sbcs->get_name( ), 'not supported in SAP'.
      RETURN.
  ENDTRY.

  TYPES : BEGIN OF ty_gs_equivalence,
            ngrambyte   TYPE x LENGTH 1,
            charmapbyte TYPE i,
          END OF ty_gs_equivalence.
  DATA equivalence TYPE ty_gs_equivalence.
  DATA equivalences TYPE SORTED TABLE OF ty_gs_equivalence WITH NON-UNIQUE KEY ngrambyte.
  FIELD-SYMBOLS <equivalence> TYPE ty_gs_equivalence.
  index = 0.
  DO 256 TIMES.
    equivalence-ngrambyte = sbcs->charmap+index(2).
    equivalence-charmapbyte = index / 2.
    INSERT equivalence INTO TABLE equivalences.
    ADD 2 TO index.
  ENDDO.

  FORMAT COLOR 5.
  WRITE : / sbcs->get_language( ), sbcs->get_name( ).
  FORMAT COLOR OFF.

  DATA offset TYPE i.
  index = 0.
  DO 64 TIMES.
    WRITE : / sy-index, ':'.
    DO 3 TIMES.
      byte = sbcs->ngrams+index(2).
      IF byte = 32.
        WRITE '---'.
      ELSE.
        LOOP AT equivalences ASSIGNING <equivalence> WHERE ngrambyte = byte.
          WRITE char_256+<equivalence>-charmapbyte(1) NO-GAP.
        ENDLOOP.
        WRITE space NO-GAP.
      ENDIF.
      ADD 2 TO index.
    ENDDO.
  ENDDO.
ENDFORM.
