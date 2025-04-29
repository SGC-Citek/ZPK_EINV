class ZEINV_CO_PORTAL_SERVICE_SOAP definition
  public
  inheriting from CL_PROXY_CLIENT
  create public .

public section.

  methods DOWNLOAD_INV_ZIP_FKEY
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_ZIP_FKEY_S1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_ZIP_FKEY_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_ZIP_TOKEN
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_ZIP_TOKEN_1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_ZIP_TOKEN_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_NEW_INV_PDFFKEY
    importing
      !INPUT type ZEINV_DOWNLOAD_NEW_INV_PDFFKE1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_NEW_INV_PDFFKEY
    raising
      CX_AI_SYSTEM_FAULT .
  methods FORGETPASS
    importing
      !INPUT type ZEINV_FORGETPASS_SOAP_IN
    exporting
      !OUTPUT type ZEINV_FORGETPASS_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GETCATALOG_VIEW_FKEY
    importing
      !INPUT type ZEINV_GETCATALOG_VIEW_FKEY_SO1
    exporting
      !OUTPUT type ZEINV_GETCATALOG_VIEW_FKEY_SOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_CATALOG_VIEW
    importing
      !INPUT type ZEINV_GET_CATALOG_VIEW_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_CATALOG_VIEW_SOAP_OU
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_CUS
    importing
      !INPUT type ZEINV_GET_CUS_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_CUS_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_CUS_WITH_BUYER
    importing
      !INPUT type ZEINV_GET_CUS_WITH_BUYER_SOAP1
    exporting
      !OUTPUT type ZEINV_GET_CUS_WITH_BUYER_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_DIGEST
    importing
      !INPUT type ZEINV_GET_DIGEST_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_DIGEST_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INV_ERROR_VIEW_FKEY
    importing
      !INPUT type ZEINV_GET_INV_ERROR_VIEW_FKEY1
    exporting
      !OUTPUT type ZEINV_GET_INV_ERROR_VIEW_FKEY
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INV_VIEW
    importing
      !INPUT type ZEINV_GET_INV_VIEW_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_INV_VIEW_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INV_VIEW_BY_DATE
    importing
      !INPUT type ZEINV_GET_INV_VIEW_BY_DATE_SO1
    exporting
      !OUTPUT type ZEINV_GET_INV_VIEW_BY_DATE_SOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INV_VIEW_FKEY
    importing
      !INPUT type ZEINV_GET_INV_VIEW_FKEY_SOAP_I
    exporting
      !OUTPUT type ZEINV_GET_INV_VIEW_FKEY_SOAP_O
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INV_VIEW_FKEY_BY_STAFF
    importing
      !INPUT type ZEINV_GET_INV_VIEW_FKEY_BY_ST1
    exporting
      !OUTPUT type ZEINV_GET_INV_VIEW_FKEY_BY_STA
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INV_VIEW_FKEY_NO_PAY
    importing
      !INPUT type ZEINV_GET_INV_VIEW_FKEY_NO_PA1
    exporting
      !OUTPUT type ZEINV_GET_INV_VIEW_FKEY_NO_PAY
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INV_VIEW_FKEY_NO_PAY_PATTE
    importing
      !INPUT type ZEINV_GET_INV_VIEW_FKEY_NO_PA3
    exporting
      !OUTPUT type ZEINV_GET_INV_VIEW_FKEY_NO_PA2
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INV_VIEW_NO_PAY
    importing
      !INPUT type ZEINV_GET_INV_VIEW_NO_PAY_SOA1
    exporting
      !OUTPUT type ZEINV_GET_INV_VIEW_NO_PAY_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_NEW_INV_VIEW_FKEY
    importing
      !INPUT type ZEINV_GET_NEW_INV_VIEW_FKEY_S1
    exporting
      !OUTPUT type ZEINV_GET_NEW_INV_VIEW_FKEY_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_STAFF
    importing
      !INPUT type ZEINV_GET_STAFF_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_STAFF_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods LIST_COMPANY
    importing
      !INPUT type ZEINV_LIST_COMPANY_SOAP_IN
    exporting
      !OUTPUT type ZEINV_LIST_COMPANY_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods LIST_INV_BY_CUS
    importing
      !INPUT type ZEINV_LIST_INV_BY_CUS_SOAP_IN
    exporting
      !OUTPUT type ZEINV_LIST_INV_BY_CUS_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods LIST_INV_BY_CUS_FKEY
    importing
      !INPUT type ZEINV_LIST_INV_BY_CUS_FKEY_SO1
    exporting
      !OUTPUT type ZEINV_LIST_INV_BY_CUS_FKEY_SOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods LIST_INV_BY_CUS_FKEY_VNP
    importing
      !INPUT type ZEINV_LIST_INV_BY_CUS_FKEY_VN1
    exporting
      !OUTPUT type ZEINV_LIST_INV_BY_CUS_FKEY_VNP
    raising
      CX_AI_SYSTEM_FAULT .
  methods LIST_INV_FROM_NO_TO_NO
    importing
      !INPUT type ZEINV_LIST_INV_FROM_NO_TO_NO_1
    exporting
      !OUTPUT type ZEINV_LIST_INV_FROM_NO_TO_NO_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods LIST_PATTERN_BY_COM
    importing
      !INPUT type ZEINV_LIST_PATTERN_BY_COM_SOA1
    exporting
      !OUTPUT type ZEINV_LIST_PATTERN_BY_COM_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods LOGINPORTAL
    importing
      !INPUT type ZEINV_LOGINPORTAL_SOAP_IN
    exporting
      !OUTPUT type ZEINV_LOGINPORTAL_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEARCH_INV
    importing
      !INPUT type ZEINV_SEARCH_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SEARCH_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_PDFNO_PAY_ERROR
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_PDFNO_PAY_1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_PDFNO_PAY_E
    raising
      CX_AI_SYSTEM_FAULT .
  methods CHANGEPASSWORD
    importing
      !INPUT type ZEINV_CHANGEPASSWORD_SOAP_IN
    exporting
      !OUTPUT type ZEINV_CHANGEPASSWORD_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONFIRM_SIGANTURE
    importing
      !INPUT type ZEINV_CONFIRM_SIGANTURE_SOAP_I
    exporting
      !OUTPUT type ZEINV_CONFIRM_SIGANTURE_SOAP_O
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONSTRUCTOR
    importing
      !DESTINATION type ref to IF_PROXY_DESTINATION optional
      !LOGICAL_PORT_NAME type PRX_LOGICAL_PORT_NAME optional
    preferred parameter LOGICAL_PORT_NAME
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONVERT_FOR_STORE
    importing
      !INPUT type ZEINV_CONVERT_FOR_STORE_SOAP_I
    exporting
      !OUTPUT type ZEINV_CONVERT_FOR_STORE_SOAP_O
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONVERT_FOR_STORE_BASE64HTML_B
    importing
      !INPUT type ZEINV_CONVERT_FOR_STORE_BASE61
    exporting
      !OUTPUT type ZEINV_CONVERT_FOR_STORE_BASE64
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONVERT_FOR_STORE_FKEY
    importing
      !INPUT type ZEINV_CONVERT_FOR_STORE_FKEY_2
    exporting
      !OUTPUT type ZEINV_CONVERT_FOR_STORE_FKEY_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONVERT_FOR_STORE_FKEY_PATTERN
    importing
      !INPUT type ZEINV_CONVERT_FOR_STORE_FKEY_1
    exporting
      !OUTPUT type ZEINV_CONVERT_FOR_STORE_FKEY_P
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONVERT_FOR_VERIFY
    importing
      !INPUT type ZEINV_CONVERT_FOR_VERIFY_SOAP3
    exporting
      !OUTPUT type ZEINV_CONVERT_FOR_VERIFY_SOAP2
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONVERT_FOR_VERIFY_BASE64HTML
    importing
      !INPUT type ZEINV_CONVERT_FOR_VERIFY_BASE1
    exporting
      !OUTPUT type ZEINV_CONVERT_FOR_VERIFY_BASE6
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONVERT_FOR_VERIFY_FKEY
    importing
      !INPUT type ZEINV_CONVERT_FOR_VERIFY_FKEY1
    exporting
      !OUTPUT type ZEINV_CONVERT_FOR_VERIFY_FKEY
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONVERT_FOR_VERIFY_FKEY_PATTER
    importing
      !INPUT type ZEINV_CONVERT_FOR_VERIFY_FKEY3
    exporting
      !OUTPUT type ZEINV_CONVERT_FOR_VERIFY_FKEY2
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_CTTFKEY
    importing
      !INPUT type ZEINV_DOWNLOAD_CTTFKEY_SOAP_IN
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_CTTFKEY_SOAP_OU
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_CTTTOKEN
    importing
      !INPUT type ZEINV_DOWNLOAD_CTTTOKEN_SOAP_I
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_CTTTOKEN_SOAP_O
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_ERROR
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_ERROR_SOAP1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_ERROR_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_ERROR_FKEY
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_ERROR_FKEY1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_ERROR_FKEY
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_ERROR_PDF
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_ERROR_PDFS1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_ERROR_PDFSO
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_FKEY
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_FKEY_SOAP_I
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_FKEY_SOAP_O
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_FKEY_NO_PAY
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_FKEY_NO_PA1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_FKEY_NO_PAY
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_NO_PAY
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_NO_PAY_SOA1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_NO_PAY_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_NO_PAY_ERROR
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_NO_PAY_ERR1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_NO_PAY_ERRO
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_PDF
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_PDFSOAP_IN
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_PDFSOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_PDFFKEY
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_PDFFKEY_SO1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_PDFFKEY_SOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_PDFFKEY_ERROR
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_PDFFKEY_ER1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_PDFFKEY_ERR
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_PDFFKEY_NO_PAY
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_PDFFKEY_NO1
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_PDFFKEY_NO
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_PDFFKEY_NO_PAY_ER
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_PDFFKEY_NO3
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_PDFFKEY_NO2
    raising
      CX_AI_SYSTEM_FAULT .
  methods DOWNLOAD_INV_PDFNO_PAY
    importing
      !INPUT type ZEINV_DOWNLOAD_INV_PDFNO_PAY_2
    exporting
      !OUTPUT type ZEINV_DOWNLOAD_INV_PDFNO_PAY_S
    raising
      CX_AI_SYSTEM_FAULT .
