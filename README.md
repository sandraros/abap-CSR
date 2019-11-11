# abap-CSR
ABAP Charset Recognizer (ICU)

This ABAP tool determines the code page (character set) and the language (English, Russian, etc.) of a file, provided it contains text.

It was introduced in this [SAP Community blog post](https://blogs.sap.com/?p=890574).

## WARNING

It should not be used productively because the result can be incorrect. A human must validate the result. It's just a tool to help temporarily.

## CREDITS

The program is mainly a porting of the Character Set Detection C++ program provided in the ICU library (http://userguide.icu-project.org/conversion/detection), and it has a few additions. The concerned files in the ICU directory `\source\i18n` are: `csdetect.cpp`, `csmatch.cpp`, `csr2022.cpp`, `csrecog.cpp`, `csrmbcs.cpp`, `csrsbcs.cpp`, `csrucode.cpp`, `csrutf8.cpp`.

## ICU LIMITS

Many character sets and languages are not detected at all.

UTF detection is fine but the language is not detected at all. UTF-16 is only detected by checking the presence of the Byte Order Mark.

## ADDITIONS TO ICU

Only Single-Byte Character Sets and Unicode are implemented (see the [supported combinations of character sets and languages](https://github.com/sandraros/abap-CSR/blob/master/List%20of%20supported%20character%20sets%20and%20languages.md)). Remaining work: MBCS and ISO-2022-* (CJK).

The language is detected in UTF-16 through an algorithm added specifically (class ZCL_CSR_UTF_16_SBCS).

Only the first 1000 bytes are checked because the algorithm is low, especially because of how the language detection has been implemented for UTF-16, but checking only 1000 bytes is sufficient to be very confident about the result.

## USAGE 

    DATA(csr_det) = NEW zcl_csr_detector( ).
    csr_det->set_text( 'EAEEE3E4E02DF2EE20E1FBEBE020EFF0E0E2E4E8E2E0FF20E8F1F2EEF0E8FF2C20EAEEF2EEF0F3FE20EBFEE4E820EDE520E7EDE0EBE8' ).
    DATA(result) = csr_det->detect( ). " Get result with highest confidence
    WRITE : / result-csr->get_language( ), ';', result-csr->get_name( ). " ru ; windows-1251
