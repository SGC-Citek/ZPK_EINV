@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Source type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZEINV_I_TYPE
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZEINV_DO_TYPE' )
{
          @UI.hidden: true
          @ObjectModel.text.element:[ 'TYPE_TEXT' ]
  key     value_low as TYPE,
          @UI.lineItem: [{ position: 10 }]
          text      as TYPE_TEXT
}
