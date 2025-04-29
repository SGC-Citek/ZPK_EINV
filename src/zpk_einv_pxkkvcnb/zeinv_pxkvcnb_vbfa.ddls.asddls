@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view VBFA'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZEINV_PXKVCNB_VBFA
  as select from I_SDDocumentMultiLevelProcFlow as VBFA
{
  key DocRelationshipUUID,
      PrecedingDocument,
      PrecedingDocumentItem,
      BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      QuantityInBaseUnit
}
where
  VBFA.SubsequentDocumentCategory = 'Q'
