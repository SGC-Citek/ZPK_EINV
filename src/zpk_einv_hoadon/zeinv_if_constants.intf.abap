INTERFACE zeinv_if_constants
  PUBLIC .

* Function constant
  CONSTANTS:
    func_draft                 TYPE c LENGTH 20 VALUE 'DRAFT',
    func_get_xml               TYPE c LENGTH 20 VALUE 'GETXML',
    func_get_published_pdf     TYPE c LENGTH 20 VALUE 'GETPUBLISHPDF',
    func_publish               TYPE c LENGTH 20 VALUE 'PUBLISH',
    func_get_draft             TYPE c LENGTH 20 VALUE 'GETDRAFT',
    func_replace               TYPE c LENGTH 20 VALUE 'REPLACE',
    func_get_xml_replace       TYPE c LENGTH 20 VALUE 'GETXML_REPLACE',
    func_get_draft_replace     TYPE c LENGTH 20 VALUE 'GETDRAFT_REPLACE',
    func_get_pdf_draft_replace TYPE c LENGTH 20 VALUE 'DRAFT_REPLACE',
    func_adjust                TYPE c LENGTH 20 VALUE 'ADJUST',
    func_get_xml_adjust        TYPE c LENGTH 20 VALUE 'GETXML_ADJUST',
    func_get_draft_adjust      TYPE c LENGTH 20 VALUE 'GETDRAFT_ADJUST',
    func_deldraft_adjust       TYPE c LENGTH 20 VALUE 'DELDRAFT_ADJUST',
    func_cancel                TYPE c LENGTH 20 VALUE 'CANCEL',
    func_deldraft              TYPE c LENGTH 20 VALUE 'DELDRAFT',
    func_deldraft_replace      TYPE c LENGTH 20 VALUE 'DELDRAFT_REPLACE',
    func_geteivno              TYPE c LENGTH 20 VALUE 'GETEIVNO',
    func_move                  TYPE c LENGTH 20 VALUE 'MOVE'.

* Loai hoa don
  CONSTANTS:
    view TYPE c LENGTH 4 VALUE 'VIEW',
    norm TYPE c LENGTH 4 VALUE 'NORM',
    canc TYPE c LENGTH 4 VALUE 'CANC',
    rep  TYPE c LENGTH 3 VALUE 'REP',
    adj  TYPE c LENGTH 3 VALUE 'ADJ',
    move TYPE c LENGTH 4 VALUE 'MOVE'.

* status of e-invoice
  CONSTANTS:
    status_drafted   TYPE c LENGTH 1 VALUE '5',
    status_published TYPE c LENGTH 1 VALUE '1',
    status_del_draf  TYPE c LENGTH 1 VALUE '3',
    status_init      TYPE c LENGTH 1 VALUE ` `,
    status_cancelled TYPE c LENGTH 1 VALUE '2'.


  CONSTANTS:
    icon_published     TYPE i VALUE 3,
    icon_not_processed TYPE i VALUE 2,
    icon_cancelled     TYPE i VALUE 1,
    icon_new           TYPE i VALUE 5,
    icon_neutral       TYPE i VALUE 0.


* status of e-invoice
  CONSTANTS:
    line_good_service TYPE c LENGTH 1 VALUE '0',
    line_promo        TYPE c LENGTH 1 VALUE '1',
    line_discount     TYPE c LENGTH 1 VALUE '2',
    line_note         TYPE c LENGTH 1 VALUE '4'.

  CONSTANTS:
    line_good_service_78 TYPE c LENGTH 1 VALUE '1',
    line_promo_78        TYPE c LENGTH 1 VALUE '2',
    line_discount_78     TYPE c LENGTH 1 VALUE '3',
    line_note_78         TYPE c LENGTH 1 VALUE '4'.

  CONSTANTS:
    adjust_inc  TYPE c LENGTH 1 VALUE '2',
    adjust_dec  TYPE c LENGTH 1 VALUE '3',
    adjust_info TYPE c LENGTH 1 VALUE '4'.
  CONSTANTS:
    BEGIN OF gc_tax_rate_id,
      _0pc               VALUE '1',
      _5pc               VALUE '2',
      _10pc              VALUE '3',
      khong_chiu_thue    VALUE '4',
      khong_ke_khai_thue VALUE '5',
      thue_khac          VALUE '6',
      _8pc               VALUE '9',
    END OF gc_tax_rate_id.
ENDINTERFACE.
