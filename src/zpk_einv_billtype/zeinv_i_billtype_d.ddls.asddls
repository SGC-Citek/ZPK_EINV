@EndUserText.label: 'Billing Type'
@AccessControl.authorizationCheck: #CHECK
define view entity ZEINV_I_BILLTYPE_D
  as select from zeinv_tb_billtyp
  association        to parent ZEINV_I_BILLTYPE_S as _BillingTypeAll on  $projection.SingletonID = _BillingTypeAll.SingletonID
  association [0..1] to I_BillingDocumentTypeText_2                  on  I_BillingDocumentTypeText_2.BillingDocumentType = $projection.Billingtype
                                                                     and I_BillingDocumentTypeText_2.Language            = 'E'
  association [0..1] to ZEINV_I_BILL_NGHIEPVU                        on  ZEINV_I_BILL_NGHIEPVU.BillNghiepVu = $projection.Billnghiepvu
{

  key     billingtype                                         as Billingtype,
  key     orderreason                                         as Orderreason,
  key     mvgr1                                               as Mvgr1,
          I_BillingDocumentTypeText_2.BillingDocumentTypeName as billingdocumenttypename,

          ZEINV_I_BILL_NGHIEPVU.BillNghiepVu_Text,
          billnghiepvu                                        as Billnghiepvu,
          noprice                                             as Noprice,
          nofidoc                                             as Nofidoc,
          autoeinvoice                                        as Autoeinvoice,
          note                                                as Note,
          note_mvgr1                                          as NoteMvgr,
          1                                                   as SingletonID,
          _BillingTypeAll

}
