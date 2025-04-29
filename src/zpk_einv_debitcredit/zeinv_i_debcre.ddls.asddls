@EndUserText.label: 'Mapping debit/credit indicator'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZEINV_I_DEBCRE
  as select from zeinv_tb_debcre
  association to parent ZEINV_I_DEBCRE_S as _MapDebCre on $projection.SingletonID = _MapDebCre.SingletonID
{
  key type                   as Type,
      description            as Description,
      @EndUserText.label: 'Số lượng'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_ARITHOPER', element: 'operation' } }]
      einvoicequanity        as Einvoicequanity,
      @EndUserText.label: 'Đơn giá trước chiết khấu'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_ARITHOPER', element: 'operation' } }]
      netpricebeforediscount as Netpricebeforediscount,
      @EndUserText.label: 'Đơn giá sau chiết khấu'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_ARITHOPER', element: 'operation' } }]
      netpriceafterdiscount  as Netpriceafterdiscount,
      @EndUserText.label: 'Thành tiền'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_ARITHOPER', element: 'operation' } }]
      amountbeforetax        as Amountbeforetax,
      @EndUserText.label: 'Thuế GTGT'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_ARITHOPER', element: 'operation' } }]
      taxamount              as Taxamount,
      @EndUserText.label: 'Số tiền thanh toán'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_ARITHOPER', element: 'operation' } }]
      amountaftertax         as Amountaftertax,
      @Consumption.hidden: true
      1                      as SingletonID,
      _MapDebCre

}
