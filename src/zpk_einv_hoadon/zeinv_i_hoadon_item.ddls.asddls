//*----------------------------------------------------------------------*
//* Citek JSC.
//* (C) Copyright Citek JSC.
//* All Rights Reserved
//*----------------------------------------------------------------------*
//* Application : E-Invoice
//* Creation Date: Jan 01, 2024
//* Created by: NganNM
//*----------------------------------------------------------------------*
@ObjectModel.query.implementedBy: 'ABAP:ZEINV_CL_HOADON_ITEM'
@EndUserText.label: 'Billing -> E-Invoice (item)'
define custom entity ZEINV_I_HOADON_ITEM
{
      @UI                     : {
       facet                  : [
              { id            : 'TienThanhToan',
                 purpose      : #HEADER,
                 type         : #DATAPOINT_REFERENCE,
                 position     : 10,
                 targetQualifier: 'TienThanhToan'
               },
               { id           : 'TienThue',
                 purpose      : #HEADER,
                 type         : #DATAPOINT_REFERENCE,
                 position     : 20,
                 targetQualifier: 'TienThue'
               },
               { id           : 'sourceCollection',
                 type         : #COLLECTION,
                 label        : 'Source document',
                 position     : 10
               },
               { id           : 'sourceInfo',
                 purpose      : #STANDARD,
                 type         : #FIELDGROUP_REFERENCE,
                 parentId     : 'sourceCollection',
                 position     : 10,
                 targetQualifier: 'sourceInfo'
               },
               { id           : 'itemInfoCollection',
                 type         : #COLLECTION,
                 label        : 'Item info',
                 position     : 20
               },
               { id           : 'itemInfo',
                 purpose      : #STANDARD,
                 type         : #FIELDGROUP_REFERENCE,
                 parentId     : 'itemInfoCollection',
                 position     : 10,
                 targetQualifier: 'itemInfo'
               },
               { id           : 'itemValueCollection',
                 type         : #COLLECTION,
                 label        : 'Item value',
                 position     : 30
               }
               ,
                { id          : 'itemInfoValue',
                 purpose      : #STANDARD,
                 type         : #FIELDGROUP_REFERENCE,
                 parentId     : 'itemValueCollection',
                 position     : 10,
                 targetQualifier: 'itemInfoValue'
               }] }
      @UI.hidden              : true
      @UI.fieldGroup          : [{ qualifier: 'sourceInfo', position: 10 }]
  key sourcetype              : zeinv_sourcetype;
      @UI.lineItem            : [{ position: 10 }]
      @UI.identification      : [{ position: 10 }]
      @EndUserText.label      : 'Billing Document'
      @UI.fieldGroup          : [{ qualifier: 'sourceInfo', position: 10 }]
  key BillingDocument         : vbeln_vl;
      @EndUserText.label      : 'Bill item'
      @UI.lineItem            : [{ position: 11 }]
      @UI.fieldGroup          : [{ qualifier: 'sourceInfo', position: 10 }]
  key BillingDocumentItem     : zde_posnr;
      @EndUserText.label      : 'Company Code'
      @UI.lineItem            : [{ position: 20 }]
      @UI.fieldGroup          : [{ qualifier: 'sourceInfo', position: 10 }]
  key CompanyCode             : bukrs;
      @UI.lineItem            : [{ position: 21 }]
      @UI.fieldGroup          : [{ qualifier: 'sourceInfo', position: 10 }]
  key AccountingDocument      : belnr_d;
      @UI.lineItem            : [{ position: 22 }]
      @UI.fieldGroup          : [{ qualifier: 'sourceInfo', position: 10 }]
  key FiscalYear              : gjahr;
      @UI.lineItem            : [{ position: 23 }]
      @EndUserText.label      : 'FI item'
      @UI.fieldGroup          : [{ qualifier: 'sourceInfo', position: 10 }]
  key AccountingDocumentItem  : buzei;
      @EndUserText.label      : 'Outbound delivery'
      @UI.fieldGroup          : [{ qualifier: 'sourceInfo', position: 10 }]
  key ReferenceSDDocument     : vbeln_vl;
      @UI.fieldGroup          : [{ qualifier: 'sourceInfo', position: 10 }]
  key PurchaseOrder           : ebeln;
      @UI.fieldGroup          : [{ qualifier: 'sourceInfo', position: 11 }]
  key Plant                   : werks_d;
      //////Filter
      @UI.fieldGroup          : [{ qualifier: 'sourceInfo', position: 10 }]
      @UI.hidden              : true
  key AllBillingDetail        : abap_boolean;
      @UI.hidden              : true
  key BillingGeneral          : abap_boolean;
      @UI.hidden              : true
  key BillingAltUnit          : abap_boolean;
      @UI.lineItem            : [{ position: 24 }]
      @EndUserText.label      : 'E-Invoie item no'
      @UI.fieldGroup          : [{ qualifier: 'itemInfo', position: 10 }]
  key ItemForEInVoice         : zeinv_itemno; // key item riêng cho E-Invoice ( trường hợp gộp/ tách dòng)
      @UI.hidden              : true
      @UI.lineItem            : [{ hidden: true }]
  key SoThamKhao              : abap.char(30);
      @UI.hidden              : true
      @UI.lineItem            : [{ hidden: true }]
  key LoaiHoaDon              : abap.char(5); // dùng để phân biệt Hoá đơn bán(NORM) - hoá đơn điều chỉnh(ADJ) - Hoá đơn thay thế (REP)
      @UI.hidden              : true
      @UI.lineItem            : [{ hidden: true }]
  key DispNSX                 : abap_boolean;
      @UI.hidden              : true
      @UI.lineItem            : [{ hidden: true }]
  key DispValueDV             : abap.char(1);
      @UI.hidden              : true
      @UI.lineItem            : [{ hidden: true }]
  key NumberFormatType        : zde_id; // định dạng số khai báo
      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 10 }]
      @EndUserText.label      : 'Serial'
      @UI.selectionField      : [{ position: 51 }]
      @Consumption.filter.selectionType: #SINGLE
      @Consumption.filter.multipleSelections: false
  key Zserial                 : zeinv_serial;
      @UI.fieldGroup          : [{ qualifier: 'documentInfo', position: 20 }]
      @EndUserText.label      : 'Pattern'
      @UI.selectionField      : [{ position: 52 }]
      @Consumption.filter.selectionType: #SINGLE
      @Consumption.filter.multipleSelections: false
  key Zpattern                : zeinv_pattern;
      @UI.hidden              : true
  key XuatHoaDonHeadOffice    : abap_boolean;
      @UI.hidden              : true
  key XuatHoaDonBillTo        : abap_boolean;
  key LoaiNghiepVuDieuChinh   : abap.char(20);
  key FormatNumber            : zeinv_de_numberformat;
      ///////////////////////////////////////////////////////////////////////////////
      //////Source Document info
      @EndUserText.label      : 'Sales order'
      SalesDocument           : vbeln_vl;
      @EndUserText.label      : 'SO item'
      SalesDocumentItem       : zde_posnr;
      @EndUserText.label      : 'OD item'
      ReferenceSDDocumentItem : zde_posnr;
      @UI.fieldGroup          : [{ qualifier: 'itemInfo', position: 10 }]
      @UI.lineItem            : [{ position: 30 }]
      Product                 : matnr;
      @UI.lineItem            : [{ position: 31 }]
      @EndUserText.label      : 'Product Type'
      ProductType             : abap.char(4);
      @EndUserText.label      : 'Material Description'
      @UI.lineItem            : [{ position: 20 }]
      @UI.fieldGroup          : [{ qualifier: 'itemInfo', position: 10 }]
      ItemText                : abap.char(255);
      @ObjectModel.text.element:[ 'GoodTypeInEInvoiceText' ]
      @UI.fieldGroup          : [{ qualifier: 'itemInfo', position: 10 }]
      GoodTypeInEInvoice      : zeinv_issum_for_vnpt; // VNPT là ISSUM
      @UI.hidden              : true
      GoodTypeInEInvoiceText  : abap.char(50);
      TaxCode                 : mwskz;
      @UI.hidden              : true
      yy1_einvoiceunit_prd    : meins;
      ///////////////////////////////////////////////////////////////////////////////

      //////Source Document info
      @EndUserText.label      : 'Nồng độ hàm lượng'
      NongDoHamLuong          : abap.char(30);
      @EndUserText.label      : 'Quy cách đóng gói'
      QuyCachDongGoi          : abap.char(30);
      @EndUserText.label      : 'Nước sản xuất'
      NuocSanXuat             : abap.char(40);
      @EndUserText.label      : 'Số lô'
      BatchNcc                : abap.char(40);
      @EndUserText.label      : 'Hạn dùng'
      HanSuDung               : abap.dats;
      ///////////////////////////////////////////////////////////////////////////////

      //////E-Invoice value
      @EndUserText.label      : 'Thuế thể hiện ở hoá đơn'
      EInvoiceTax             : zeinv_loaithue;
      @UI.hidden              : true
      UnitName                : abap.char(10);
      @Semantics.quantity.unitOfMeasure: 'EInvoiceUnit'
      @EndUserText.label      : 'Quantity'
      @UI.fieldGroup          : [{ qualifier: 'itemInfoValue', position: 80 }]
      EInvoiceQuanity         : menge_d;
      @ObjectModel.text.element:[ 'UnitName' ]
      @EndUserText.label      : 'Unit'
      EInvoiceUnit            : meins;
      @Semantics.currencyCode : true
      TransactionCurrency     : abap.cuky(5);
      @EndUserText.label      : 'Đơn giá trước chiết khấu'
      @UI.fieldGroup          : [{ qualifier: 'itemInfoValue', position: 10 }]
      NetPriceBeforeDiscount  : abap.fltp;
      @EndUserText.label      : 'Chiết khấu'
      @UI.fieldGroup          : [{ qualifier: 'itemInfoValue', position: 20 }]
      DiscountRate            : abap.fltp;
      @UI.fieldGroup          : [{ qualifier: 'itemInfoValue', position: 30 }]
      @EndUserText.label      : 'Đơn giá sau chiết khấu'
      NetPriceAfterDiscount   : abap.fltp;
      @UI.fieldGroup          : [{ qualifier: 'itemInfoValue', position: 40 }]
      @EndUserText.label      : 'Thành tiền'
      AmountBeforeTax         : abap.fltp;
      @EndUserText.label      : 'Thuế suất'
      @UI.fieldGroup          : [{ qualifier: 'itemInfoValue', position: 50 }]
      TaxRate                 : abap.fltp;
      @UI.fieldGroup          : [{ qualifier: 'itemInfoValue', position: 60 }]
      @EndUserText.label      : 'Tiền thuế'
      @UI.dataPoint           : { qualifier: 'TienThue', title: 'Tiền thuế'}
      TaxAmount               : abap.fltp;
      @UI.fieldGroup          : [{ qualifier: 'itemInfoValue', position: 70 }]
      @UI.dataPoint           : { qualifier: 'TienThanhToan', title: 'Tiền thanh toán'}
      @EndUserText.label      : 'Tiền thanh toán'
      AmountAfterTax          : abap.fltp;
      NoteKM                  : abap.char( 100 );
      ///////////////////////////////////////////////////////////////////////////////
      _Header                 : association to parent ZEINV_I_HOADON on  $projection.BillingDocument       = _Header.BillingDocument
                                                                     and $projection.sourcetype            = _Header.sourcetype
                                                                     and $projection.CompanyCode           = _Header.CompanyCode
                                                                     and $projection.AccountingDocument    = _Header.AccountingDocument
                                                                     and $projection.ReferenceSDDocument   = _Header.ReferenceSDDocument
                                                                     and $projection.PurchaseOrder         = _Header.PurchaseOrder
                                                                     and $projection.Plant                 = _Header.Plant
                                                                     and $projection.BillingAltUnit        = _Header.BillingAltUnit
                                                                     and $projection.AllBillingDetail      = _Header.AllBillingDetail
                                                                     and $projection.BillingGeneral        = _Header.BillingGeneral
                                                                     and $projection.SoThamKhao            = _Header.SoThamKhao
                                                                     and $projection.FiscalYear            = _Header.FiscalYear
                                                                     and $projection.LoaiHoaDon            = _Header.LoaiHoaDon
                                                                     and $projection.DispNSX               = _Header.DispNSX
                                                                     and $projection.DispValueDV           = _Header.DispValueDV
                                                                     and $projection.NumberFormatType      = _Header.NumberFormatType
                                                                     and $projection.Zpattern              = _Header.Zpattern
                                                                     and $projection.Zserial               = _Header.Zserial
                                                                     and $projection.XuatHoaDonHeadOffice  = _Header.XuatHoaDonHeadOffice
                                                                     and $projection.XuatHoaDonBillTo      = _Header.XuatHoaDonBillTo
                                                                     and $projection.LoaiNghiepVuDieuChinh = _Header.LoaiNghiepVuDieuChinh
                                                                     and $projection.FormatNumber          = _Header.FormatNumber;

}
