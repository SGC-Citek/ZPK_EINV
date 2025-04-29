@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billing -> E-Invoice (item)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZEINV_I_FISOURCEITEM
  as select from I_JournalEntry
    inner join   I_OperationalAcctgDocItem on  I_OperationalAcctgDocItem.CompanyCode        = I_JournalEntry.CompanyCode
                                           and I_OperationalAcctgDocItem.AccountingDocument = I_JournalEntry.AccountingDocument
                                           and I_OperationalAcctgDocItem.FiscalYear         = I_JournalEntry.FiscalYear
{
  key I_JournalEntry.CompanyCode,
  key I_JournalEntry.AccountingDocument,
  key I_JournalEntry.FiscalYear,
  key I_OperationalAcctgDocItem.AccountingDocumentItem,
      I_OperationalAcctgDocItem.DocumentItemText,
      I_JournalEntry.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @EndUserText.label: 'Đơn giá trước chiết khấu'
      I_OperationalAcctgDocItem.AmountInTransactionCurrency as NetPriceBeforeDiscount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      I_OperationalAcctgDocItem.AmountInTransactionCurrency as NetPriceAfterDiscount
}
