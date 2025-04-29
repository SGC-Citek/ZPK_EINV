@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Batch NCC Characteristic value - YB_SUPPLIER_BATCH_NUMBER'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi_batch_ncc
  as select from I_Batch
    inner join   I_ClfnObjectCharcValForKeyDate(P_KeyDate: $session.system_date) on I_ClfnObjectCharcValForKeyDate.ClfnObjectInternalID = I_Batch.ClfnObjectInternalID
    inner join   I_ClfnCharacteristic                                            on  I_ClfnCharacteristic.CharcInternalID = I_ClfnObjectCharcValForKeyDate.CharcInternalID
                                                                                 and I_ClfnCharacteristic.Characteristic  = 'YB_SUPPLIER_BATCH_NUMBER'
{
      @UI.selectionField: [{ position: 10 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_ProductStdVH', element: 'Product' } }]
  key I_Batch.Material,
      @UI.selectionField: [{ position: 20 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_PlantStdVH', element: 'Plant' } }]
  key I_Batch.Plant,
      @UI.selectionField: [{ position: 30 }]
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_BatchStdVH', element: 'Batch' } }]
  key I_Batch.Batch,
      @UI.selectionField: [{ position: 40 }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      // key I_BatchDistinct.ClfnObjectInternalID,
      I_ClfnObjectCharcValForKeyDate.CharcValue,
      I_Batch.BatchBySupplier
}
