@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FI Doc -> E-Invoice (item)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZEINV_I_FISOURCE
  as select from    I_JournalEntry
    left outer join ZEINV_I_FISUM    as FiSum    on  I_JournalEntry.CompanyCode        = FiSum.CompanyCode
                                                 and I_JournalEntry.FiscalYear         = FiSum.FiscalYear
                                                 and I_JournalEntry.AccountingDocument = FiSum.AccountingDocument
    left outer join ZEINV_I_FISUMTAX as FiSumTax on  I_JournalEntry.CompanyCode        = FiSum.CompanyCode
                                                 and I_JournalEntry.FiscalYear         = FiSum.FiscalYear
                                                 and I_JournalEntry.AccountingDocument = FiSum.AccountingDocument
{
  key I_JournalEntry.CompanyCode,
  key I_JournalEntry.AccountingDocument,
  key I_JournalEntry.FiscalYear,
      I_JournalEntry.PostingDate,
      I_JournalEntry.TransactionCurrency,
      I_JournalEntry.DocumentReferenceID,
      I_JournalEntry.AbsoluteExchangeRate as AccountingExchangeRate,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @EndUserText.label: 'Amount before tax'
      FiSum.AmountInTransactionCurrency                       as AmountBeforeTax,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      FiSumTax.AmountInTransactionCurrency                    as TaxAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ( $projection.AmountBeforeTax + $projection.TaxAmount ) as AmountAfterTax
}
