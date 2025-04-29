@EndUserText.label: 'Maintain Billing Type'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZEINV_C_BILLTYPE_D
  as projection on ZEINV_I_BILLTYPE_D
{
           @Consumption.valueHelpDefinition: [{ entity: { name: 'I_BillingDocumentType', element: 'BillingDocumentType' } }]
           @ObjectModel.text.element: [ 'BillingDocumentTypeName' ]
  key      Billingtype,
           @Consumption.valueHelpDefinition: [{ entity: { name: 'I_SDDocumentReasonText', element: 'SDDocumentReason' },
                                            additionalBinding: [{ element: 'Language',localConstant: 'E',usage: #FILTER }] }]
  key      Orderreason,
           @Consumption.valueHelpDefinition: [{ entity: { name: 'I_AdditionalMaterialGroup1Text', element: 'AdditionalMaterialGroup1' },
                  additionalBinding: [{ element: 'Language', localConstant: 'E', usage: #FILTER }] }]
  key      Mvgr1,
           billingdocumenttypename,

           @Consumption.valueHelpDefinition: [{ entity: { name: 'ZEINV_I_BILL_NGHIEPVU', element: 'BillNghiepVu' } }]
           //      @ObjectModel.text.element: [ 'BillNghiepVu_Text' ]
           Billnghiepvu,
           BillNghiepVu_Text,
           Noprice,
           Nofidoc,
           Autoeinvoice,
           Note,
           NoteMvgr,

           @Consumption.hidden: true
           SingletonID,
           _BillingTypeAll : redirected to parent ZEINV_C_BILLTYPE_S

}
