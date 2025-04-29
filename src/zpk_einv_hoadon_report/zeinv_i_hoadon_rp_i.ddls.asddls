@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Hoá đơn điện tử (item)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@ObjectModel.supportedCapabilities: [#CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE, #SQL_DATA_SOURCE,
                                      #EXTRACTION_DATA_SOURCE]
define view entity ZEINV_I_HOADON_RP_I
  as select from zeinv_tb_hd_i
  association to parent ZEINV_I_HOADON_RP as _Header on $projection.uuid = _Header.uuid
{
  key uuid,
  key itemforeinvoice,
      itemtext,
      product,
      goodtypeineinvoice,
      nuocsanxuat,
      quycachdonggoi,
      nongdohamluong,
      batchncc,
      hansudung,
      transactioncurrency,
      netpricebeforediscount,
      discountrate,
      netpriceafterdiscount,
      amountbeforetax,
      taxrate,
      taxamount,
      amountaftertax,
      einvoiceunit,
      @Semantics.quantity.unitOfMeasure: 'einvoiceunit'
      einvoicequanity,
      _Header
}
