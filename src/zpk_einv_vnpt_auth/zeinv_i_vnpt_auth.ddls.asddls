@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Config auth for VNPT'
@Metadata.allowExtensions: true
define root view entity ZEINV_I_VNPT_AUTH
  as select from zeinv_vnpt_auth
{
  key companycode,
  key plant,
      comm_scenario,
      serviceurl,
      account,
      acpass,
      username,
      password
}
