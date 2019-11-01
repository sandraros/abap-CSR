"! <p class="shorttext synchronized" lang="en">Arab</p>
"!
CLASS zcl_csr_8859_6_ar DEFINITION
  PUBLIC
  INHERITING FROM zcl_csr_8859_6
  CREATE PUBLIC .

  PUBLIC SECTION.

*    DATA ngrams_8859_6_ar TYPE ty_ngrams_sbcs .

    METHODS constructor .

    METHODS get_language
        REDEFINITION .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_csr_8859_6_ar IMPLEMENTATION.


  METHOD constructor.

    super->constructor( ).
    CONCATENATE
    '20C7E420C7E620C8C720D9E420E1EA20E4E420E5E620E8C7C720C7C7C120C7CA20C7D120C7E420C7E4C3C7E4C7C7E4C8'
    'C7E4CAC7E4CCC7E4CDC7E4CFC7E4D3C7E4D9C7E4E2C7E4E5C7E4E8C7E4EAC7E520C7E620C7E6CAC820C7C920C7C920E1'
    'C920E4C920E5C920E8CA20C7CF20C7CFC920D120C7D1C920D320C7D920C7D9E4E9E1EA20E420C7E4C920E4E920E4EA20'
    'E520C7E5C720E5C920E5E620E620C7E720C7E7C720E8C7E4E8E620E920C7EA20C7EA20E5EA20E8EAC920EAD120EAE620'
    INTO ngrams.
*    INTO ngrams_8859_6_ar.

  ENDMETHOD.


  METHOD get_language.

    language = 'ar'.

  ENDMETHOD.


ENDCLASS.
