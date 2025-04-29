@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Format Number'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZEINV_I_FORMATNUMBER
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZEINV_DO_NUMBERFORMAT' )
{

         @ObjectModel.text.element:[ 'FormatNumberText' ]
  key    value_low as FormatNumber,
         @UI.lineItem: [{ position: 10 }]
         text      as FormatNumberText
}
