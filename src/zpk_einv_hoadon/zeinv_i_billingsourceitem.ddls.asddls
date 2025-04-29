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
define view entity ZEINV_I_BILLINGSOURCEITEM
  as select from    I_BillingDocument
    inner join      I_BillingDocumentItem                      on I_BillingDocument.BillingDocument = I_BillingDocumentItem.BillingDocument
    left outer join I_BillingDocumentItemPrcgElmnt as Discount on  Discount.BillingDocument     = I_BillingDocumentItem.BillingDocument
                                                               and Discount.BillingDocumentItem = I_BillingDocumentItem.BillingDocumentItem
                                                               and Discount.ConditionType       = 'ZDC1'
    left outer join I_BillingDocumentItemPrcgElmnt as VAT      on  VAT.BillingDocument     = I_BillingDocumentItem.BillingDocument
                                                               and VAT.BillingDocumentItem = I_BillingDocumentItem.BillingDocumentItem
                                                               and VAT.ConditionType       = 'TTX1'
  association to parent ZEINV_I_BILLINGSOURCE as _Header on $projection.BillingDocument = _Header.BillingDocument
{
  key I_BillingDocument.BillingDocument,
  key I_BillingDocumentItem.BillingDocumentItem,
      I_BillingDocumentItem.SalesDocument,
      I_BillingDocumentItem.SalesDocumentItem,
      I_BillingDocumentItem.ReferenceSDDocument,
      I_BillingDocumentItem.ReferenceSDDocumentItem,
      I_BillingDocumentItem.Product,
      @EndUserText.label: 'Đơn vị tính'
      I_BillingDocumentItem.BillingQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      @EndUserText.label: 'Số lượng'
      I_BillingDocumentItem.BillingQuantity,
      I_BillingDocumentItem.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @EndUserText.label: 'Đơn giá trước chiết khấu'
      cast( cast( ( cast( I_BillingDocumentItem.Subtotal4Amount as abap.dec(24,4) ) / I_BillingDocumentItem.BillingQuantity ) as abap.dec(24,4) ) as abap.dec(24,4) ) as NetPriceBeforeDiscount,
      @EndUserText.label: 'Chiết khấu'
      cast( abs( Discount.ConditionRateValue ) as abap.dec(7,2) )                                                                                                     as DiscountRate,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast( cast( ( cast( I_BillingDocumentItem.Subtotal1Amount as abap.dec(24,4) ) / I_BillingDocumentItem.BillingQuantity ) as abap.dec(24,4) ) as abap.dec(24,4) ) as NetPriceAfterDiscount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @EndUserText.label: 'Thành tiền'
      I_BillingDocumentItem.Subtotal1Amount                                                                                                                           as AmountBeforeTax, //Thành tiền
      @EndUserText.label: 'Thuế suất'
      cast( abs( VAT.ConditionRateValue ) as abap.dec(7,2) )                                                                                                          as TaxRate,
      @EndUserText.label: 'Thuế GTGT'
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast( ( cast( $projection.AmountBeforeTax as abap.dec(24,4) ) * cast( $projection.TaxRate as abap.dec(7,2) ) / 100 )as abap.dec(31,4) )                         as TaxAmount,
      @EndUserText.label: 'Số tiền thanh toán'
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      cast( ( cast( $projection.AmountBeforeTax as abap.dec(24,4) ) + cast( $projection.TaxAmount as abap.dec(24,4) ) ) as abap.dec(31,4) )                           as AmountAfterTax,

      _Header

}
