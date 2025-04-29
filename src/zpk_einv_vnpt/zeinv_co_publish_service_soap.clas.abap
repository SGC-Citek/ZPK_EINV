class ZEINV_CO_PUBLISH_SERVICE_SOAP definition
  public
  inheriting from CL_PROXY_CLIENT
  create public .

public section.

  methods ROL_BACK_WITH_TOKEN
    importing
      !INPUT type ZEINV_ROL_BACK_WITH_TOKEN_SOA1
    exporting
      !OUTPUT type ZEINV_ROL_BACK_WITH_TOKEN_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods RESET_PASSWORD
    importing
      !INPUT type ZEINV_RESET_PASSWORD_SOAP_IN
    exporting
      !OUTPUT type ZEINV_RESET_PASSWORD_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods REMOVE_PUBLISH_INVOICE
    importing
      !INPUT type ZEINV_REMOVE_PUBLISH_INVOICE_1
    exporting
      !OUTPUT type ZEINV_REMOVE_PUBLISH_INVOICE_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods REGISTER_PUBLISH_INVOICE
    importing
      !INPUT type ZEINV_REGISTER_PUBLISH_INVOIC1
    exporting
      !OUTPUT type ZEINV_REGISTER_PUBLISH_INVOICE
    raising
      CX_AI_SYSTEM_FAULT .
  methods REGISTER_PUBLISH_CTT
    importing
      !INPUT type ZEINV_REGISTER_PUBLISH_CTTSOA1
    exporting
      !OUTPUT type ZEINV_REGISTER_PUBLISH_CTTSOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods REGISTER_PUBLISH
    importing
      !INPUT type ZEINV_REGISTER_PUBLISH_SOAP_IN
    exporting
      !OUTPUT type ZEINV_REGISTER_PUBLISH_SOAP_OU
    raising
      CX_AI_SYSTEM_FAULT .
  methods RECEIVED_REGISTER_PUBLISH
    importing
      !INPUT type ZEINV_RECEIVED_REGISTER_PUBLI1
    exporting
      !OUTPUT type ZEINV_RECEIVED_REGISTER_PUBLIS
    raising
      CX_AI_SYSTEM_FAULT .
  methods RECEIVED_INVOICE_ERRORS
    importing
      !INPUT type ZEINV_RECEIVED_INVOICE_ERRORS1
    exporting
      !OUTPUT type ZEINV_RECEIVED_INVOICE_ERRORS
    raising
      CX_AI_SYSTEM_FAULT .
  methods PUBLISH_INV_WITH_TOKEN_MTT
    importing
      !INPUT type ZEINV_PUBLISH_INV_WITH_TOKEN_1
    exporting
      !OUTPUT type ZEINV_PUBLISH_INV_WITH_TOKEN_M
    raising
      CX_AI_SYSTEM_FAULT .
  methods PUBLISH_INV_WITH_TOKEN
    importing
      !INPUT type ZEINV_PUBLISH_INV_WITH_TOKEN_2
    exporting
      !OUTPUT type ZEINV_PUBLISH_INV_WITH_TOKEN_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods PUBLISH_INV_SMART_CAMTT
    importing
      !INPUT type ZEINV_PUBLISH_INV_SMART_CAMTT1
    exporting
      !OUTPUT type ZEINV_PUBLISH_INV_SMART_CAMTTS
    raising
      CX_AI_SYSTEM_FAULT .
  methods PUBLISH_INV_SMART_CA
    importing
      !INPUT type ZEINV_PUBLISH_INV_SMART_CASOA1
    exporting
      !OUTPUT type ZEINV_PUBLISH_INV_SMART_CASOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods PUBLISH_INV_FKEY
    importing
      !INPUT type ZEINV_PUBLISH_INV_FKEY_SOAP_IN
    exporting
      !OUTPUT type ZEINV_PUBLISH_INV_FKEY_SOAP_OU
    raising
      CX_AI_SYSTEM_FAULT .
  methods PUBLISH_INV_BY_DATE
    importing
      !INPUT type ZEINV_PUBLISH_INV_BY_DATE_SOA1
    exporting
      !OUTPUT type ZEINV_PUBLISH_INV_BY_DATE_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods PUBLISH_INV
    importing
      !INPUT type ZEINV_PUBLISH_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_PUBLISH_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods PUBLISH_CTTWITH_TOKEN
    importing
      !INPUT type ZEINV_PUBLISH_CTTWITH_TOKEN_S1
    exporting
      !OUTPUT type ZEINV_PUBLISH_CTTWITH_TOKEN_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods PUBLISH_CTTSMART_CA
    importing
      !INPUT type ZEINV_PUBLISH_CTTSMART_CASOAP1
    exporting
      !OUTPUT type ZEINV_PUBLISH_CTTSMART_CASOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods PRINT_NOTICE_INV_ERROR_CQT
    importing
      !INPUT type ZEINV_PRINT_NOTICE_INV_ERROR_1
    exporting
      !OUTPUT type ZEINV_PRINT_NOTICE_INV_ERROR_C
    raising
      CX_AI_SYSTEM_FAULT .
  methods PRINT_NOTICE_INV_ERROR
    importing
      !INPUT type ZEINV_PRINT_NOTICE_INV_ERROR_2
    exporting
      !OUTPUT type ZEINV_PRINT_NOTICE_INV_ERROR_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods PAYMENT_FOR_VERIFY
    importing
      !INPUT type ZEINV_PAYMENT_FOR_VERIFY_SOAP1
    exporting
      !OUTPUT type ZEINV_PAYMENT_FOR_VERIFY_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_INV_BY_PATTERN_MTT
    importing
      !INPUT type ZEINV_IMPORT_INV_BY_PATTERN_M1
    exporting
      !OUTPUT type ZEINV_IMPORT_INV_BY_PATTERN_MT
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_INV_BY_PATTERN_CTT
    importing
      !INPUT type ZEINV_IMPORT_INV_BY_PATTERN_C1
    exporting
      !OUTPUT type ZEINV_IMPORT_INV_BY_PATTERN_CT
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_INV_BY_PATTERN
    importing
      !INPUT type ZEINV_IMPORT_INV_BY_PATTERN_S1
    exporting
      !OUTPUT type ZEINV_IMPORT_INV_BY_PATTERN_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_INV
    importing
      !INPUT type ZEINV_IMPORT_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_IMPORT_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_AGAIN_EMAIL_SERV
    importing
      !INPUT type ZEINV_SEND_AGAIN_EMAIL_SERV_S1
    exporting
      !OUTPUT type ZEINV_SEND_AGAIN_EMAIL_SERV_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods UPDATE_INVOICE
    importing
      !INPUT type ZEINV_UPDATE_INVOICE_SOAP_IN
    exporting
      !OUTPUT type ZEINV_UPDATE_INVOICE_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods UPDATE_CUS
    importing
      !INPUT type ZEINV_UPDATE_CUS_SOAP_IN
    exporting
      !OUTPUT type ZEINV_UPDATE_CUS_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods UPDATE_CERTIFICATE
    importing
      !INPUT type ZEINV_UPDATE_CERTIFICATE_SOAP1
    exporting
      !OUTPUT type ZEINV_UPDATE_CERTIFICATE_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods SYNC_PUBLISH
    importing
      !INPUT type ZEINV_SYNC_PUBLISH_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SYNC_PUBLISH_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SYNC_INV_CANCEL
    importing
      !INPUT type ZEINV_SYNC_INV_CANCEL_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SYNC_INV_CANCEL_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SYNC_INVOICEV2
    importing
      !INPUT type ZEINV_SYNC_INVOICEV2SOAP_IN
    exporting
      !OUTPUT type ZEINV_SYNC_INVOICEV2SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SYNC_INVOICE
    importing
      !INPUT type ZEINV_SYNC_INVOICE_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SYNC_INVOICE_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SYNC_INFOMATION
    importing
      !INPUT type ZEINV_SYNC_INFOMATION_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SYNC_INFOMATION_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SYNC_DECISION
    importing
      !INPUT type ZEINV_SYNC_DECISION_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SYNC_DECISION_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SYNC_CLIENT_INVOICE_CANCEL
    importing
      !INPUT type ZEINV_SYNC_CLIENT_INVOICE_CAN1
    exporting
      !OUTPUT type ZEINV_SYNC_CLIENT_INVOICE_CANC
    raising
      CX_AI_SYSTEM_FAULT .
  methods SYNC_CLIENT_INV
    importing
      !INPUT type ZEINV_SYNC_CLIENT_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SYNC_CLIENT_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SYNC_CERT
    importing
      !INPUT type ZEINV_SYNC_CERT_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SYNC_CERT_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SIGN_IN
    importing
      !INPUT type ZEINV_SIGN_IN_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SIGN_IN_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SET_CUS_CERT
    importing
      !INPUT type ZEINV_SET_CUS_CERT_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SET_CUS_CERT_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_TO_CQTBY_INV_TOKENS
    importing
      !INPUT type ZEINV_SEND_INV_TO_CQTBY_INV_T1
    exporting
      !OUTPUT type ZEINV_SEND_INV_TO_CQTBY_INV_TO
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_TO_CQTBY_FKEYS
    importing
      !INPUT type ZEINV_SEND_INV_TO_CQTBY_FKEYS1
    exporting
      !OUTPUT type ZEINV_SEND_INV_TO_CQTBY_FKEYS
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_NOTICE_ERRORS_WITH_SM
    importing
      !INPUT type ZEINV_SEND_INV_NOTICE_ERRORS_1
    exporting
      !OUTPUT type ZEINV_SEND_INV_NOTICE_ERRORS_W
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_NOTICE_ERRORS_WIDTH_T
    importing
      !INPUT type ZEINV_SEND_INV_NOTICE_ERRORS_3
    exporting
      !OUTPUT type ZEINV_SEND_INV_NOTICE_ERRORS_2
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_NOTICE_ERRORS
    importing
      !INPUT type ZEINV_SEND_INV_NOTICE_ERRORS_4
    exporting
      !OUTPUT type ZEINV_SEND_INV_NOTICE_ERRORS_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_ERROR_MTTWITH_TOKEN
    importing
      !INPUT type ZEINV_SEND_INV_ERROR_MTTWITH_1
    exporting
      !OUTPUT type ZEINV_SEND_INV_ERROR_MTTWITH_T
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_ERROR_MTTWITH_SMART_C
    importing
      !INPUT type ZEINV_SEND_INV_ERROR_MTTWITH_2
    exporting
      !OUTPUT type ZEINV_SEND_INV_ERROR_MTTWITH_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_ERROR_MTT
    importing
      !INPUT type ZEINV_SEND_INV_ERROR_MTTSOAP_I
    exporting
      !OUTPUT type ZEINV_SEND_INV_ERROR_MTTSOAP_O
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_EMAIL_AGAIN
    importing
      !INPUT type ZEINV_SEND_EMAIL_AGAIN_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SEND_EMAIL_AGAIN_SOAP_OU
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_EMAIL
    importing
      !INPUT type ZEINV_SEND_EMAIL_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SEND_EMAIL_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_CERT_WITH_TOKEN
    importing
      !INPUT type ZEINV_IMPORT_CERT_WITH_TOKEN_1
    exporting
      !OUTPUT type ZEINV_IMPORT_CERT_WITH_TOKEN_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_WITH_TOKEN
    importing
      !INPUT type ZEINV_GET_HASH_INV_WITH_TOKEN1
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_WITH_TOKEN
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_SMART_CAMTT
    importing
      !INPUT type ZEINV_GET_HASH_INV_SMART_CAMT1
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_SMART_CAMTT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_SMART_CA
    importing
      !INPUT type ZEINV_GET_HASH_INV_SMART_CASO1
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_SMART_CASOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_NOTICE_ERRORS_WIT
    importing
      !INPUT type ZEINV_GET_HASH_INV_NOTICE_ERR1
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_NOTICE_ERRO
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_NOTICE_ERRORS
    importing
      !INPUT type ZEINV_GET_HASH_INV_NOTICE_ERR3
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_NOTICE_ERR2
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_ERROR_MTTWITH_TOK
    importing
      !INPUT type ZEINV_GET_HASH_INV_ERROR_MTTW1
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_ERROR_MTTWI
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_ERROR_MTTWITH_SMA
    importing
      !INPUT type ZEINV_GET_HASH_INV_ERROR_MTTW3
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_ERROR_MTTW2
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV
    importing
      !INPUT type ZEINV_GET_HASH_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_CTTWITH_TOKEN
    importing
      !INPUT type ZEINV_GET_HASH_CTTWITH_TOKEN_1
    exporting
      !OUTPUT type ZEINV_GET_HASH_CTTWITH_TOKEN_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_CTTSMART_CA
    importing
      !INPUT type ZEINV_GET_HASH_CTTSMART_CASOA1
    exporting
      !OUTPUT type ZEINV_GET_HASH_CTTSMART_CASOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_DATE_TIME_SERVER
    importing
      !INPUT type ZEINV_GET_DATE_TIME_SERVER_SO1
    exporting
      !OUTPUT type ZEINV_GET_DATE_TIME_SERVER_SOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_DATA_INV_HSM
    importing
      !INPUT type ZEINV_GET_DATA_INV_HSM_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_DATA_INV_HSM_SOAP_OU
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_CURRENT_NO
    importing
      !INPUT type ZEINV_GET_CURRENT_NO_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_CURRENT_NO_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_CERT_INFO
    importing
      !INPUT type ZEINV_GET_CERT_INFO_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_CERT_INFO_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_CERTIFICATES
    importing
      !INPUT type ZEINV_GET_CERTIFICATES_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_CERTIFICATES_SOAP_OU
    raising
      CX_AI_SYSTEM_FAULT .
  methods DELETE_INVOICE_BY_ID
    importing
      !INPUT type ZEINV_DELETE_INVOICE_BY_IDSOA1
    exporting
      !OUTPUT type ZEINV_DELETE_INVOICE_BY_IDSOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods DELETE_INVOICE_BY_FKEY
    importing
      !INPUT type ZEINV_DELETE_INVOICE_BY_FKEY_1
    exporting
      !OUTPUT type ZEINV_DELETE_INVOICE_BY_FKEY_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods DELETE_CERTIFICATE
    importing
      !INPUT type ZEINV_DELETE_CERTIFICATE_SOAP1
    exporting
      !OUTPUT type ZEINV_DELETE_CERTIFICATE_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONVERT_FOR_VERIFY
    importing
      !INPUT type ZEINV_CONVERT_FOR_VERIFY_SOAP1
    exporting
      !OUTPUT type ZEINV_CONVERT_FOR_VERIFY_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONSTRUCTOR
    importing
      !DESTINATION type ref to IF_PROXY_DESTINATION optional
      !LOGICAL_PORT_NAME type PRX_LOGICAL_PORT_NAME optional
    preferred parameter LOGICAL_PORT_NAME
    raising
      CX_AI_SYSTEM_FAULT .
  methods CANCEL_PUBLISH_INVOICE
    importing
      !INPUT type ZEINV_CANCEL_PUBLISH_INVOICE_1
    exporting
      !OUTPUT type ZEINV_CANCEL_PUBLISH_INVOICE_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods CANCEL_INVOICE_WITH_TOKEN
    importing
      !INPUT type ZEINV_CANCEL_INVOICE_WITH_TOK1
    exporting
      !OUTPUT type ZEINV_CANCEL_INVOICE_WITH_TOKE
    raising
      CX_AI_SYSTEM_FAULT .
  methods APP_CLIENT_SYNC_INFO_SYSTEM
    importing
      !INPUT type ZEINV_APP_CLIENT_SYNC_INFO_SY1
    exporting
      !OUTPUT type ZEINV_APP_CLIENT_SYNC_INFO_SYS
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_REPLACE_INV_WITH_TOKEN
    importing
      !INPUT type ZEINV_ADJUST_REPLACE_INV_WITH2
    exporting
      !OUTPUT type ZEINV_ADJUST_REPLACE_INV_WITH3
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_WITH_TOKEN_MTT
    importing
      !INPUT type ZEINV_GET_HASH_INV_WITH_TOKEN3
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_WITH_TOKEN2
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_AND_PUBLISH_INV_SIGN_SE
    importing
      !INPUT type ZEINV_IMPORT_AND_PUBLISH_INV_2
    exporting
      !OUTPUT type ZEINV_IMPORT_AND_PUBLISH_INV_1
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_AND_PUBLISH_INV_MTT32
    importing
      !INPUT type ZEINV_IMPORT_AND_PUBLISH_INV_5
    exporting
      !OUTPUT type ZEINV_IMPORT_AND_PUBLISH_INV_4
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_AND_PUBLISH_INV_MTT
    importing
      !INPUT type ZEINV_IMPORT_AND_PUBLISH_INV_3
    exporting
      !OUTPUT type ZEINV_IMPORT_AND_PUBLISH_INV_M
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_AND_PUBLISH_INV
    importing
      !INPUT type ZEINV_IMPORT_AND_PUBLISH_INV_6
    exporting
      !OUTPUT type ZEINV_IMPORT_AND_PUBLISH_INV_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_AND_PUBLISH_CTT
    importing
      !INPUT type ZEINV_IMPORT_AND_PUBLISH_CTTS1
    exporting
      !OUTPUT type ZEINV_IMPORT_AND_PUBLISH_CTTSO
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_AND_PUBLISH_ASSIGNED_NO
    importing
      !INPUT type ZEINV_IMPORT_AND_PUBLISH_ASSI3
    exporting
      !OUTPUT type ZEINV_IMPORT_AND_PUBLISH_ASSI2
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_AND_PUBLISH_ASSIGNED_N1
    importing
      !INPUT type ZEINV_IMPORT_AND_PUBLISH_ASSI1
    exporting
      !OUTPUT type ZEINV_IMPORT_AND_PUBLISH_ASSIG
    raising
      CX_AI_SYSTEM_FAULT .
  methods HANDLE_INVOICE_ERRORS
    importing
      !INPUT type ZEINV_HANDLE_INVOICE_ERRORS_S1
    exporting
      !OUTPUT type ZEINV_HANDLE_INVOICE_ERRORS_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_TRANSACTION_ITEMS
    importing
      !INPUT type ZEINV_GET_TRANSACTION_ITEMS_S1
    exporting
      !OUTPUT type ZEINV_GET_TRANSACTION_ITEMS_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_TRANSACTION_DETAIL
    importing
      !INPUT type ZEINV_GET_TRANSACTION_DETAIL_1
    exporting
      !OUTPUT type ZEINV_GET_TRANSACTION_DETAIL_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_STEP_DETAIL
    importing
      !INPUT type ZEINV_GET_STEP_DETAIL_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_STEP_DETAIL_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_STATUS_INV
    importing
      !INPUT type ZEINV_GET_STATUS_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_STATUS_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_SINGLE_INVOICE
    importing
      !INPUT type ZEINV_GET_SINGLE_INVOICE_SOAP1
    exporting
      !OUTPUT type ZEINV_GET_SINGLE_INVOICE_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_RESULTS_TRANSACTION
    importing
      !INPUT type ZEINV_GET_RESULTS_TRANSACTION1
    exporting
      !OUTPUT type ZEINV_GET_RESULTS_TRANSACTION
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_PUBLISH_INV
    importing
      !INPUT type ZEINV_GET_PUBLISH_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_PUBLISH_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_MCCQTHUE_FROM_NO_TO_NO
    importing
      !INPUT type ZEINV_GET_MCCQTHUE_FROM_NO_TO1
    exporting
      !OUTPUT type ZEINV_GET_MCCQTHUE_FROM_NO_TO
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_MCCQTHUE_BY_INV_TOKENS_NO
    importing
      !INPUT type ZEINV_GET_MCCQTHUE_BY_INV_TOK3
    exporting
      !OUTPUT type ZEINV_GET_MCCQTHUE_BY_INV_TOK2
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_MCCQTHUE_BY_INV_TOKENS
    importing
      !INPUT type ZEINV_GET_MCCQTHUE_BY_INV_TOK1
    exporting
      !OUTPUT type ZEINV_GET_MCCQTHUE_BY_INV_TOKE
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_MCCQTHUE_BY_FKEYS_NO_XMLSI
    importing
      !INPUT type ZEINV_GET_MCCQTHUE_BY_FKEYS_N1
    exporting
      !OUTPUT type ZEINV_GET_MCCQTHUE_BY_FKEYS_NO
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_MCCQTHUE_BY_FKEYS
    importing
      !INPUT type ZEINV_GET_MCCQTHUE_BY_FKEYS_S1
    exporting
      !OUTPUT type ZEINV_GET_MCCQTHUE_BY_FKEYS_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_IN_FOR_PUBLISH_COM
    importing
      !INPUT type ZEINV_GET_IN_FOR_PUBLISH_COM_1
    exporting
      !OUTPUT type ZEINV_GET_IN_FOR_PUBLISH_COM_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INV_DATA_BY_FKEY
    importing
      !INPUT type ZEINV_GET_INV_DATA_BY_FKEY_SO1
    exporting
      !OUTPUT type ZEINV_GET_INV_DATA_BY_FKEY_SOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INVOICE_BY_FKEYS
    importing
      !INPUT type ZEINV_GET_INVOICE_BY_FKEYS_SO1
    exporting
      !OUTPUT type ZEINV_GET_INVOICE_BY_FKEYS_SOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INVOICE_BY_FKEY
    importing
      !INPUT type ZEINV_GET_INVOICE_BY_FKEY_SOA1
    exporting
      !OUTPUT type ZEINV_GET_INVOICE_BY_FKEY_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
