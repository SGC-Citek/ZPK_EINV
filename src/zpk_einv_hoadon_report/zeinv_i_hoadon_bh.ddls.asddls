@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Hoá đơn điện tử'
@Metadata.allowExtensions: true
define root view entity ZEINV_I_HOADON_BH
  as select from zeinv_tb_hd
  association [0..1] to ZEINV_I_STATUS      as _UuidStatus on _UuidStatus.UuidStatus = zeinv_tb_hd.uuidstatus
  composition [1..*] of ZEINV_I_HOADON_BH_I as _Item
{
  key uuid,
      einvoiceno,
      einvoiceno_long,
      doctype,
      sourcetype,
      zserial,
      zpattern,
      _UuidStatus.UuidStatusText,
      @ObjectModel.text.element: [ 'UuidStatusText' ]
      uuidstatus,
      ngayhoadon,
      customer,
      buyer,
      tendonvi,
      buyeraddress,
      buyeremail,
      buyercompany,
      buyervatnumber,
      shippingaddress,
      amountbeforetax,
      taxamount,
      amountaftertax,
      paymentmethod,
      companycode,
      billingdocument,
      accountingdocument,
      fiscalyear,
      transactioncurrency,
      ghichu,
      _UuidStatus,
      _Item
      //    _association_name // Make association public
}
