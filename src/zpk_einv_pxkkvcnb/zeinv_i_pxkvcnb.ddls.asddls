@EndUserText.label: 'Phiếu xuất kho kiêm vận chuyển nội bộ'
@ObjectModel.query.implementedBy: 'ABAP:ZEINV_CL_PXKVCNB'
define custom entity ZEINV_I_PXKVCNB
{
      @UI                      : {

      facet                    : [
      //              { id             : 'headerTongThanhTien',
      //                purpose        : #HEADER,
      //                type           : #DATAPOINT_REFERENCE,
      //                position       : 10,
      //                targetQualifier: 'headerTongThanhTien'
      //              },
      //              { id             : 'companyCollection',
      //                type           : #COLLECTION,
      //                label          : 'Company Info',
      //                position       : 10
      //              },
      //              { id             : 'company',
      //                purpose        : #STANDARD,
      //                type           : #FIELDGROUP_REFERENCE,
      //                parentId       : 'companyCollection',
      //                position       : 10,
      //                targetQualifier: 'company'
      //              },
                    { id       : 'documentCollection',
                      type     : #COLLECTION,
                      label    : 'Document info',
                      position : 20
                    },
                    { id       : 'documentInfo',
                      purpose  : #STANDARD,
                      type     : #FIELDGROUP_REFERENCE,
                      parentId : 'documentCollection',
                      position : 20,
                      targetQualifier: 'documentInfo'
                    },
      //              { id             : 'valueCollection',
      //                type           : #COLLECTION,
      //                label          : 'Value information',
      //                position       : 20
      //              },
      //              { id             : 'valueGeneral',
      //                purpose        : #STANDARD,
      //                type           : #FIELDGROUP_REFERENCE,
      //                parentId       : 'valueCollection',
      //                position       : 10,
      //                targetQualifier: 'valueGeneral'
      //              },
              { id             : 'itemList',
                purpose        : #STANDARD,
                type           : #LINEITEM_REFERENCE,
                label          : 'Item List',
                position       : 30,
                targetElement  : '_Item'
              }] }

      @UI.hidden               : true
  key sourcetype               : zeinv_sourcetype;
      @UI.lineItem             : [{ position: 5 }]
      @UI.selectionField       : [{ position: 1 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_DeliveryDocumentStdVH', element: 'DeliveryDocument' } }]
  key DeliveryDocument         : vbeln_vl;
      @UI.lineItem             : [{ position: 2 }]
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ShippingPointStdVH', element: 'ShippingPoint' } } ]
  key Plant                    : werks_d;
      //      @UI.lineItem             : [{ position: 3 }]
  key PurchaseOrder            : ebeln;
      @UI.lineItem             : [{ position: 8 }]
      @UI.selectionField       : [{ position: 2 }]
  key MaterialDocument         : mblnr;
      @UI.lineItem             : [{ position: 9 }]
  key MaterialDocumentYear     : mjahr;
  key LoaiHoaDon               : abap.char(5); // dùng để phân biệt Hoá đơn bán(NORM) - hoá đơn điều chỉnh(ADJ) - Hoá đơn thay thế (REP)
      @UI.hidden               : true
  key AllMatDocDetail          : abap_boolean;
      @UI.hidden               : true
  key MatDocGeneral            : abap_boolean;
      @UI.lineItem             : [{ position: 6 }]
      @EndUserText.label       : 'Reference SD Document'
      @UI.selectionField       : [{ position: 3 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_SalesDocumentStdVH', element: 'SalesDocument' } }]
      ReferenceSDDocument      : vbeln_vl;
      @UI.lineItem             : [{ position: 2 }]
      @EndUserText.label       : 'Shipping Point'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_ShippingPointStdVH', element: 'ShippingPoint' } }]
      ShippingPoint            : abap.char(4);
      @UI.lineItem             : [{ position: 3 }]
      @EndUserText.label       : 'Shipping Point Name'
      ShippingPointName        : abap.char(30);
      @UI.lineItem             : [{ position: 4 }]
      @EndUserText.label       : 'Invoice Date'
      ActualGoodsMovementDate  : abap.dats;
      //      @UI.lineItem             : [{ position: 8 }]
      @ObjectModel.text.element: [ 'DeliveryDocumentTypeName' ]
      @EndUserText.label       : 'Delivery Type'
      DeliveryDocumentType     : abap.char(4);
      @UI.hidden               : true
      DeliveryDocumentTypeName : abap.char(30);
      @UI.lineItem             : [{ position: 10 }]
      @EndUserText.label       : 'Document Date'
      @UI.selectionField       : [{ position: 5 }]
      DocumentDate             : abap.dats;
      @UI.lineItem             : [{ position: 10 }]
      @EndUserText.label       : 'Creation Date'
      @UI.selectionField       : [{ position: 6 }]
      CreationDate             : abap.dats;
      @UI.lineItem             : [{ position: 9 }]
      @EndUserText.label       : 'Creation By'
      @UI.selectionField       : [{ position: 7 }]
      CreatedByUser            : usnam;
      //      @UI.lineItem             : [{ position: 13 }]
      //      MaterialDocument         : mblnr;
      //      @UI.lineItem             : [{ position: 14 }]
      //      MaterialDocumentYear     : mjahr;
      @EndUserText.label       : 'Kho xuất'
      @UI.lineItem             : [{ position: 15 }]
      //      @ObjectModel.text.element: [ 'IssuingPlantName' ]
      IssuingPlant             : abap.char(30);
      @EndUserText.label       : 'Tên Kho xuất'
      @UI.lineItem             : [{ position: 16 }]
      IssuingPlantName         : abap.char(125);
      @UI.lineItem             : [{ position: 17 }]
      @EndUserText.label       : 'Kho nhận'
      //            @ObjectModel.text.element: [ 'ReceivingPlantName' ]
      ReceivingPlant           : abap.char(30);
      @EndUserText.label       : 'Tên Kho nhận'
      @UI.lineItem             : [{ position: 18 }]
      ReceivingPlantName       : abap.char(125);
      @EndUserText.label       : 'Địa chỉ kho nhận'
      @UI.lineItem             : [{ position: 18 }]
      ReceivingAddress         : abap.char(255);
      Currency                 : waers;
      @UI.lineItem             : [{ position: 16 }]
      @EndUserText.label       : 'Purchase Order Date'
      PurchaseOrderDate        : abap.dats;
      @Semantics.amount.currencyCode: 'Currency'
      @UI.lineItem             : [{ position: 17 }]
      @EndUserText.label       : 'Tổng thành tiền'
      TongThanhTien            : fins_vwcur12;
      @UI.hidden               : true
      Cua                      : abap.char(100);
      @UI.hidden               : true
      VuViec                   : abap.char(100);
      @EndUserText.label       : 'Người vận chuyển'
      @UI.lineItem             : [{ position: 19 }]
      ShippingAgent            : abap.char(100);
      @EndUserText.label       : 'Hợp đồng số'
      @UI.lineItem             : [{ position: 20 }]
      HopDongSo                : abap.char(100);
      @EndUserText.label       : 'Phương tiện vận chuyển'
      @UI.lineItem             : [{ position: 21 }]
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 10 }]
      ShippingVehicle          : abap.char(100);
      @EndUserText.label       : 'Customer'
      @UI.lineItem             : [{ position: 13 }]
      //      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 10 }]
      Customer                 : zde_kunnr;

      //////E-Invoice Info
      Uuid                     : zeinv_fkey;
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 1 }]
      EInvoiceNo               : zeinv_einvoiceno;
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 2 }]
      @UI.lineItem             : [{ position: 31 }]
      EInvoiceNo_Long          : zeinv_einvoiceno_long;
      @UI.lineItem             : [{ position: 1, criticalityRepresentation: #WITH_ICON , criticality: 'UuidStatusCritical' }]
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 3, criticalityRepresentation: #WITH_ICON , criticality: 'UuidStatusCritical' }]
      @ObjectModel.text.element: [ 'UuidStatusName' ]
      UuidStatus               : zeinv_status;
      @UI.hidden               : true
      UuidStatusName           : abap.char(20);
      @UI.hidden               : true
      UuidStatusCritical       : abap.int1;
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 10 }]
      @EndUserText.label       : 'Serial'
      Zserial                  : zeinv_serial;
      @UI.fieldGroup           : [{ qualifier: 'documentInfo', position: 20 }]
      @EndUserText.label       : 'Pattern'
      Zpattern                 : zeinv_pattern;
      LenhDCNB                 : abap.char(30);
      @ObjectModel.filter.enabled: false
      @UI.hidden               : true
      VeViec                   : abap.char(125);
      //////Function property
      VisibilityPublishAction  : abap_boolean;
      VisibilityCancelAction   : abap_boolean;
      YY1_InPXKKVCNB_DLH       : abap_boolean;
      ///////////////////////////////////////////////////////////////////////////////////////////////////
      _Item                    : composition [1..*] of ZEINV_I_PXKVCNB_ITEM;
}
