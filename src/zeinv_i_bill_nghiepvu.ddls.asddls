@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Source type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZEINV_I_BILL_NGHIEPVU
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZEINV_DO_BILL_NGHIEPVU' )
{
      @UI.lineItem: [{ position: 1 }]
      @ObjectModel.text.element:[ 'BillNghiepVu_Text' ]
  key value_low as BillNghiepVu,
      @UI.lineItem: [{ position: 10 }]
  key text      as BillNghiepVu_Text


}
