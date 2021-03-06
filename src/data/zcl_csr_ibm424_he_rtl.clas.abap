"! <p class="shorttext synchronized" lang="en">Hebrew Right-To-Left</p>
"!
CLASS zcl_csr_ibm424_he_rtl DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_ibm424_he
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor .

    METHODS get_name
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_ibm424_he_rtl IMPLEMENTATION.


  METHOD constructor.

    super->constructor( ).
    CONCATENATE
    '404146404148404151404171404251404256404541404546404551404556404562404569404571405441405445405641'
    '406254406954417140454041454042454045454054454056454069454641464140465540465740466840467140514045'
    '514540514671515155515540515740516840517140544041544045544140544540554041554042554045554054554056'
    '554069564540574045584540585140585155625440684045685155695440714041714042714045714054714056714069'
    INTO ngrams.

  ENDMETHOD.


  METHOD get_name.

    name = 'IBM424_rtl'.

  ENDMETHOD.


ENDCLASS.
