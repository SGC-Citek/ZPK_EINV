@EndUserText.label: 'Billing Type All'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZEINV_I_BILLTYPE_S
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZEINV_I_BILLTYPE_D'
  composition [0..*] of ZEINV_I_BILLTYPE_D as _BillingType
{
  key 1 as SingletonID,
  _BillingType,
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax,
  cast( '' as sxco_transport) as TransportRequestID,
  cast( 'X' as abap_boolean preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
