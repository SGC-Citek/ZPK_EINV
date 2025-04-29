//*----------------------------------------------------------------------*
//* Citek JSC.
//* (C) Copyright Citek JSC.
//* All Rights Reserved
//*----------------------------------------------------------------------*
//* Application : Phiếu xuất kho kiêm vận chuyển nội bộ (item)
//* Creation Date: Jan 01, 2024
//* Created by: NganNM
//*----------------------------------------------------------------------*
@EndUserText.label: 'Phiếu xuất kho kiêm vận chuyển nội bộ'
@ObjectModel.query.implementedBy: 'ABAP:ZEINV_CL_PXKVCNB'
define custom entity ZEINV_I_PXKVCNB_ITEM
{
      @UI                      : {
        facet                  : [
                { id           : 'documentCollection',
                  type         : #COLLECTION,
                  label        : 'Document info',
                  position     : 10
                },
                { id           : 'documentInfo',
                  purpose      : #STANDARD,
                  type         : #FIELDGROUP_REFERENCE,
                  parentId     : 'documentCollection',
                  position     : 10,
                  targetQualifier  : 'documentInfo'
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
                  position     : 30,
                  targetQualifier  : 'valueGeneral'
                }] }
      @UI.hidden               : true
  key sourcetype               : zeinv_sourcetype;
      @UI.lineItem             : [{ position: 1 }]
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 1 }]
  key DeliveryDocument         : vbeln_vl;
      @UI.lineItem             : [{ position: 2 }]
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 3 }]
  key Plant                    : werks_d;
      @UI.lineItem             : [{ position: 3 }]
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 2 }]
  key PurchaseOrder            : ebeln;
      @UI.lineItem             : [{ position: 4 }]
      //      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 4 }]
  key DeliveryDocumentItem     : zde_posnr;
      @UI.lineItem             : [{ position: 5 }]
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 4 }]
  key MaterialDocument         : mblnr;
      @UI.lineItem             : [{ position: 7 }]
  key MaterialDocumentYear     : mjahr;
      @UI.lineItem             : [{ position: 6 }]
  key MaterialDocumentItem     : abap.numc(4 );
  key LoaiHoaDon               : abap.char(5); // dùng để phân biệt Hoá đơn bán(NORM) - hoá đơn điều chỉnh(ADJ) - Hoá đơn thay thế (REP)
      @UI.hidden               : true
  key AllMatDocDetail          : abap_boolean;
      @UI.hidden               : true
  key MatDocGeneral            : abap_boolean;
      @UI.lineItem             : [{ position: 4 }]
      @EndUserText.label       : 'E-Invoie item no'
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 6 }]
      ItemForEInVoice          : zeinv_itemno;
      @UI.lineItem             : [{ position: 5 }]
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 7 }]
      Product                  : matnr;
      @UI.lineItem             : [{ position: 5 }]
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 8 }]
      @EndUserText.label       : 'Tên hàng hoá'
      ItemText                 : abap.char(60);
      @EndUserText.label       : 'Đơn vị tính'
      @UI.lineItem             : [{ position: 6 }]
      DeliveryQuantityUnit     : meins;
      @UI.hidden               : true
      Des_DeliveryQuantityUnit : abap.char(3);
      @UI.hidden               : true
      DeliveryQuantityUnitName : abap.char(20);
      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      @EndUserText.label       : 'Thực xuất'
      @UI.lineItem             : [{ position: 7 }]
      ActualDeliveryQuantity   : menge_d;
      Currency                 : waers;
      @Semantics.amount.currencyCode: 'Currency'
      @EndUserText.label       : 'Đơn giá'
      @UI.lineItem             : [{ position: 8 }]
      MovingAveragePrice       : fins_vwcur12;
      @EndUserText.label       : 'Thành tiền'
      @Semantics.amount.currencyCode: 'Currency'
      @UI.lineItem             : [{ position: 9 }]
      Amount                   : fins_vwcur12;
      ///////////////////////////////////////////////////////////////////////////////
      @UI.fieldGroup           : [{ qualifier: 'itemInfo', position: 10 }]
      GoodTypeInEInvoice       : zeinv_issum_for_vnpt; // VNPT là ISSUM
      //////E-Invoice value
      //      ItemForEInVoice          : zeinv_itemno; // key item riêng cho E-Invoice ( trường hợp gộp/ tách dòng)
      ///////////////////////////////////////////////////////////////////////////////
      _Header                  : association to parent ZEINV_I_PXKVCNB on  $projection.DeliveryDocument     = _Header.DeliveryDocument
                                                                       and $projection.Plant                = _Header.Plant
                                                                       and $projection.PurchaseOrder        = _Header.PurchaseOrder
                                                                       and $projection.MaterialDocument     = _Header.MaterialDocument
                                                                       and $projection.MaterialDocumentYear = _Header.MaterialDocumentYear
                                                                       and $projection.LoaiHoaDon           = _Header.LoaiHoaDon
                                                                       and $projection.sourcetype           = _Header.sourcetype
                                                                       and $projection.AllMatDocDetail      = _Header.AllMatDocDetail
                                                                       and $projection.MatDocGeneral        = _Header.MatDocGeneral;


}
