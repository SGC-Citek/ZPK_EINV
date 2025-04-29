@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZEINV_I_POSUMQUAN'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZEINV_I_POSUMQUAN
  as select from I_SuplrInvcItemPurOrdRefAPI01 as RESG

{
  key   RESG.SupplierInvoice,
  key   RESG.FiscalYear,
  key   RESG.PurchaseOrderQuantityUnit,
        @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
        sum(RESG.QuantityInPurchaseOrderUnit) as Quantity
}
group by
  RESG.SupplierInvoice,
  RESG.FiscalYear,
  RESG.PurchaseOrderQuantityUnit
