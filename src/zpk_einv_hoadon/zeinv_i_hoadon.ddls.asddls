//*----------------------------------------------------------------------*
//* Citek JSC.
//* (C) Copyright Citek JSC.
//* All Rights Reserved
//*----------------------------------------------------------------------*
//* Application : E-Invoice
//* Creation Date: Jan 01, 2024
//* Created by: NganNM
//*----------------------------------------------------------------------*
@ObjectModel.query.implementedBy: 'ABAP:ZEINV_CL_HOADON'
@EndUserText.label: 'Billing -> E-Invoice'
define root custom entity ZEINV_I_HOADON
{
      @UI                     : {

       facet                  : [
               { id           : 'headerTongThanhToan',
                 purpose      : #HEADER,
                 type         : #DATAPOINT_REFERENCE,
                 position     : 10,
                 targetQualifier: 'headerTongThanhToan'
               },
               { id           : 'headerTongThue',
                 purpose      : #HEADER,
                 type         : #DATAPOINT_REFERENCE,
                 position     : 20,
                 targetQualifier: 'headerTongThue'
               },
               { id           : 'buyerCollection',
                 type         : #COLLECTION,
                 label        : 'Buyer information',
                 position     : 10
               },
               { id           : 'buyerGeneral',
                 purpose      : #STANDARD,
                 type         : #FIELDGROUP_REFERENCE,
                 parentId     : 'buyerCollection',
                 position     : 10,
                 targetQualifier: 'buyerGeneral'
               },
               { id           : 'documentCollection',
                 type         : #COLLECTION,
                 label        : 'Document information',
                 position     : 10
               },
               { id           : 'documentInfo',
                 purpose      : #STANDARD,
                 type         : #FIELDGROUP_REFERENCE,
                 parentId     : 'documentCollection',
                 position     : 20,
                 targetQualifier: 'documentInfo'
               },
               { id           : 'valueCollection',
                 type         : #COLLECTION,
                 label        : 'Value information',
                 position     : 20
               },
               { id           : 'valueGeneral',
                 purpose      : #STANDARD,
                 type         : #FIELDGROUP_REFERENCE,
                 parentId     : 'valueCollection',
                 position     : 10,
                 targetQualifier: 'valueGeneral'
               },
               { id           : 'itemList',
                 purpose      : #STANDARD,
                 type         : #LINEITEM_REFERENCE,
                 label        : 'Item List',
                 position     : 30,
                 targetElement: '_Item'
                 }]}

      @UI.hidden              : true
  key sourcetype              : zeinv_sourcetype;
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_BillingDocumentStdVH', element: 'BillingDocument' } }]
      @UI.lineItem            : [{ position: 10 }]
      @UI.selectionField      : [{ position: 40 }]
      @EndUserText.label      : 'Billing Document'
  key BillingDocument         : vbeln_vl;
      @UI.lineItem            : [{ position: 11 }]
      @EndUserText.label      : 'Reference Document'
  key ReferenceSDDocument     : vbeln_vl;
      @Consumption.filter.multipleSelections: false
      @Consumption.filter.mandatory: true
      @Consumption.filter.selectionType: #SINGLE
      @Consumption.filter.defaultValue: '1000'
      //      @UI.lineItem            : [{ position: 10 }]
      @UI.selectionField      : [{ position: 20 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CompanyCodeStdVH', element: 'CompanyCode' } }]
  key CompanyCode             : bukrs;
      @UI.lineItem            : [{ position: 30 }]
      @UI.selectionField      : [{ position: 50 }]
      @EndUserText.label      : 'FI Document number'
  key AccountingDocument      : belnr_d;
      @UI.lineItem            : [{ position: 20 }]
      @UI.selectionField      : [{ position: 20 }]
  key FiscalYear              : gjahr;
      @UI.lineItem            : [{ position: 40 }]
  key PurchaseOrder           : ebeln;
      //      @UI.lineItem            : [{ position: 41 }]
      @ObjectModel.text.element:[ 'PlantName' ]
      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 10 }]
  key Plant                   : werks_d;
      @UI.hidden              : true
  key AllBillingDetail        : abap_boolean;
      @UI.hidden              : true
  key BillingGeneral          : abap_boolean;
      @UI.hidden              : true
  key BillingAltUnit          : abap_boolean;
      @EndUserText.label      : 'Số tham khảo'
      @UI.identification      : [{ position: 10 }]
  key SoThamKhao              : abap.char(30);
  key LoaiHoaDon              : abap.char(5); // dùng để phân biệt Hoá đơn bán(NORM) - hoá đơn điều chỉnh(ADJ) - Hoá đơn thay thế (REP)
      @UI.hidden              : true
  key DispNSX                 : abap_boolean;
      @UI.hidden              : true
  key DispValueDV             : abap.char(1);
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZEINV_I_DEBCREVH', element: 'type' } }]
  key NumberFormatType        : zde_id; // định dạng số khai báo

      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 10 }]
      @EndUserText.label      : 'Serial'
      //      @UI.selectionField      : [{ position: 51 }]
      @Consumption.filter.selectionType: #SINGLE
      @Consumption.filter.multipleSelections: false
  key Zserial                 : zeinv_serial;
      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 20 }]
      @EndUserText.label      : 'Pattern'
      //      @UI.selectionField      : [{ position: 52 }]
      @Consumption.filter.selectionType: #SINGLE
      @Consumption.filter.multipleSelections: false
  key Zpattern                : zeinv_pattern;
      @UI.hidden              : true
  key XuatHoaDonHeadOffice    : abap_boolean;
      @UI.hidden              : true
  key XuatHoaDonBillTo        : abap_boolean;
  key LoaiNghiepVuDieuChinh   : abap.char(20);
      @ObjectModel.text.element:[ 'FormatNumberText' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZEINV_I_FORMATNUMBER', element: 'FormatNumber' } }]
      @Consumption.filter.selectionType: #SINGLE
      @UI.selectionField      : [{ position: 101 }]
  key FormatNumber            : zeinv_de_numberformat;
      //////Source Document info
      @UI.lineItem            : [{ position: 12 }]
      @EndUserText.label      : 'Invoice date'
      InvoiceDate             : abap.dats;
      @UI.hidden              : true
      @ObjectModel.filter.enabled: false
      InvoiceDateText         : abap.char( 10 );

      @UI.lineItem            : [{ position: 50 }]
      @UI.selectionField      : [{ position: 30 }]
      @EndUserText.label      : 'Billing Type'
      BillingDocumentType     : abap.char(4);
      @UI.lineItem            : [{ position: 31 }]
      @EndUserText.label      : 'Loại nghiệp vụ hoá đơn'
      @ObjectModel.text.element:[ 'BillNghiepVu_Text' ]
      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 9 }]
      BillNghiepVu            : zeinv_bill_nghiepvu;
      @UI.hidden              : true
      BillNghiepVu_Text       : abap.char(60);
      //      @UI.lineItem            : [{ position: 51 }]
      @UI.selectionField      : [{ position: 40 }]
      @EndUserText.label      : 'Document date'
      DocumentDate            : abap.dats(8);
      @UI.lineItem            : [{ position: 51 }]
      @UI.selectionField      : [{ position: 40 }]
      @EndUserText.label      : 'Posting date'
      PostingDate             : abap.dats(8);
      @UI.lineItem            : [{ position: 60 }]
      @UI.selectionField      : [{ position: 50 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CUSTOMER_SH', element: 'Customer' } }]
      @EndUserText.label      : 'Customer'
      Customer                : lifnr;
      @UI.lineItem            : [{ position: 61 }]
      @UI.selectionField      : [{ position: 51 }]
      @EndUserText.label      : 'Vendor'
      Vendor                  : lifnr;
      @UI.lineItem            : [{ position: 70 }]
      @UI.selectionField      : [{ position: 60 }]
      @EndUserText.label      : 'Sales Office'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_SalesOffice', element: 'SalesOffice' } }]
      SalesOffice             : abap.char(4);
      @UI.lineItem            : [{ position: 80 }]
      @UI.selectionField      : [{ position: 70 }]
      @EndUserText.label      : 'Sales Group'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_SalesGroup', element: 'SalesGroup' } }]
      SalesGroup              : abap.char(3);
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZCORE_I_USER', element: 'UserID' } }]
      CreatedBy               : usnam;
      //      @UI.lineItem            : [{ position: 60 }]
      DocumentReferenceID     : zde_reference;

      @UI.lineItem            : [{ position: 65 }]
      @EndUserText.label      : 'Supplier Invoice'
      DocumentNumber          : zde_reference;

      ///////////////////////////////////////////////////////////////////////////////////////////////////
      //////Buyer Info
      @EndUserText.label      : 'Người mua hàng'
      @UI.fieldGroup          : [{ qualifier: 'buyerGeneral', position: 10 }]


      Buyer                   : abap.char(80);
      @EndUserText.label      : 'Tên đơn vị'
      @UI.fieldGroup          : [{ qualifier: 'buyerGeneral', position: 20 }]
      TenDonVi                : abap.char(80);
      @EndUserText.label      : 'Address'
      @UI.fieldGroup          : [{ qualifier: 'buyerGeneral', position: 30 }]
      BuyerAddress            : abap.char(150);
      @UI.fieldGroup          : [{ qualifier: 'buyerGeneral', position: 40 }]
      @EndUserText.label      : 'VAT Register Number'
      BuyerVATNumber          : abap.char(20);
      @UI.fieldGroup          : [{ qualifier: 'buyerGeneral', position: 50 }]
      @EndUserText.label      : 'Email'
      BuyerEmail              : abap.char(255);
      @EndUserText.label      : 'Tên công ty'
      @UI.fieldGroup          : [{ qualifier: 'buyerGeneral', position: 11 }]
      BuyerCompany            : abap.char(80);
      @UI.hidden              : true
      BuyerBPGroup            : abap.char(5);
      @EndUserText.label      : 'Địa chỉ giao hàng'
      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 50 }]
      ShippingAddress         : abap.char(150);

      ///////////////////////////////////////////////////////////////////////////////////////////////////
      //////E-Invoice Info
      @EndUserText.label      : 'Origin Fkey'
      OriginUuid              : zeinv_fkey;
      @EndUserText.label      : 'Origin E-invoice number'
      OriginEInvoiceNo        : zeinv_einvoiceno;
      Uuid                    : zeinv_fkey;
      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 1 }]
      EInvoiceNo              : zeinv_einvoiceno;
      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 2 }]
      @UI.lineItem            : [{ position: 31 }]
      @EndUserText.label      : 'Red Invoice No'
      EInvoiceNo_Long         : zeinv_einvoiceno_long;
      @ObjectModel.text.element:[ 'UuidStatusName' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZEINV_I_STATUS', element: 'UuidStatus' } }]
      @UI.selectionField      : [{ position: 100 }]
      @UI.lineItem            : [{ position: 9, criticalityRepresentation: #WITH_ICON , criticality: 'UuidStatusCritical' }]
      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 3, criticalityRepresentation: #WITH_ICON , criticality: 'UuidStatusCritical' }]
      UuidStatus              : zeinv_status;
      @UI.hidden              : true
      UuidStatusCritical      : abap.int1;
      @UI.hidden              : true
      UuidStatusName          : abap.char(20);


      @UI.hidden              : true
      FormatNumberText        : abap.char(20);

      //      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 10 }]
      //      @EndUserText.label      : 'Serial'
      //      @UI.selectionField      : [{ position: 51 }]
      //      @Consumption.filter.selectionType: #SINGLE
      //      @Consumption.filter.multipleSelections: false
      //      Zserial                 : zeinv_serial;
      //      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 20 }]
      //      @EndUserText.label      : 'Pattern'
      //      @UI.selectionField      : [{ position: 52 }]
      //      @Consumption.filter.selectionType: #SINGLE
      //      @Consumption.filter.multipleSelections: false
      //      Zpattern                : zeinv_pattern;
      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 30 }]
      @EndUserText.label      : 'Ghi chú'
      GhiChu                  : abap.char(100);
      @EndUserText.label      : 'Payment Method'
      PaymentMethod           : abap.char(1);
      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 40 }]
      @EndUserText.label      : 'Hình thức thanh toán'
      PaymentMethodName       : abap.char(20);
      ///////////////////////////////////////////////////////////////////////////////////////////////////

      //////E-Invoice value
      @UI.lineItem            : [{ position: 70 }]
      @UI.fieldGroup          : [{ qualifier: 'valueGeneral', position: 40 }]
      @EndUserText.label      : 'Exchange rate'
      AccountingExchangeRate  : zde_kursf;
      @UI.lineItem            : [{ position: 80 }]
      TransactionCurrency     : waers;
      @UI.lineItem            : [{ position: 100 }]
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @EndUserText.label      : 'Thành tiền'
      @UI.fieldGroup          : [{ qualifier: 'valueGeneral', position: 10, label: 'Thành tiền' }]
      AmountBeforeTax         : abap.dec(31,4);
      @UI.lineItem            : [{ position: 70 }]
      @EndUserText.label      : 'Total quantity'
      TotalQuantity           : abap.dec(31,4);
      @UI.lineItem            : [{ position: 110 }]
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @EndUserText.label      : 'Tiền thuế'
      @UI.dataPoint           : { qualifier: 'headerTongThue', title: 'Tổng tiền thuế'}
      @UI.fieldGroup          : [{ qualifier: 'valueGeneral', position: 20, label: 'Tiền thuế' }]
      TaxAmount               : abap.dec(31,4);
      @UI.lineItem            : [{ position: 120 }]
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @EndUserText.label      : 'Tổng tiền thanh toán'
      @UI.dataPoint           : { qualifier: 'headerTongThanhToan', title: 'Tổng tiền thanh toán'}
      @UI.fieldGroup          : [{ qualifier: 'valueGeneral', position: 30, label: 'Tổng tiền thanh toán' }]
      AmountAfterTax          : abap.dec(31,4);
      @EndUserText.label      : 'Tổng thành tiền thanh toán bằng chữ'
      @UI.fieldGroup          : [{ qualifier: 'valueGeneral', position: 50, label: 'Tổng thành tiền thanh toán bằng chữ' }]
      AmountInWords           : abap.string(0);
      @EndUserText.label      : 'VAT Code'
      VATRate                 : abap.dec(31,4);
      @UI.lineItem            : [{ position: 150 }]
      @EndUserText.label      : 'Ngày đăng ký phát hành'
      //      @UI.fieldGroup          : [{ qualifier: 'valueGeneral', position: 10, label: 'Thành tiền' }]
      ngayphathanhhoadon      : abap.dats;

      ///////////////////////////////////////////////////////////////////////////////////////////////////
      /////// Text
      @UI.hidden              : true
      PlantName               : abap.char(60);
      TenNguoiBan             : abap.char(55);
      DiaChiNBan              : abap.char(100);
      VATRegistration         : abap.char(20);
      BankAccount             : abap.char(15);
      BankName                : abap.char(60);
      ///////////////////////////////////////////////////////////////////////////////////////////////////
      //////Function property
      @UI.hidden              : true
      VisibilityPublishAction : abap_boolean;
      @UI.hidden              : true
      VisibilityCancelAction  : abap_boolean;
      @UI.hidden              : true
      VisibilityViewAction    : abap_boolean;
      @UI.hidden              : true
      @ObjectModel.filter.enabled: false
      check_thaythe_dieuchinh : abap.char(1);
      @UI.hidden              : true
      @ObjectModel.filter.enabled: false
      originbill              : vbeln_vl;

      ///////////////////////////////////////////////////////////////////////////////////////////////////
      //////HasValue
      Zserialcert             : zeinv_serialcert;
      Zidinv                  : zeinv_idinv;
      Zhasvalue               : zeinv_hasvalue;
      @EndUserText.label      : 'Billing Move'
      BillingMove             : vbeln_vl;
      ///////////////////////////////////////////////////////////////////////////////////////////////////

      _Item                   : composition [1..*] of ZEINV_I_HOADON_ITEM;
}
