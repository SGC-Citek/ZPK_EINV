@EndUserText.label: 'Billing -> E-Invoice'
@Metadata.allowExtensions: true
define root view entity ZEINV_I_BILLINGSOURCE
  as select from I_BillingDocument
    inner join   ZEINV_I_BILLINGSUM on ZEINV_I_BILLINGSUM.BillingDocument = I_BillingDocument.BillingDocument
  association [1..1] to I_BillingDocumentPartner  as _BillToParty on  _BillToParty.BillingDocument = I_BillingDocument.BillingDocument
                                                                  and _BillToParty.PartnerFunction = 'RE'
  composition [1..*] of ZEINV_I_BILLINGSOURCEITEM as _Item
{
  key I_BillingDocument.BillingDocument,
      I_BillingDocument.BillingDocumentType,
      I_BillingDocument.DocumentReferenceID,
      I_BillingDocument.AccountingExchangeRate,
      I_BillingDocument.TransactionCurrency,
      _BillToParty.Customer                                   as Customer,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @EndUserText.label: 'Amount before tax'
      ZEINV_I_BILLINGSUM.Subtotal1Amount                      as AmountBeforeTax,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @EndUserText.label: 'Tax amount'
      ZEINV_I_BILLINGSUM.TaxAmount,
      @EndUserText.label: 'Total amount in LC'
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ( $projection.AmountBeforeTax + $projection.taxamount ) as AmountAfterTax,
      _Item
}
