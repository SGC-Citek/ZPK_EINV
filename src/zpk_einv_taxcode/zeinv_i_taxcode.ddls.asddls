@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Loại tax code xuất hoá đơn điện tử'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZEINV_I_TAXCODE
  as select from zeinv_tb_taxcode
{
  key taxcode,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZEINV_I_LOAITHUE', element: 'EInvoiceTax' } }]
      einvoicetax
}
