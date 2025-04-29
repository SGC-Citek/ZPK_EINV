@EndUserText.label: 'Table ZEIV02 - Cảng'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZI_ZEIV02_CANG
  as select from ztb_einv_pxkk_cf
  association to parent ZI_ZEIV02_CANG_S as _TableZeiv02CANGAll on $projection.SingletonID = _TableZeiv02CANGAll.SingletonID
{
      @Consumption.valueHelpDefinition:[ { entity: { name: 'i_customfieldcodelisttext', element: 'Code' }, additionalBinding: [{
                                             element: 'CustomFieldID', localConstant: 'YY1_PORT2', usage: #FILTER }] } ]
  key port         as Port,
      port_address as PortAddress,
      @Consumption.hidden: true
      1            as SingletonID,
      _TableZeiv02CANGAll

}
