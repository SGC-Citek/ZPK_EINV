class ZEINV_CO_BUSINESS_SERVICE_SOAP definition
  public
  inheriting from CL_PROXY_CLIENT
  create public .

public section.

  methods REPLACE_WITHOUT_INV
    importing
      !INPUT type ZEINV_REPLACE_WITHOUT_INV_SOA1
    exporting
      !OUTPUT type ZEINV_REPLACE_WITHOUT_INV_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_INV_MTT
    importing
      !INPUT type ZEINV_REPLACE_INV_MTTSOAP_IN
    exporting
      !OUTPUT type ZEINV_REPLACE_INV_MTTSOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_INVOICE_NO_PUBLISH_EXT
    importing
      !INPUT type ZEINV_REPLACE_INVOICE_NO_PUBL3
    exporting
      !OUTPUT type ZEINV_REPLACE_INVOICE_NO_PUBL2
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_INVOICE_NO_PUBLISH
    importing
      !INPUT type ZEINV_REPLACE_INVOICE_NO_PUBL1
    exporting
      !OUTPUT type ZEINV_REPLACE_INVOICE_NO_PUBLI
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_INVOICE_NEW_PATTERN
    importing
      !INPUT type ZEINV_REPLACE_INVOICE_NEW_PAT1
    exporting
      !OUTPUT type ZEINV_REPLACE_INVOICE_NEW_PATT
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_INVOICE_ACTION
    importing
      !INPUT type ZEINV_REPLACE_INVOICE_ACTION_1
    exporting
      !OUTPUT type ZEINV_REPLACE_INVOICE_ACTION_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_INVOICE
    importing
      !INPUT type ZEINV_REPLACE_INVOICE_SOAP_IN
    exporting
      !OUTPUT type ZEINV_REPLACE_INVOICE_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_INV
    importing
      !INPUT type ZEINV_REPLACE_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_REPLACE_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_CTTACTION
    importing
      !INPUT type ZEINV_REPLACE_CTTACTION_SOAP_I
    exporting
      !OUTPUT type ZEINV_REPLACE_CTTACTION_SOAP_O
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_ASSIGNED_NO_NEW_PATTER
    importing
      !INPUT type ZEINV_REPLACE_ASSIGNED_NO_NEW1
    exporting
      !OUTPUT type ZEINV_REPLACE_ASSIGNED_NO_NEW
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_ACTION_ASSIGNED_NO_MTT
    importing
      !INPUT type ZEINV_REPLACE_ACTION_ASSIGNED3
    exporting
      !OUTPUT type ZEINV_REPLACE_ACTION_ASSIGNED2
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_ACTION_ASSIGNED_NO
    importing
      !INPUT type ZEINV_REPLACE_ACTION_ASSIGNED1
    exporting
      !OUTPUT type ZEINV_REPLACE_ACTION_ASSIGNED
    raising
      CX_AI_SYSTEM_FAULT .
  methods POOLING_INV
    importing
      !INPUT type ZEINV_POOLING_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_POOLING_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods MESSAGE_RECEIVED
    importing
      !INPUT type ZEINV_MESSAGE_RECEIVED_SOAP_IN
    exporting
      !OUTPUT type ZEINV_MESSAGE_RECEIVED_SOAP_OU
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_ATTACHMENT_BY_NO
    importing
      !INPUT type ZEINV_IMPORT_ATTACHMENT_BY_NO1
    exporting
      !OUTPUT type ZEINV_IMPORT_ATTACHMENT_BY_NO
    raising
      CX_AI_SYSTEM_FAULT .
  methods IMPORT_ATTACHMENT_BY_FKEY
    importing
      !INPUT type ZEINV_IMPORT_ATTACHMENT_BY_FK1
    exporting
      !OUTPUT type ZEINV_IMPORT_ATTACHMENT_BY_FKE
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_SERIAL_BY_PATTERN
    importing
      !INPUT type ZEINV_GET_SERIAL_BY_PATTERN_S1
    exporting
      !OUTPUT type ZEINV_GET_SERIAL_BY_PATTERN_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_PUBLISH_INVS
    importing
      !INPUT type ZEINV_GET_PUBLISH_INVS_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_PUBLISH_INVS_SOAP_OU
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_INVBY_FKEY
    importing
      !INPUT type ZEINV_GET_INVBY_FKEY_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_INVBY_FKEY_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_WITH_OUT_INV_TOKEN
    importing
      !INPUT type ZEINV_GET_HASH_WITH_OUT_INV_T1
    exporting
      !OUTPUT type ZEINV_GET_HASH_WITH_OUT_INV_TO
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_WITH_OUT_INV_SMART_CA
    importing
      !INPUT type ZEINV_GET_HASH_WITH_OUT_INV_S1
    exporting
      !OUTPUT type ZEINV_GET_HASH_WITH_OUT_INV_SM
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_MTTNO_RANGE_BY_TO
    importing
      !INPUT type ZEINV_GET_HASH_INV_MTTNO_RANG1
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_MTTNO_RANGE
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_MTTNO_RANGE_BY_SM
    importing
      !INPUT type ZEINV_GET_HASH_INV_MTTNO_RANG3
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_MTTNO_RANG2
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPLACE_WITHOUT_INV_MTT
    importing
      !INPUT type ZEINV_REPLACE_WITHOUT_INV_MTT1
    exporting
      !OUTPUT type ZEINV_REPLACE_WITHOUT_INV_MTTS
    raising
      CX_AI_SYSTEM_FAULT .
  methods UPDATE_SSTAFF_ACCOUNT
    importing
      !INPUT type ZEINV_UPDATE_SSTAFF_ACCOUNT_S1
    exporting
      !OUTPUT type ZEINV_UPDATE_SSTAFF_ACCOUNT_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods UN_CONFIRM_PAYMENT_FKEY_VNP
    importing
      !INPUT type ZEINV_UN_CONFIRM_PAYMENT_FKEY1
    exporting
      !OUTPUT type ZEINV_UN_CONFIRM_PAYMENT_FKEY
    raising
      CX_AI_SYSTEM_FAULT .
  methods UN_CONFIRM_PAYMENT_FKEY_PATTER
    importing
      !INPUT type ZEINV_UN_CONFIRM_PAYMENT_FKEY5
    exporting
      !OUTPUT type ZEINV_UN_CONFIRM_PAYMENT_FKEY4
    raising
      CX_AI_SYSTEM_FAULT .
  methods UN_CONFIRM_PAYMENT_FKEY
    importing
      !INPUT type ZEINV_UN_CONFIRM_PAYMENT_FKEY3
    exporting
      !OUTPUT type ZEINV_UN_CONFIRM_PAYMENT_FKEY2
    raising
      CX_AI_SYSTEM_FAULT .
  methods UN_CONFIRM_PAYMENT
    importing
      !INPUT type ZEINV_UN_CONFIRM_PAYMENT_SOAP1
    exporting
      !OUTPUT type ZEINV_UN_CONFIRM_PAYMENT_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods UNCONFIRM_PAYMENT_DETAIL_FKEY
    importing
      !INPUT type ZEINV_UNCONFIRM_PAYMENT_DETAI1
    exporting
      !OUTPUT type ZEINV_UNCONFIRM_PAYMENT_DETAIL
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_MTTNO_RANGE_BY_TOKEN
    importing
      !INPUT type ZEINV_SEND_INV_MTTNO_RANGE_BY1
    exporting
      !OUTPUT type ZEINV_SEND_INV_MTTNO_RANGE_BY
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_MTTNO_RANGE_BY_SMART
    importing
      !INPUT type ZEINV_SEND_INV_MTTNO_RANGE_BY3
    exporting
      !OUTPUT type ZEINV_SEND_INV_MTTNO_RANGE_BY2
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_MTTNO_RANGE
    importing
      !INPUT type ZEINV_SEND_INV_MTTNO_RANGE_SO1
    exporting
      !OUTPUT type ZEINV_SEND_INV_MTTNO_RANGE_SOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_MTTINV_TOKEN_BY_TOKEN
    importing
      !INPUT type ZEINV_SEND_INV_MTTINV_TOKEN_B1
    exporting
      !OUTPUT type ZEINV_SEND_INV_MTTINV_TOKEN_BY
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_MTTINV_TOKEN_BY_SMART
    importing
      !INPUT type ZEINV_SEND_INV_MTTINV_TOKEN_B3
    exporting
      !OUTPUT type ZEINV_SEND_INV_MTTINV_TOKEN_B2
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_MTTINV_TOKEN
    importing
      !INPUT type ZEINV_SEND_INV_MTTINV_TOKEN_S1
    exporting
      !OUTPUT type ZEINV_SEND_INV_MTTINV_TOKEN_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_MTTFKEY_BY_TOKEN
    importing
      !INPUT type ZEINV_SEND_INV_MTTFKEY_BY_TOK1
    exporting
      !OUTPUT type ZEINV_SEND_INV_MTTFKEY_BY_TOKE
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_MTTFKEY_BY_SMART_CA
    importing
      !INPUT type ZEINV_SEND_INV_MTTFKEY_BY_SMA1
    exporting
      !OUTPUT type ZEINV_SEND_INV_MTTFKEY_BY_SMAR
    raising
      CX_AI_SYSTEM_FAULT .
  methods SEND_INV_MTTFKEY
    importing
      !INPUT type ZEINV_SEND_INV_MTTFKEY_SOAP_IN
    exporting
      !OUTPUT type ZEINV_SEND_INV_MTTFKEY_SOAP_OU
    raising
      CX_AI_SYSTEM_FAULT .
  methods RETRY_SEND_INV
    importing
      !INPUT type ZEINV_RETRY_SEND_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_RETRY_SEND_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods RESTORE_REPLACED_INV_TOKEN
    importing
      !INPUT type ZEINV_RESTORE_REPLACED_INV_TO1
    exporting
      !OUTPUT type ZEINV_RESTORE_REPLACED_INV_TOK
    raising
      CX_AI_SYSTEM_FAULT .
  methods RESTORE_REPLACED_INV_FKEY
    importing
      !INPUT type ZEINV_RESTORE_REPLACED_INV_FK1
    exporting
      !OUTPUT type ZEINV_RESTORE_REPLACED_INV_FKE
    raising
      CX_AI_SYSTEM_FAULT .
  methods RESTORE_CANCEL_INV_TOKEN
    importing
      !INPUT type ZEINV_RESTORE_CANCEL_INV_TOKE1
    exporting
      !OUTPUT type ZEINV_RESTORE_CANCEL_INV_TOKEN
    raising
      CX_AI_SYSTEM_FAULT .
  methods RESTORE_CANCEL_INV_FKEY
    importing
      !INPUT type ZEINV_RESTORE_CANCEL_INV_FKEY1
    exporting
      !OUTPUT type ZEINV_RESTORE_CANCEL_INV_FKEY
    raising
      CX_AI_SYSTEM_FAULT .
  methods RESET_TEM
    importing
      !INPUT type ZEINV_RESET_TEM_SOAP_IN
    exporting
      !OUTPUT type ZEINV_RESET_TEM_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPORT_MONTH
    importing
      !INPUT type ZEINV_REPORT_MONTH_SOAP_IN
    exporting
      !OUTPUT type ZEINV_REPORT_MONTH_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods REPORT_INV_USED
    importing
      !INPUT type ZEINV_REPORT_INV_USED_SOAP_IN
    exporting
      !OUTPUT type ZEINV_REPORT_INV_USED_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods CANCEL_INV_CTT
    importing
      !INPUT type ZEINV_CANCEL_INV_CTTSOAP_IN
    exporting
      !OUTPUT type ZEINV_CANCEL_INV_CTTSOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods CANCEL_INV
    importing
      !INPUT type ZEINV_CANCEL_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_CANCEL_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_WITHOUT_INV_MTT
    importing
      !INPUT type ZEINV_ADJUST_WITHOUT_INV_MTTS1
    exporting
      !OUTPUT type ZEINV_ADJUST_WITHOUT_INV_MTTSO
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_WITHOUT_INV
    importing
      !INPUT type ZEINV_ADJUST_WITHOUT_INV_SOAP1
    exporting
      !OUTPUT type ZEINV_ADJUST_WITHOUT_INV_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_REPLACE_WITH_OUT_INV_TO
    importing
      !INPUT type ZEINV_ADJUST_REPLACE_WITH_OUT1
    exporting
      !OUTPUT type ZEINV_ADJUST_REPLACE_WITH_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_REPLACE_WITH_OUT_INV_SM
    importing
      !INPUT type ZEINV_ADJUST_REPLACE_WITH_OUT3
    exporting
      !OUTPUT type ZEINV_ADJUST_REPLACE_WITH_OUT2
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_REPLACE_INV_WITH_TOKEN
    importing
      !INPUT type ZEINV_ADJUST_REPLACE_INV_WITH1
    exporting
      !OUTPUT type ZEINV_ADJUST_REPLACE_INV_WITH
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_REPLACE_INV_SMART_CAMTT
    importing
      !INPUT type ZEINV_ADJUST_REPLACE_INV_SMAR3
    exporting
      !OUTPUT type ZEINV_ADJUST_REPLACE_INV_SMAR2
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_REPLACE_INV_SMART_CA
    importing
      !INPUT type ZEINV_ADJUST_REPLACE_INV_SMAR1
    exporting
      !OUTPUT type ZEINV_ADJUST_REPLACE_INV_SMART
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_REPLACE_CTTTOKEN
    importing
      !INPUT type ZEINV_ADJUST_REPLACE_CTTTOKEN1
    exporting
      !OUTPUT type ZEINV_ADJUST_REPLACE_CTTTOKEN
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_REPLACE_CTTSMART_CA
    importing
      !INPUT type ZEINV_ADJUST_REPLACE_CTTSMART1
    exporting
      !OUTPUT type ZEINV_ADJUST_REPLACE_CTTSMART
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_INV_MTT
    importing
      !INPUT type ZEINV_ADJUST_INV_MTTSOAP_IN
    exporting
      !OUTPUT type ZEINV_ADJUST_INV_MTTSOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_INVOICE_NO_PUBLISH_EXTE
    importing
      !INPUT type ZEINV_ADJUST_INVOICE_NO_PUBLI3
    exporting
      !OUTPUT type ZEINV_ADJUST_INVOICE_NO_PUBLI2
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_INVOICE_NO_PUBLISH
    importing
      !INPUT type ZEINV_ADJUST_INVOICE_NO_PUBLI1
    exporting
      !OUTPUT type ZEINV_ADJUST_INVOICE_NO_PUBLIS
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_INVOICE_NOTE
    importing
      !INPUT type ZEINV_ADJUST_INVOICE_NOTE_SOA1
    exporting
      !OUTPUT type ZEINV_ADJUST_INVOICE_NOTE_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_INVOICE_NEW_PATTERN
    importing
      !INPUT type ZEINV_ADJUST_INVOICE_NEW_PATT1
    exporting
      !OUTPUT type ZEINV_ADJUST_INVOICE_NEW_PATTE
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_INVOICE_MULTI
    importing
      !INPUT type ZEINV_ADJUST_INVOICE_MULTI_SO1
    exporting
      !OUTPUT type ZEINV_ADJUST_INVOICE_MULTI_SOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_INVOICE_ACTION
    importing
      !INPUT type ZEINV_ADJUST_INVOICE_ACTION_S1
    exporting
      !OUTPUT type ZEINV_ADJUST_INVOICE_ACTION_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_INVOICE
    importing
      !INPUT type ZEINV_ADJUST_INVOICE_SOAP_IN
    exporting
      !OUTPUT type ZEINV_ADJUST_INVOICE_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_INV
    importing
      !INPUT type ZEINV_ADJUST_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_ADJUST_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_ASSIGNED_NO_NEW_PATTERN
    importing
      !INPUT type ZEINV_ADJUST_ASSIGNED_NO_NEW_1
    exporting
      !OUTPUT type ZEINV_ADJUST_ASSIGNED_NO_NEW_P
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_ACTION_ASSIGNED_NO_MTT
    importing
      !INPUT type ZEINV_ADJUST_ACTION_ASSIGNED_3
    exporting
      !OUTPUT type ZEINV_ADJUST_ACTION_ASSIGNED_2
    raising
      CX_AI_SYSTEM_FAULT .
  methods ADJUST_ACTION_ASSIGNED_NO
    importing
      !INPUT type ZEINV_ADJUST_ACTION_ASSIGNED_1
    exporting
      !OUTPUT type ZEINV_ADJUST_ACTION_ASSIGNED_N
    raising
      CX_AI_SYSTEM_FAULT .
  methods CANCEL_INV_DETAIL_FKEY
    importing
      !INPUT type ZEINV_CANCEL_INV_DETAIL_FKEY_1
    exporting
      !OUTPUT type ZEINV_CANCEL_INV_DETAIL_FKEY_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_MTTINV_TOKEN_BY_T
    importing
      !INPUT type ZEINV_GET_HASH_INV_MTTINV_TOK1
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_MTTINV_TOKE
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_MTTINV_TOKEN_BY_S
    importing
      !INPUT type ZEINV_GET_HASH_INV_MTTINV_TOK3
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_MTTINV_TOK2
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_MTTFKEY_BY_TOKEN
    importing
      !INPUT type ZEINV_GET_HASH_INV_MTTFKEY_BY1
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_MTTFKEY_BY
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_INV_MTTFKEY_BY_SMART
    importing
      !INPUT type ZEINV_GET_HASH_INV_MTTFKEY_BY3
    exporting
      !OUTPUT type ZEINV_GET_HASH_INV_MTTFKEY_BY2
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_CTTTOKEN_REPLACE
    importing
      !INPUT type ZEINV_GET_HASH_CTTTOKEN_REPLA1
    exporting
      !OUTPUT type ZEINV_GET_HASH_CTTTOKEN_REPLAC
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_HASH_CTTSMART_CAREPLACE
    importing
      !INPUT type ZEINV_GET_HASH_CTTSMART_CAREP1
    exporting
      !OUTPUT type ZEINV_GET_HASH_CTTSMART_CAREPL
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_FILE
    importing
      !INPUT type ZEINV_GET_FILE_SOAP_IN
    exporting
      !OUTPUT type ZEINV_GET_FILE_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_COMPANY_CONFIG
    importing
      !INPUT type ZEINV_GET_COMPANY_CONFIG_SOAP1
    exporting
      !OUTPUT type ZEINV_GET_COMPANY_CONFIG_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods GET_ALL_ROLESBY_ACC
    importing
      !INPUT type ZEINV_GET_ALL_ROLESBY_ACC_SOA1
    exporting
      !OUTPUT type ZEINV_GET_ALL_ROLESBY_ACC_SOAP
    raising
      CX_AI_SYSTEM_FAULT .
  methods DELIVER_INV_FKEY
    importing
      !INPUT type ZEINV_DELIVER_INV_FKEY_SOAP_IN
    exporting
      !OUTPUT type ZEINV_DELIVER_INV_FKEY_SOAP_OU
    raising
      CX_AI_SYSTEM_FAULT .
  methods DELIVER_INV
    importing
      !INPUT type ZEINV_DELIVER_INV_SOAP_IN
    exporting
      !OUTPUT type ZEINV_DELIVER_INV_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods CREATE_SSTAFF_ACCOUNT
    importing
      !INPUT type ZEINV_CREATE_SSTAFF_ACCOUNT_S1
    exporting
      !OUTPUT type ZEINV_CREATE_SSTAFF_ACCOUNT_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods CREATE_NEW_USERBY_ACC
    importing
      !INPUT type ZEINV_CREATE_NEW_USERBY_ACC_S1
    exporting
      !OUTPUT type ZEINV_CREATE_NEW_USERBY_ACC_SO
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONSTRUCTOR
    importing
      !DESTINATION type ref to IF_PROXY_DESTINATION optional
      !LOGICAL_PORT_NAME type PRX_LOGICAL_PORT_NAME optional
    preferred parameter LOGICAL_PORT_NAME
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONFIRM_PAYMENT_FKEY_VNP
    importing
      !INPUT type ZEINV_CONFIRM_PAYMENT_FKEY_VN1
    exporting
      !OUTPUT type ZEINV_CONFIRM_PAYMENT_FKEY_VNP
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONFIRM_PAYMENT_FKEY_PATTERN
    importing
      !INPUT type ZEINV_CONFIRM_PAYMENT_FKEY_PA1
    exporting
      !OUTPUT type ZEINV_CONFIRM_PAYMENT_FKEY_PAT
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONFIRM_PAYMENT_FKEY
    importing
      !INPUT type ZEINV_CONFIRM_PAYMENT_FKEY_SO1
    exporting
      !OUTPUT type ZEINV_CONFIRM_PAYMENT_FKEY_SOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONFIRM_PAYMENT_DETAIL_FKEY
    importing
      !INPUT type ZEINV_CONFIRM_PAYMENT_DETAIL_1
    exporting
      !OUTPUT type ZEINV_CONFIRM_PAYMENT_DETAIL_F
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONFIRM_PAYMENT_DETAIL
    importing
      !INPUT type ZEINV_CONFIRM_PAYMENT_DETAIL_2
    exporting
      !OUTPUT type ZEINV_CONFIRM_PAYMENT_DETAIL_S
    raising
      CX_AI_SYSTEM_FAULT .
  methods CONFIRM_PAYMENT
    importing
      !INPUT type ZEINV_CONFIRM_PAYMENT_SOAP_IN
    exporting
      !OUTPUT type ZEINV_CONFIRM_PAYMENT_SOAP_OUT
    raising
      CX_AI_SYSTEM_FAULT .
  methods CANCEL_INV_SIGN_FILE_NO_PAY
    importing
      !INPUT type ZEINV_CANCEL_INV_SIGN_FILE_NO1
    exporting
      !OUTPUT type ZEINV_CANCEL_INV_SIGN_FILE_NO
    raising
      CX_AI_SYSTEM_FAULT .
  methods CANCEL_INV_SIGN_FILE
    importing
      !INPUT type ZEINV_CANCEL_INV_SIGN_FILE_SO1
    exporting
      !OUTPUT type ZEINV_CANCEL_INV_SIGN_FILE_SOA
    raising
      CX_AI_SYSTEM_FAULT .
  methods CANCEL_INV_NO_PAY
    importing
      !INPUT type ZEINV_CANCEL_INV_NO_PAY_SOAP_I
    exporting
      !OUTPUT type ZEINV_CANCEL_INV_NO_PAY_SOAP_O
    raising
      CX_AI_SYSTEM_FAULT .
