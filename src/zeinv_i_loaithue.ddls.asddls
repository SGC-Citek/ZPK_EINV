@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Loại thuế xuất hoá đơn'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZEINV_I_LOAITHUE
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZEINV_DO_LOAITHUE' )
{

         @ObjectModel.text.element:[ 'EInvoiceTaxText' ]
         @EndUserText.label: 'Loại thuế'
  key    value_low as EInvoiceTax,
         @UI.lineItem: [{ position: 10 }]
         @EndUserText.label: 'Description'
         text      as EInvoiceTaxText
}
