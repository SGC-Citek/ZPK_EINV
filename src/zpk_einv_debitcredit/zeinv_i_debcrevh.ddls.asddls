@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Debit/credit type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.supportedCapabilities:[#CDS_MODELING_DATA_SOURCE,#VALUE_HELP_PROVIDER]
define view entity ZEINV_I_DEBCREVH
  as select from zeinv_tb_debcre
{
      @ObjectModel.text.element: [ 'description' ]
      @UI.lineItem: [{ position: 1 }]
      @EndUserText.label: 'Type'
  key type,
      description            
}
