@AbapCatalog.sqlViewName: 'ZICUSTOMERSH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@ObjectModel.representativeKey: 'Customer'
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #S
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Search Help For Customer'

define view ZI_CUSTOMER_SH
  as select from I_Customer
{
  key Customer,
      CustomerFullName,
      CustomerName
}
