# abap-CSR
ABAP Charset Recognizer (ICU)

This ABAP tool determines the code page (character set) and the language (English, Russian, etc.) of a file, provided it contains text.

## WARNING

It should not be used productively because the result can be incorrect. A human must validate the result. It's just a tool to help temporarily.

## CREDITS

This is a porting of the Charset Recognizer C++ program provided in the ICU library (http://site.icu-project.org/). The concerned files in directory \source\i18n are: csdetect.cpp, csmatch.cpp, csr2022.cpp, csrecog.cpp, csrmbcs.cpp, csrsbcs.cpp, csrucode.cpp, csrutf8.cpp.

## RESTRICTIONS

Currently, only SBCS are implemented (ISO-8859-*, Windows-1251, Windows-1256). Remaining work: UTF-32, MBCS and ISO-2022-* (CJK)

Possible improvement: in the ICU library, UTF-16 and UTF-32 are only detected based on the presence of the Byte Order Mark at the beginning of the string -> it should be feasible to convert the current data for each language and character set into UTF (instead of 3 bytes for each SBCS ngram, use 12 bytes for UTF-32, and variable number of bytes for UTF-16). For UTF-8, the detection is fine but the language is not detected, it could be implemented the same way.

## USAGE 

    DATA(csr_det) = NEW zcl_csr_detector( ).
    csr_det->set_text( 'EAEEE3E4E02DF2EE20E1FBEBE020EFF0E0E2E4E8E2E0FF20E8F1F2EEF0E8FF2C20EAEEF2EEF0F3FE20EBFEE4E820EDE520E7EDE0EBE8' ).
    DATA(result) = csr_det->detect( ).
    WRITE : / result-csr->get_language( ), ';', result-csr->get_name( ). " ru ; windows-1251
