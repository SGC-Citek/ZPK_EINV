@EndUserText.label: 'Mapping debit/credit indicator'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZEINV_I_DEBCRE_S
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZEINV_I_DEBCRE'
  composition [0..*] of ZEINV_I_DEBCRE as _MappingDebitCredit
{
  key 1 as SingletonID,
  _MappingDebitCredit,
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax,
  cast( '' as sxco_transport) as TransportRequestID,
  cast( 'X' as abap_boolean preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