protected section.
private section.
ENDCLASS.



CLASS ZEINV_CO_BUSINESS_SERVICE_SOAP IMPLEMENTATION.


  method ADJUST_ACTION_ASSIGNED_NO.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_ACTION_ASSIGNED_NO'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_ACTION_ASSIGNED_NO_MTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_ACTION_ASSIGNED_NO_MTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_ASSIGNED_NO_NEW_PATTERN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_ASSIGNED_NO_NEW_PATTERN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_INVOICE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_INVOICE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_INVOICE_ACTION.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_INVOICE_ACTION'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_INVOICE_MULTI.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_INVOICE_MULTI'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_INVOICE_NEW_PATTERN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_INVOICE_NEW_PATTERN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_INVOICE_NOTE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_INVOICE_NOTE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_INVOICE_NO_PUBLISH.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_INVOICE_NO_PUBLISH'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_INVOICE_NO_PUBLISH_EXTE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_INVOICE_NO_PUBLISH_EXTE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_INV_MTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_INV_MTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_REPLACE_CTTSMART_CA.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_REPLACE_CTTSMART_CA'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_REPLACE_CTTTOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_REPLACE_CTTTOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_REPLACE_INV_SMART_CA.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_REPLACE_INV_SMART_CA'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_REPLACE_INV_SMART_CAMTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_REPLACE_INV_SMART_CAMTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


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


  method ADJUST_REPLACE_WITH_OUT_INV_SM.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_REPLACE_WITH_OUT_INV_SM'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_REPLACE_WITH_OUT_INV_TO.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_REPLACE_WITH_OUT_INV_TO'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_WITHOUT_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_WITHOUT_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method ADJUST_WITHOUT_INV_MTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'ADJUST_WITHOUT_INV_MTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CANCEL_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CANCEL_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CANCEL_INV_CTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CANCEL_INV_CTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CANCEL_INV_DETAIL_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CANCEL_INV_DETAIL_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CANCEL_INV_NO_PAY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CANCEL_INV_NO_PAY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CANCEL_INV_SIGN_FILE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CANCEL_INV_SIGN_FILE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CANCEL_INV_SIGN_FILE_NO_PAY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CANCEL_INV_SIGN_FILE_NO_PAY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONFIRM_PAYMENT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONFIRM_PAYMENT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONFIRM_PAYMENT_DETAIL.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONFIRM_PAYMENT_DETAIL'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONFIRM_PAYMENT_DETAIL_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONFIRM_PAYMENT_DETAIL_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONFIRM_PAYMENT_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONFIRM_PAYMENT_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONFIRM_PAYMENT_FKEY_PATTERN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONFIRM_PAYMENT_FKEY_PATTERN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONFIRM_PAYMENT_FKEY_VNP.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CONFIRM_PAYMENT_FKEY_VNP'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CONSTRUCTOR.

  super->constructor(
    class_name          = 'ZEINV_CO_BUSINESS_SERVICE_SOAP'
    logical_port_name   = logical_port_name
    destination         = destination
  ).

  endmethod.


  method CREATE_NEW_USERBY_ACC.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CREATE_NEW_USERBY_ACC'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method CREATE_SSTAFF_ACCOUNT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'CREATE_SSTAFF_ACCOUNT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DELIVER_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DELIVER_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method DELIVER_INV_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'DELIVER_INV_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_ALL_ROLESBY_ACC.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_ALL_ROLESBY_ACC'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_COMPANY_CONFIG.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_COMPANY_CONFIG'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_FILE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_FILE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_CTTSMART_CAREPLACE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_CTTSMART_CAREPLACE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_CTTTOKEN_REPLACE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_CTTTOKEN_REPLACE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_MTTFKEY_BY_SMART.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_MTTFKEY_BY_SMART'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_MTTFKEY_BY_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_MTTFKEY_BY_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_MTTINV_TOKEN_BY_S.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_MTTINV_TOKEN_BY_S'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_MTTINV_TOKEN_BY_T.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_MTTINV_TOKEN_BY_T'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_MTTNO_RANGE_BY_SM.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_MTTNO_RANGE_BY_SM'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_INV_MTTNO_RANGE_BY_TO.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_INV_MTTNO_RANGE_BY_TO'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_WITH_OUT_INV_SMART_CA.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_WITH_OUT_INV_SMART_CA'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_HASH_WITH_OUT_INV_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_HASH_WITH_OUT_INV_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_INVBY_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_INVBY_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_PUBLISH_INVS.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_PUBLISH_INVS'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method GET_SERIAL_BY_PATTERN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'GET_SERIAL_BY_PATTERN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_ATTACHMENT_BY_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_ATTACHMENT_BY_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method IMPORT_ATTACHMENT_BY_NO.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'IMPORT_ATTACHMENT_BY_NO'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method MESSAGE_RECEIVED.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'MESSAGE_RECEIVED'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method POOLING_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'POOLING_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_ACTION_ASSIGNED_NO.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_ACTION_ASSIGNED_NO'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_ACTION_ASSIGNED_NO_MTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_ACTION_ASSIGNED_NO_MTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_ASSIGNED_NO_NEW_PATTER.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_ASSIGNED_NO_NEW_PATTER'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_CTTACTION.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_CTTACTION'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_INVOICE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_INVOICE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_INVOICE_ACTION.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_INVOICE_ACTION'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_INVOICE_NEW_PATTERN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_INVOICE_NEW_PATTERN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_INVOICE_NO_PUBLISH.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_INVOICE_NO_PUBLISH'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_INVOICE_NO_PUBLISH_EXT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_INVOICE_NO_PUBLISH_EXT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_INV_MTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_INV_MTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_WITHOUT_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_WITHOUT_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPLACE_WITHOUT_INV_MTT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPLACE_WITHOUT_INV_MTT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPORT_INV_USED.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPORT_INV_USED'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method REPORT_MONTH.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'REPORT_MONTH'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method RESET_TEM.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'RESET_TEM'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method RESTORE_CANCEL_INV_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'RESTORE_CANCEL_INV_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method RESTORE_CANCEL_INV_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'RESTORE_CANCEL_INV_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method RESTORE_REPLACED_INV_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'RESTORE_REPLACED_INV_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method RESTORE_REPLACED_INV_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'RESTORE_REPLACED_INV_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method RETRY_SEND_INV.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'RETRY_SEND_INV'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_MTTFKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_MTTFKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_MTTFKEY_BY_SMART_CA.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_MTTFKEY_BY_SMART_CA'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_MTTFKEY_BY_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_MTTFKEY_BY_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_MTTINV_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_MTTINV_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_MTTINV_TOKEN_BY_SMART.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_MTTINV_TOKEN_BY_SMART'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_MTTINV_TOKEN_BY_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_MTTINV_TOKEN_BY_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_MTTNO_RANGE.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_MTTNO_RANGE'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_MTTNO_RANGE_BY_SMART.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_MTTNO_RANGE_BY_SMART'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method SEND_INV_MTTNO_RANGE_BY_TOKEN.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'SEND_INV_MTTNO_RANGE_BY_TOKEN'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method UNCONFIRM_PAYMENT_DETAIL_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'UNCONFIRM_PAYMENT_DETAIL_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method UN_CONFIRM_PAYMENT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'UN_CONFIRM_PAYMENT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method UN_CONFIRM_PAYMENT_FKEY.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'UN_CONFIRM_PAYMENT_FKEY'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method UN_CONFIRM_PAYMENT_FKEY_PATTER.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'UN_CONFIRM_PAYMENT_FKEY_PATTER'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method UN_CONFIRM_PAYMENT_FKEY_VNP.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'UN_CONFIRM_PAYMENT_FKEY_VNP'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.


  method UPDATE_SSTAFF_ACCOUNT.

  data(lt_parmbind) = value abap_parmbind_tab(
    ( name = 'INPUT' kind = '0' value = ref #( INPUT ) )
    ( name = 'OUTPUT' kind = '1' value = ref #( OUTPUT ) )
  ).
  if_proxy_client~execute(
    exporting
      method_name = 'UPDATE_SSTAFF_ACCOUNT'
    changing
      parmbind_tab = lt_parmbind
  ).

  endmethod.
ENDCLASS.
