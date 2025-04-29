@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Config mẫu số ký hiệu cho - ZEIV03'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZEINV_I_CONFIG
  as select from    zeinv_tb_config
    left outer join ZEINV_I_TYPE on ZEINV_I_TYPE.TYPE = zeinv_tb_config.type

{
         @Consumption.valueHelpDefinition: [{ entity: { name: 'ZEINV_I_TYPE', element: 'TYPE' } }]
         @ObjectModel.text.element: [ 'TYPE_TEXT' ]
  key    zeinv_tb_config.type,
         @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CompanyCodeStdVH', element: 'CompanyCode' } }]
  key    zeinv_tb_config.companycode,
         @Consumption.valueHelpDefinition: [{ entity: { name: 'I_PlantStdVH', element: 'Plant' } }]
  key    zeinv_tb_config.plant,
         @Consumption.valueHelpDefinition: [{ entity: { name: 'ZEINV_I_SOURCETYPE', element: 'sourcetype' } }]
  key    zeinv_tb_config.sourcetype,
         zeinv_tb_config.validfrom,
         zeinv_tb_config.validto,
         zeinv_tb_config.zserial,
         zeinv_tb_config.zpattern,
         zeinv_tb_config.zserialcert,
         ZEINV_I_TYPE.TYPE_TEXT
}
