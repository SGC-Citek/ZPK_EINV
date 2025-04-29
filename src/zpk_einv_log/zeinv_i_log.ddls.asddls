@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Log for E-Invoice Integration'
@Metadata.allowExtensions: true
define root view entity ZEINV_i_LOG
  as select from zeinv_tb_log
{
  key log_id,
  key uuid,
  key type,
  key function,
      message,
      body,
      logtime,
      logdate,
      loguser
}