protected section.
private section.
ENDCLASS.



CLASS ZEINV_CO_PUBLISH_SERVICE_SOAP IMPLEMENTATION.


  method ADJUST_REPLACE_INV_WITH_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_REPLACE_INV_WITH_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method APP_CLIENT_SYNC_INFO_SYSTEM.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'APP_CLIENT_SYNC_INFO_SYSTEM'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CANCEL_INVOICE_WITH_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CANCEL_INVOICE_WITH_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CANCEL_PUBLISH_INVOICE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CANCEL_PUBLISH_INVOICE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONSTRUCTOR.

  super->constructor(
    class_name          = 'ZEINV_CO_PUBLISH_SERVICE_SOAP'
    logical_port_name   = logical_port_name
    destination         = destination
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


  method DELETE_CERTIFICATE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DELETE_CERTIFICATE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DELETE_INVOICE_BY_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DELETE_INVOICE_BY_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DELETE_INVOICE_BY_ID.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DELETE_INVOICE_BY_ID'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_CERTIFICATES.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_CERTIFICATES'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_CERT_INFO.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_CERT_INFO'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_CURRENT_NO.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_CURRENT_NO'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_DATA_INV_HSM.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_DATA_INV_HSM'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_DATE_TIME_SERVER.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_DATE_TIME_SERVER'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_CTTSMART_CA.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_CTTSMART_CA'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_CTTWITH_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_CTTWITH_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_ERROR_MTTWITH_SMA.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_ERROR_MTTWITH_SMA'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_ERROR_MTTWITH_TOK.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_ERROR_MTTWITH_TOK'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_NOTICE_ERRORS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_NOTICE_ERRORS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_NOTICE_ERRORS_WIT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_NOTICE_ERRORS_WIT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_SMART_CA.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_SMART_CA'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_SMART_CAMTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_SMART_CAMTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_WITH_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_WITH_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_WITH_TOKEN_MTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_WITH_TOKEN_MTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INVOICE_BY_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INVOICE_BY_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INVOICE_BY_FKEYS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INVOICE_BY_FKEYS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INV_DATA_BY_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INV_DATA_BY_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_IN_FOR_PUBLISH_COM.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_IN_FOR_PUBLISH_COM'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_MCCQTHUE_BY_FKEYS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_MCCQTHUE_BY_FKEYS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_MCCQTHUE_BY_FKEYS_NO_XMLSI.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_MCCQTHUE_BY_FKEYS_NO_XMLSI'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_MCCQTHUE_BY_INV_TOKENS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_MCCQTHUE_BY_INV_TOKENS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_MCCQTHUE_BY_INV_TOKENS_NO.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_MCCQTHUE_BY_INV_TOKENS_NO'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_MCCQTHUE_FROM_NO_TO_NO.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_MCCQTHUE_FROM_NO_TO_NO'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_PUBLISH_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_PUBLISH_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_RESULTS_TRANSACTION.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_RESULTS_TRANSACTION'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_SINGLE_INVOICE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_SINGLE_INVOICE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_STATUS_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_STATUS_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_STEP_DETAIL.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_STEP_DETAIL'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_TRANSACTION_DETAIL.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_TRANSACTION_DETAIL'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_TRANSACTION_ITEMS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_TRANSACTION_ITEMS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method HANDLE_INVOICE_ERRORS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'HANDLE_INVOICE_ERRORS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_AND_PUBLISH_ASSIGNED_N1.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_AND_PUBLISH_ASSIGNED_N1'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_AND_PUBLISH_ASSIGNED_NO.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_AND_PUBLISH_ASSIGNED_NO'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_AND_PUBLISH_CTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_AND_PUBLISH_CTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_AND_PUBLISH_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_AND_PUBLISH_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_AND_PUBLISH_INV_MTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_AND_PUBLISH_INV_MTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_AND_PUBLISH_INV_MTT32.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_AND_PUBLISH_INV_MTT32'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_AND_PUBLISH_INV_SIGN_SE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_AND_PUBLISH_INV_SIGN_SE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_CERT_WITH_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_CERT_WITH_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_INV_BY_PATTERN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_INV_BY_PATTERN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_INV_BY_PATTERN_CTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_INV_BY_PATTERN_CTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_INV_BY_PATTERN_MTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_INV_BY_PATTERN_MTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PAYMENT_FOR_VERIFY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PAYMENT_FOR_VERIFY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PRINT_NOTICE_INV_ERROR.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PRINT_NOTICE_INV_ERROR'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PRINT_NOTICE_INV_ERROR_CQT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PRINT_NOTICE_INV_ERROR_CQT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PUBLISH_CTTSMART_CA.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PUBLISH_CTTSMART_CA'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PUBLISH_CTTWITH_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PUBLISH_CTTWITH_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PUBLISH_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PUBLISH_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PUBLISH_INV_BY_DATE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PUBLISH_INV_BY_DATE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PUBLISH_INV_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PUBLISH_INV_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PUBLISH_INV_SMART_CA.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PUBLISH_INV_SMART_CA'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PUBLISH_INV_SMART_CAMTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PUBLISH_INV_SMART_CAMTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PUBLISH_INV_WITH_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PUBLISH_INV_WITH_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method PUBLISH_INV_WITH_TOKEN_MTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'PUBLISH_INV_WITH_TOKEN_MTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method RECEIVED_INVOICE_ERRORS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'RECEIVED_INVOICE_ERRORS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method RECEIVED_REGISTER_PUBLISH.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'RECEIVED_REGISTER_PUBLISH'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REGISTER_PUBLISH.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REGISTER_PUBLISH'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REGISTER_PUBLISH_CTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REGISTER_PUBLISH_CTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REGISTER_PUBLISH_INVOICE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REGISTER_PUBLISH_INVOICE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REMOVE_PUBLISH_INVOICE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REMOVE_PUBLISH_INVOICE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method RESET_PASSWORD.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'RESET_PASSWORD'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ROL_BACK_WITH_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ROL_BACK_WITH_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_AGAIN_EMAIL_SERV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_AGAIN_EMAIL_SERV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_EMAIL.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_EMAIL'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_EMAIL_AGAIN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_EMAIL_AGAIN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_ERROR_MTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_ERROR_MTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_ERROR_MTTWITH_SMART_C.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_ERROR_MTTWITH_SMART_C'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_ERROR_MTTWITH_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_ERROR_MTTWITH_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_NOTICE_ERRORS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_NOTICE_ERRORS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_NOTICE_ERRORS_WIDTH_T.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_NOTICE_ERRORS_WIDTH_T'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_NOTICE_ERRORS_WITH_SM.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_NOTICE_ERRORS_WITH_SM'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_TO_CQTBY_FKEYS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_TO_CQTBY_FKEYS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_TO_CQTBY_INV_TOKENS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_TO_CQTBY_INV_TOKENS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SET_CUS_CERT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SET_CUS_CERT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SIGN_IN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SIGN_IN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SYNC_CERT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SYNC_CERT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SYNC_CLIENT_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SYNC_CLIENT_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SYNC_CLIENT_INVOICE_CANCEL.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SYNC_CLIENT_INVOICE_CANCEL'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SYNC_DECISION.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SYNC_DECISION'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SYNC_INFOMATION.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SYNC_INFOMATION'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SYNC_INVOICE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SYNC_INVOICE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SYNC_INVOICEV2.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SYNC_INVOICEV2'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SYNC_INV_CANCEL.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SYNC_INV_CANCEL'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SYNC_PUBLISH.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SYNC_PUBLISH'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method UPDATE_CERTIFICATE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'UPDATE_CERTIFICATE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method UPDATE_CUS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'UPDATE_CUS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method UPDATE_INVOICE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'UPDATE_INVOICE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.
ENDCLASS.
