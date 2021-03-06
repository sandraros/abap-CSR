"! <p class="shorttext synchronized" lang="en">Arabic Left-To-Right</p>
"!
CLASS zcl_csr_ibm420_ar_ltr DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_ibm420_ar
  CREATE PUBLIC .

  PUBLIC SECTION.

*    DATA ngrams_ibm420_ar_ltr TYPE ty_ngrams_sbcs .

    METHODS constructor .

    METHODS get_name
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_ibm420_ar_ltr IMPLEMENTATION.


  METHOD constructor.

    super->constructor( ).
    CONCATENATE
    '4046564056BB4056BF4062734062754062B14062BB4062DC4063564075564075DC40B15640BB5640BD5640BDBB40BDCF'
    '40BDDC40DAB140DCAB40DCB149B15656405656405856406256406356407356407556407856409A5640B15640BB5640BD'
    '5640BF5640DA5640DC56584056B15656CF4058B15663B15663BD5667B15669B15673B15678B1569AB156AB4062ADB156'
    'B14062B15640B156CFB19A40B1B140BB4062BB40DCBBB156BD5640BDBB40CF4062CF40DCCFB156DAB19ADCAB40DCB156'
    INTO ngrams.
*    INTO ngrams_ibm420_ar_ltr.

  ENDMETHOD.


  METHOD get_name.

    name = 'IBM420_ltr'.

  ENDMETHOD.


ENDCLASS.