protected section.
private section.
ENDCLASS.



CLASS ZEINV_CO_PORTAL_SERVICE_SOAP IMPLEMENTATION.


  method CHANGEPASSWORD.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CHANGEPASSWORD'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONFIRM_SIGANTURE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONFIRM_SIGANTURE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONSTRUCTOR.

  super->constructor(
    class_name          = 'ZEINV_CO_PORTAL_SERVICE_SOAP'
    logical_port_name   = logical_port_name
    destination         = destination
  ).

  endmethod.


  method CONVERT_FOR_STORE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONVERT_FOR_STORE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONVERT_FOR_STORE_BASE64HTML_B.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONVERT_FOR_STORE_BASE64HTML_B'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONVERT_FOR_STORE_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONVERT_FOR_STORE_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONVERT_FOR_STORE_FKEY_PATTERN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONVERT_FOR_STORE_FKEY_PATTERN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONVERT_FOR_VERIFY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONVERT_FOR_VERIFY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONVERT_FOR_VERIFY_BASE64HTML.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONVERT_FOR_VERIFY_BASE64HTML'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONVERT_FOR_VERIFY_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONVERT_FOR_VERIFY_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONVERT_FOR_VERIFY_FKEY_PATTER.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONVERT_FOR_VERIFY_FKEY_PATTER'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_CTTFKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_CTTFKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_CTTTOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_CTTTOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_ERROR.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_ERROR'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_ERROR_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_ERROR_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_ERROR_PDF.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_ERROR_PDF'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_FKEY_NO_PAY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_FKEY_NO_PAY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_NO_PAY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_NO_PAY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_NO_PAY_ERROR.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_NO_PAY_ERROR'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_PDF.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_PDF'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_PDFFKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_PDFFKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_PDFFKEY_ERROR.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_PDFFKEY_ERROR'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_PDFFKEY_NO_PAY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_PDFFKEY_NO_PAY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_PDFFKEY_NO_PAY_ER.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_PDFFKEY_NO_PAY_ER'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_PDFNO_PAY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_PDFNO_PAY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_PDFNO_PAY_ERROR.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_PDFNO_PAY_ERROR'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_ZIP_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_ZIP_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_INV_ZIP_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_INV_ZIP_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DOWNLOAD_NEW_INV_PDFFKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DOWNLOAD_NEW_INV_PDFFKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method FORGETPASS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'FORGETPASS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GETCATALOG_VIEW_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GETCATALOG_VIEW_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_CATALOG_VIEW.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_CATALOG_VIEW'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_CUS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_CUS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_CUS_WITH_BUYER.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_CUS_WITH_BUYER'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_DIGEST.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_DIGEST'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INV_ERROR_VIEW_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INV_ERROR_VIEW_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INV_VIEW.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INV_VIEW'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INV_VIEW_BY_DATE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INV_VIEW_BY_DATE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INV_VIEW_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INV_VIEW_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INV_VIEW_FKEY_BY_STAFF.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INV_VIEW_FKEY_BY_STAFF'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INV_VIEW_FKEY_NO_PAY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INV_VIEW_FKEY_NO_PAY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INV_VIEW_FKEY_NO_PAY_PATTE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INV_VIEW_FKEY_NO_PAY_PATTE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INV_VIEW_NO_PAY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INV_VIEW_NO_PAY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_NEW_INV_VIEW_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_NEW_INV_VIEW_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_STAFF.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_STAFF'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method LIST_COMPANY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'LIST_COMPANY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method LIST_INV_BY_CUS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'LIST_INV_BY_CUS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method LIST_INV_BY_CUS_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'LIST_INV_BY_CUS_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method LIST_INV_BY_CUS_FKEY_VNP.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'LIST_INV_BY_CUS_FKEY_VNP'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method LIST_INV_FROM_NO_TO_NO.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'LIST_INV_FROM_NO_TO_NO'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method LIST_PATTERN_BY_COM.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'LIST_PATTERN_BY_COM'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method LOGINPORTAL.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'LOGINPORTAL'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEARCH_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEARCH_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.
ENDCLASS.
