*&---------------------------------------------------------------------*
*& Report z_csr_file_detector
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_csr_file_detector.

PARAMETERS p_file TYPE string LOWER CASE.
PARAMETERS p_fe RADIOBUTTON GROUP rb1 DEFAULT 'X'.
PARAMETERS p_as RADIOBUTTON GROUP rb1.

START-OF-SELECTION.
  PERFORM main.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM f4_file CHANGING p_file.

FORM main.
  DATA: file_content       TYPE xstring,
        file_length        TYPE i,
        table_of_any_bytes TYPE TABLE OF x255.

  CASE 'X'.
    WHEN p_fe.

      CALL METHOD cl_gui_frontend_services=>gui_upload
        EXPORTING
          filename   = p_file
          filetype   = 'BIN'
        IMPORTING
          filelength = file_length
        CHANGING
          data_tab   = table_of_any_bytes
        EXCEPTIONS
          OTHERS     = 1.

      IF sy-subrc <> 0.
        MESSAGE 'File not found or cannot be opened'(001) TYPE 'I' DISPLAY LIKE 'E'.
        RETURN.
      ENDIF.

      file_content = cl_swf_utl_convert_xstring=>table_to_xstring(
          i_table = table_of_any_bytes
          i_size  = file_length ).

    WHEN p_as.

      TRY.
          OPEN DATASET p_file FOR INPUT IN BINARY MODE.
        CATCH cx_root.
          MESSAGE 'File system error'(002) TYPE 'I' DISPLAY LIKE 'E'.
          RETURN.
      ENDTRY.
      IF sy-subrc <> 0.
        MESSAGE 'File not found or cannot be opened'(001) TYPE 'I' DISPLAY LIKE 'E'.
        RETURN.
      ELSE.
        TRY.
            READ DATASET p_file INTO file_content.
          CATCH cx_root.
            MESSAGE 'File system error'(002) TYPE 'I' DISPLAY LIKE 'E'.
            RETURN.
        ENDTRY.
        TRY.
            CLOSE DATASET p_file.
          CATCH cx_root ##NO_HANDLER.
        ENDTRY.
      ENDIF.

  ENDCASE.

  IF file_content IS INITIAL.
    MESSAGE 'File is empty'(003) TYPE 'I' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  DATA(csr_det) = NEW zcl_csr_detector( ).
  csr_det->set_text( file_content ).
  DATA(results) = csr_det->detect_all( ).

  IF results IS INITIAL.
    cl_demo_output=>display_text( 'Character set and language unknown'(004) ).
  ELSE.
    cl_demo_output=>display_html( html = |<p style='font-weight:bold;'>{ p_file }</p>| && REDUCE #(
      INIT str = ``
      FOR result IN results
      NEXT str = str && |{ escape( val = |{ result-confidence }: { result-csr->get_name( ) }, { result-csr->get_language( ) }|
          format = cl_abap_format=>e_html_text ) }<br/>| ) ).
  ENDIF.

ENDFORM.

FORM f4_file CHANGING p_file.
  DATA lt_filetable    TYPE filetable.
  DATA l_rc           TYPE i.
  DATA l_action       TYPE i.
  FIELD-SYMBOLS <ls_file> TYPE file_table.

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    CHANGING
      file_table              = lt_filetable
      rc                      = l_rc
      user_action             = l_action
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5.
  IF sy-subrc NE 0.
    " error
  ELSEIF l_action NE cl_gui_frontend_services=>action_ok.
    " Download cancelled by user
  ELSE.
    " 1 or several files selected
    READ TABLE lt_filetable INDEX 1 ASSIGNING <ls_file>.
    IF sy-subrc = 0.
      p_file = <ls_file>-filename.
    ENDIF.
  ENDIF.

ENDFORM.
