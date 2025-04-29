@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sum amount/ quantity in billing'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZEINV_I_BILLINGSUM
  as select from I_BillingDocument
    inner join   I_BillingDocumentItem on I_BillingDocumentItem.BillingDocument = I_BillingDocument.BillingDocument
{
  key I_BillingDocument.BillingDocument,
      I_BillingDocument.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum( I_BillingDocumentItem.Subtotal1Amount ) as Subtotal1Amount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum( I_BillingDocumentItem.TaxAmount )       as TaxAmount
}
group by
  I_BillingDocument.BillingDocument,
  I_BillingDocument.TransactionCurrency
