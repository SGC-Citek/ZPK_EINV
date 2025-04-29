@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Source type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZEINV_I_GOODTYPE
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZEINV_DO_ISSUM_FOR_VNPT' )
{

         @ObjectModel.text.element:[ 'GoodTypeText' ]
  key    value_low as GoodType,
         @UI.lineItem: [{ position: 10 }]
         text      as GoodTypeText
}
