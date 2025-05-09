@EndUserText.label: 'Test'
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED
}
define view entity ZEINV_I_TEST as select from I_BillingDocumentPrcgElmnt
{
    key BillingDocument,
    key PricingProcedureStep,
    key PricingProcedureCounter,
    ConditionApplication,
    ConditionType,
    PricingDateTime,
    PriceConditionDeterminationDte,
    ConditionCalculationType,
    ConditionBaseValue,
    ConditionRateValue,
    ConditionCurrency,
    ConditionQuantity,
    ConditionQuantityUnit,
    ConditionCategory,
    ConditionIsForStatistics,
    PricingScaleType,
    IsRelevantForAccrual,
    CndnIsRelevantForInvoiceList,
    ConditionOrigin,
    IsGroupCondition,
    ConditionRecord,
    ConditionSequentialNumber,
    TaxCode,
    WithholdingTaxCode,
    CndnRoundingOffDiffAmount,
    ConditionAmount,
    TransactionCurrency,
    ConditionControl,
    ConditionInactiveReason,
    ConditionClass,
    PrcgProcedureCounterForHeader,
    FactorForConditionBasisValue,
    StructureCondition,
    PeriodFactorForCndnBasisValue,
    PricingScaleBasis,
    ConditionScaleBasisValue,
    ConditionScaleBasisUnit,
    ConditionScaleBasisCurrency,
    CndnIsRelevantForIntcoBilling,
    ConditionIsManuallyChanged,
    ConditionIsForConfiguration,
    VariantCondition,
    ConditionRateAmount,
    ConditionBaseAmount,
    ConditionBaseQuantity,
    ConditionRateRatio,
    ConditionRateRatioUnit,
    ConditionScaleBaseAmount,
    ConditionScaleBaseQuantity
}
