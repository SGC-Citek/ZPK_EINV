@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sum amount/ quantity in fidoc'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZEINV_I_FISUMTAX
  as select from I_JournalEntryItem
{
  key I_JournalEntryItem.CompanyCode,
  key I_JournalEntryItem.AccountingDocument,
  key I_JournalEntryItem.FiscalYear,
      I_JournalEntryItem.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum( I_JournalEntryItem.AmountInTransactionCurrency ) as AmountInTransactionCurrency
}
where
       I_JournalEntryItem.DebitCreditCode =    'H'
  and(
      I_JournalEntryItem.GLAccount       like '3331%'
  )
  and  I_JournalEntryItem.Ledger          =    '0L'
group by
  I_JournalEntryItem.CompanyCode,
  I_JournalEntryItem.AccountingDocument,
  I_JournalEntryItem.FiscalYear,
  I_JournalEntryItem.TransactionCurrency
