@EndUserText.label: 'Maintain Billing Type All'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZEINV_C_BILLTYPE_S
  provider contract transactional_query
  as projection on ZEINV_I_BILLTYPE_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _BillingType : redirected to composition child ZEINV_C_BILLTYPE_D
  
}
