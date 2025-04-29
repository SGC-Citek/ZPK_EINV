@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Source type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZEINV_I_STATUS
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZEINV_DO_STATUS' )
{

         @ObjectModel.text.element:[ 'UuidStatusText' ]
  key    value_low as UuidStatus,
         @UI.lineItem: [{ position: 10 }]
         text      as UuidStatusText
}
