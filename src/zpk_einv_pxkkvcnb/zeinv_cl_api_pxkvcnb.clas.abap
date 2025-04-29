*----------------------------------------------------------------------*
* Citek JSC.
* (C) Copyright Citek JSC.
* All Rights Reserved
*----------------------------------------------------------------------*
* Application : Send data to VNPT and save log
* Creation Date: Jan 7, 2024 8:44:25 PM
* Created by: NganNM
*----------------------------------------------------------------------*
CLASS zeinv_cl_api_pxkvcnb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_http_service_extension .
    INTERFACES zeinv_if_constants .

    TYPES:
      BEGIN OF ty_request_data_hdr,
        uuid                    TYPE string,
        uuidstatus              TYPE string,
        deliverydocument        TYPE string,
        plant                   TYPE string,
        purchaseorder           TYPE string,
        referencesddocument     TYPE string,
        shippingpoint           TYPE string,
        actualgoodsmovementdate TYPE string,
        deliverydocumenttype    TYPE string,
        documentdate            TYPE string,
        creationdate            TYPE string,
        cua                     TYPE string,
        vuviec                  TYPE string,
        shippingagent           TYPE string,
        hopdongso               TYPE string,
        shippingvehicle         TYPE string,
        zpattern                TYPE string,
        zserial                 TYPE string,
        purchaseorderdate       TYPE string,
        currency                TYPE string,
        issuingplantname        TYPE string,
        receivingplantname      TYPE string,
        materialdocument        TYPE string,
        materialdocumentyear    TYPE string,
        einvoiceno              TYPE string,
        lenhdcnb                TYPE string,
        shippingpointname       TYPE string,
        receivingaddress        TYPE string,
        veviec                  TYPE string,
      END OF ty_request_data_hdr,

      BEGIN OF ty_request_data_item,
        deliverydocument         TYPE string,
        plant                    TYPE string,
        purchaseorder            TYPE string,
        deliverydocumentitem     TYPE string,
        product                  TYPE string,
        deliveryquantityunit     TYPE string,
        actualdeliveryquantity   TYPE string,
        movingaverageprice       TYPE string,
        amount                   TYPE string,
        itemtext                 TYPE string,
        goodtypeineinvoice       TYPE string,
        itemforeinvoice          TYPE string,
        deliveryquantityunitname TYPE string,
        des_deliveryquantityunit TYPE string,
      END OF ty_request_data_item,
      BEGIN OF ty_data,
        uuid   TYPE zeinv_fkey,
        header TYPE zeinv_i_pxkvcnb,
        item   TYPE STANDARD TABLE OF zeinv_i_pxkvcnb_item WITH EMPTY KEY,
      END OF ty_data,
      BEGIN OF ty_request_data,
        function TYPE string,
        header   TYPE ty_request_data_hdr,
        item     TYPE STANDARD TABLE OF ty_request_data_item WITH EMPTY KEY,
      END OF ty_request_data,
      BEGIN OF ty_response_data,
        status     TYPE string,
        message    TYPE string,
        uuid       TYPE string,
        pdf        TYPE string,
        einvoiceno TYPE string,
        messages   TYPE STANDARD TABLE OF zeinv_st_response WITH EMPTY KEY,
      END OF ty_response_data.

    DATA:
      request_data  TYPE ty_request_data,
      response_data TYPE ty_response_data,
      data          TYPE ty_data.

    DATA:
      gs_auth          TYPE zeinv_vnpt_auth,
      gv_proxy_publish TYPE REF TO zeinv_co_publish_service_soap,
      gv_proxy_portal  TYPE REF TO zeinv_co_portal_service_soap,
      gv_vnpt_service  TYPE REF TO zeinv_cl_vnpt_service_soap.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS check_data.
    METHODS create_proxy.
    METHODS format_xml_import RETURNING VALUE(xml) TYPE string.
    METHODS import_inv RAISING zeinv_cx_vnpt_service.
    METHODS publish_invoice RAISING zeinv_cx_vnpt_service.
    METHODS cancel_invoice RAISING zeinv_cx_vnpt_service.
    METHODS get_pdf
      RETURNING VALUE(pdf_string) TYPE string
      RAISING   zeinv_cx_vnpt_service.
    METHODS vnpt_delete_draft.
    METHODS  get_pdf_published
      RETURNING VALUE(pdf_string) TYPE string
      RAISING   zeinv_cx_vnpt_service.
* lấy số hoá đơn đồng bộ SAP
    METHODS get_invoice_no
      RAISING zeinv_cx_vnpt_service.
ENDCLASS.



CLASS ZEINV_CL_API_PXKVCNB IMPLEMENTATION.


  METHOD cancel_invoice.
    DATA:
      lv_einvoiceno  TYPE zeinv_einvoiceno,

      ls_zeinv_pxk   TYPE zeinv_tb_pxk,
      ls_zeinv_pxk_i TYPE zeinv_tb_pxk_i.

    IF data-header-uuidstatus = zeinv_if_constants=>status_published.
      DATA(request_cancel_inv) = VALUE zeinv_cancel_inv_soap_in(
          user_name = gs_auth-username
          user_pass = gs_auth-password
          account   = gs_auth-account
          acpass    = gs_auth-acpass
          fkey      = data-header-uuid
      ).
      gv_vnpt_service->cancel_inv(
        EXPORTING
          input = request_cancel_inv
          fkey  = data-header-uuid
        IMPORTING
          code  = DATA(lv_code) ).
      IF lv_code = 'OK'.
        UPDATE zeinv_tb_pxk SET uuidstatus = @zeinv_if_constants~status_cancelled
                           WHERE uuid = @data-header-uuid.
        COMMIT WORK AND WAIT.
        response_data-status = 'S'.
        response_data-message = |Cancel thành công phiếu xuất kho { data-header-einvoiceno_long }|.
      ENDIF.

    ENDIF.
  ENDMETHOD.


  METHOD check_data.
    TYPES: BEGIN OF lty_date,
             year  TYPE c LENGTH 4,
             a     TYPE c LENGTH 1,
             month TYPE c LENGTH 2,
             b     TYPE c LENGTH 1,
             date  TYPE c LENGTH 2,
           END OF lty_date.
    DATA: ls_date TYPE lty_date.
    DATA: lv_matnr18 TYPE n LENGTH 18.
    data-header = CORRESPONDING #( request_data-header EXCEPT actualgoodsmovementdate documentdate creationdate purchaseorderdate ) .
    data-header-deliverydocument = |{ request_data-header-deliverydocument ALPHA = IN }|.
    data-header-purchaseorder = |{ request_data-header-purchaseorder ALPHA = IN }|.
    data-header-referencesddocument = |{ request_data-header-referencesddocument ALPHA = IN }|.
    data-header-materialdocument = |{ request_data-header-materialdocument ALPHA = IN }|.
    data-uuid = data-header-uuid.
    IF  data-header-zpattern IS INITIAL OR data-header-zserial IS INITIAL.
      response_data-status = 'F'.
      response_data-message = 'Check cấu hình mẫu số ký hiệu'.
      RETURN.
    ENDIF.

    IF request_data-header-actualgoodsmovementdate IS NOT INITIAL.
      CONDENSE request_data-header-actualgoodsmovementdate.
      data-header-actualgoodsmovementdate = |{ request_data-header-actualgoodsmovementdate(4) }{ request_data-header-actualgoodsmovementdate+5(2) }{ request_data-header-actualgoodsmovementdate+8(2) }|.
    ENDIF.

    IF request_data-header-purchaseorderdate IS NOT INITIAL.
      CONDENSE request_data-header-purchaseorderdate.
      data-header-purchaseorderdate = |{ request_data-header-purchaseorderdate(4) }{ request_data-header-purchaseorderdate+5(2) }{ request_data-header-purchaseorderdate+8(2) }|.
    ENDIF.

    IF request_data-header-documentdate IS NOT INITIAL.
      CONDENSE request_data-header-documentdate.
      data-header-documentdate = |{ request_data-header-documentdate(4) }{ request_data-header-documentdate+5(2) }{ request_data-header-documentdate+8(2) }|.
    ENDIF.

    LOOP AT request_data-item REFERENCE INTO DATA(ls_request_item).

      IF ls_request_item->product CO '0123456789'.
        lv_matnr18 = |{ ls_request_item->product ALPHA = IN }|.
        ls_request_item->product = lv_matnr18.
      ENDIF.
      APPEND VALUE #(
        deliverydocument       = |{ ls_request_item->deliverydocument }|
        plant                  = ls_request_item->plant
        purchaseorder          = |{ ls_request_item->purchaseorder }|
        deliverydocumentitem   = |{ ls_request_item->deliverydocumentitem }|
        product                = ls_request_item->product
        deliveryquantityunit   = ls_request_item->deliveryquantityunit
        deliveryquantityunitname   = ls_request_item->deliveryquantityunitname
        des_deliveryquantityunit = ls_request_item->des_deliveryquantityunit
        actualdeliveryquantity = ls_request_item->actualdeliveryquantity
        movingaverageprice     = ls_request_item->movingaverageprice
        itemtext               = ls_request_item->itemtext
        goodtypeineinvoice     = ls_request_item->goodtypeineinvoice
        itemforeinvoice        = ls_request_item->itemforeinvoice
        amount                 = ls_request_item->amount
      ) TO data-item.
    ENDLOOP.
  ENDMETHOD.


  METHOD create_proxy.
    DATA:
      lr_destination_publish TYPE REF TO if_proxy_destination,
      lr_destination_portal  TYPE REF TO if_proxy_destination.
    SELECT SINGLE * FROM zeinv_vnpt_auth WHERE plant = @data-header-plant INTO @gs_auth.
    gv_vnpt_service = NEW zeinv_cl_vnpt_service_soap( i_auth = gs_auth i_type = '2' ).
  ENDMETHOD.


  METHOD format_xml_import.
    DATA:
      xml_items   TYPE string,
      lv_tgtttbso TYPE fins_vwcur12.
    LOOP AT data-item INTO DATA(ls_item).
      xml_items =   |{ xml_items }|
                 && |<HHDVu>|
                     && |<TChat><![CDATA[{ ls_item-goodtypeineinvoice }]]></TChat>|
                     && |<MHHDVu>{ ls_item-product }</MHHDVu>|
                     && |<THHDVu><![CDATA[{ ls_item-itemtext }]]></THHDVu>|
                     && |<SLuong>{ ls_item-actualdeliveryquantity }</SLuong>|
                     && |<DVTinh>{ ls_item-deliveryquantityunitname  }</DVTinh>|
                     && |<DGia>{ ls_item-movingaverageprice  }</DGia>|
                     && |<ThTien>{ ls_item-amount }</ThTien>|
                 && |</HHDVu>| .
      lv_tgtttbso += ls_item-amount.
    ENDLOOP.

    xml =   |<DSHDon>|
         && |<HDon>|
         && |<key>{ data-uuid }</key>|
         && |<DLHDon>|
         && |<TTChung>|
         && |<DVTTe>{ data-header-currency }</DVTTe>|
         && |<TGia>1</TGia>|
         && |<TTKhac>|
              && |<TTin>|
                 && |<TTruong>Extra</TTruong>|
                 && |<KDLieu>string</KDLieu>|
                 && |<DLieu><![CDATA[{ data-header-shippingpointname }]]></DLieu>|
              && |</TTin>|
              && |<TTin>|
                    && |<TTruong>Extra1</TTruong>|
                    && |<KDLieu>string</KDLieu>|
                    && |<DLieu>{ data-header-receivingplantname }</DLieu>|
              && |</TTin>|
              && |<TTin>|
                    && |<TTruong>Extra2</TTruong>|
                    && |<KDLieu>string</KDLieu>|
                    && |<DLieu>{ data-header-veviec }</DLieu>|
              && |</TTin>|

         && |</TTKhac>|
         && |</TTChung>|
               && |<NDHDon>|
                 && |<NBan>|
                        && |<LDDNBo>{ data-header-lenhdcnb }</LDDNBo>|
                        && |<HVTNXHang>{ data-header-shippingagent }</HVTNXHang>|
                        && |<HDSo><![CDATA[{ data-header-hopdongso }]]></HDSo>|
                        && |<TNVChuyen>{ data-header-shippingagent }</TNVChuyen>|
                        && |<PTVChuyen><![CDATA[{ data-header-shippingvehicle }]]></PTVChuyen>|
                        && |<HDKTSo>{ data-header-referencesddocument }</HDKTSo>|
                        && |<HDKTNgay>{ data-header-purchaseorderdate(4) }-{ data-header-purchaseorderdate+4(2) }-{ data-header-purchaseorderdate+6(2) }</HDKTNgay>|
                 && |</NBan>|
                 && |<NMua>|
                           && |<DChi><![CDATA[{ data-header-receivingaddress }]]></DChi>|
                           && |<TTKhac>|
                               && |<TTin>|
                               && |<TTruong>Extra6</TTruong>|
                               && |<KDLieu>string</KDLieu>|
                               && |<DLieu><![CDATA[{ data-header-receivingplantname }]]></DLieu>|
                               && |</TTin>|
                           && |</TTKhac>|
                  && |</NMua>|
            && |<DSHHDVu>|
                 && |{ xml_items }|
            && |</DSHHDVu>|
            && |<TToan><TgTTTBSo>{ lv_tgtttbso }</TgTTTBSo></TToan>|
            && |</NDHDon>|
            && |</DLHDon>|
            && |</HDon>|
            && |</DSHDon>|.
  ENDMETHOD.


  METHOD get_invoice_no.
    DATA:
      lv_einvoiceno  TYPE zeinv_einvoiceno,

      ls_zeinv_pxk   TYPE zeinv_tb_pxk,
      ls_zeinv_pxk_i TYPE zeinv_tb_pxk_i,
      lv_pulishdate  TYPE cl_abap_context_info=>ty_system_date.
    DATA(request_pdf) = VALUE zeinv_list_inv_by_cus_fkey_so1(
       user_name = gs_auth-username
       user_pass = gs_auth-password
       key       = data-header-uuid
   ).
    TRY.
        gv_vnpt_service->find_invoice_fkey(
           EXPORTING
             fkey  = data-header-uuid
             input = request_pdf
           IMPORTING
           code       = DATA(lv_code)
           einvoiceno = lv_einvoiceno
           pulishdate = lv_pulishdate
            ).
        IF lv_code = 'OK'.
          ls_zeinv_pxk = CORRESPONDING #( data-header ).

          ls_zeinv_pxk-uuidstatus = zeinv_if_constants~status_published.
          ls_zeinv_pxk-einvoiceno = lv_einvoiceno.
          ls_zeinv_pxk-einvoiceno_long = |{ data-header-zpattern(1) }{ data-header-zserial }.{ lv_einvoiceno }|.
          ls_zeinv_pxk-ngayphathanhhoadon = lv_pulishdate.
          MODIFY zeinv_tb_pxk FROM @ls_zeinv_pxk.
          response_data-status = 'S'.
          response_data-message = |Phát hành thành công hoá đơn { ls_zeinv_pxk-einvoiceno_long }|.
          response_data-einvoiceno = lv_einvoiceno.
          LOOP AT data-item REFERENCE INTO DATA(ls_item).
            CLEAR ls_zeinv_pxk_i.
            ls_zeinv_pxk_i =  CORRESPONDING #( ls_item->* ).
            ls_zeinv_pxk_i-uuid = ls_zeinv_pxk-uuid.
            MODIFY zeinv_tb_pxk_i FROM @ls_zeinv_pxk_i.
          ENDLOOP.
        ELSEIF lv_code = 'ERROR'.
          response_data-status = 'F'.
          response_data-message = |PartnerInvoiceStringID: { data-header-uuid } chưa được phát hành|.
        ENDIF.
      CATCH zeinv_cx_vnpt_service INTO DATA(lx_vnpt_service).
        RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = lx_vnpt_service->get_textid( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD get_pdf.
    DATA(request_new_pdf) = VALUE zeinv_download_new_inv_pdffke1(
        user_name = gs_auth-username
        user_pass = gs_auth-password
        fkey      = data-header-uuid
    ).

    TRY.
        pdf_string = gv_vnpt_service->download_new_inv_pdffkey(
          EXPORTING
            fkey  = data-header-uuid
            input = request_new_pdf ).
      CATCH zeinv_cx_vnpt_service INTO DATA(lx_vnpt_service).
        RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = lx_vnpt_service->get_textid( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD get_pdf_published.
    DATA(request_pdf) = VALUE zeinv_download_inv_pdffkey_no1(
           user_name = gs_auth-username
           user_pass = gs_auth-password
           fkey      = data-header-uuid
       ).
    TRY.
        pdf_string = gv_vnpt_service->download_inv_pdffkey_no_pay(
          EXPORTING
            fkey  = data-header-uuid
            input = request_pdf ).
      CATCH zeinv_cx_vnpt_service INTO DATA(lx_vnpt_service).
        RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = lx_vnpt_service->get_textid( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD if_http_service_extension~handle_request.
*$-----------------------------------------------------------$
* Handle request
*$-----------------------------------------------------------$
    DATA:
      request_method TYPE string,
      request_body   TYPE string,
      response_body  TYPE string.
    request_method = request->get_header_field( i_name = '~request_method' ).
    request_body = request->get_text( ).

    CASE request_method.
      WHEN 'POST'.

        xco_cp_json=>data->from_string( request_body )->apply(
        VALUE #(
        ( xco_cp_json=>transformation->boolean_to_abap_bool )
        ( xco_cp_json=>transformation->underscore_to_camel_case )
        ) )->write_to( REF #( request_data ) ).

        check_data(  ).
        create_proxy(  ).
        response_data-uuid = data-header-uuid.
        IF response_data-status = 'F'.
          response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                         ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).
          response->set_text( i_text = response_body ).
          RETURN.
        ELSE.
          TRY.

              CASE request_data-function.
                  """""""""""""""""""""""""""""""""""""""""""""""""""""""
                  "Create draft
                  """""""""""""""""""""""""""""""""""""""""""""""""""""""
                WHEN zeinv_if_constants~func_draft.
                  IF data-header-uuidstatus <> zeinv_if_constants=>status_drafted.
                    import_inv(  ).
                  ENDIF.
                  response_data-pdf = get_pdf( ).
                  response_data-status = 'S'.
                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).

                  """""""""""""""""""""""""""""""""""""""""""""""""""""""
                  "Delete draft
                  """""""""""""""""""""""""""""""""""""""""""""""""""""""
                WHEN  zeinv_if_constants~func_deldraft.
                  IF data-header-uuidstatus <> zeinv_if_constants=>status_drafted.
                    response_data-status = 'F'.
                    response_data-message = |PartnerInvoiceStringID: { data-header-uuid } Chưa tồn tại Hóa đơn nháp|.
                    RETURN.
                  ENDIF.
                  vnpt_delete_draft(  ).
                  response_data-status  = 'S'.
                  response_data-uuid    = data-header-uuid.
                  response_data-message = |Xóa draft thành công|.
                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).
                  """""""""""""""""""""""""""""""""""""""""""""""""""""""
                  "Publish
                  """""""""""""""""""""""""""""""""""""""""""""""""""""""
                WHEN  zeinv_if_constants~func_publish.
                  DATA(lw_user) = sy-uname.
                  AUTHORITY-CHECK OBJECT 'ZAO_ZEINV2'
                  ID 'ACTVT' FIELD '01'
                  ID 'ZAF_ZEINV2' FIELD lw_user.
                  IF sy-subrc <> 0.
                    response_data-status  = 'F'.
                    response_data-message = |Không có quyền để thực hiện Publish|.
                  ELSE.
                    IF data-header-uuidstatus <> zeinv_if_constants=>status_drafted.
                      response_data-status = 'F'.
                      response_data-message = |PartnerInvoiceStringID: { data-header-uuid } Chưa tồn tại Hóa đơn nháp|.
                    ELSE.
                      publish_invoice(  ).
*                      get_invoice_no( ).
                    ENDIF.
                  ENDIF.

                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).
                  """""""""""""""""""""""""""""""""""""""""""""""""""""""
                  "Cancel
                  """""""""""""""""""""""""""""""""""""""""""""""""""""""
                WHEN  zeinv_if_constants~func_cancel.
                  cancel_invoice(  ).
                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).

                  """""""""""""""""""""""""""""""""""""""""""""""""""""""
                  "Get publish PDF
                  """""""""""""""""""""""""""""""""""""""""""""""""""""""
                WHEN zeinv_if_constants=>func_get_published_pdf.
                  IF data-header-uuidstatus  = zeinv_if_constants=>status_published.
                    response_data-einvoiceno = data-header-einvoiceno.
                    response_data-pdf        = get_pdf_published( ).
                    response_data-status     = 'S'.
                    response_body            = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                   ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).
                  ELSE.
                    response_data-status = 'F'.
                    response_data-message = |PartnerInvoiceStringID: { data-header-uuid } chưa được phát hành|.
                  ENDIF.
                WHEN zeinv_if_constants~func_get_xml.
                  response_body = format_xml_import( ).



              ENDCASE.
            CATCH zeinv_cx_vnpt_service INTO DATA(lx_vnpt_service).
              response_data-message = lx_vnpt_service->get_longtext(  ).
              response_data-status = 'F'.
              response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                             ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).
          ENDTRY.
          response->set_text( i_text = response_body ).
        ENDIF.

    ENDCASE.
  ENDMETHOD.


  METHOD import_inv.
    DATA:
      ls_zeinv_pxk   TYPE zeinv_tb_pxk,
      ls_zeinv_pxk_i TYPE zeinv_tb_pxk_i.
    TRY.
        IF data-header-uuidstatus =  zeinv_if_constants~status_drafted.
          DATA(request_delete_draft) = VALUE zeinv_delete_invoice_by_fkey_1(
               account  = gs_auth-account
               acpass   = gs_auth-acpass
               lst_fkey = |{ data-header-uuid }|
               username = gs_auth-username
               password = gs_auth-password ).

          gv_vnpt_service->delete_invoice_by_fkey(
            EXPORTING
              input = request_delete_draft
              fkey  = data-header-uuid
            IMPORTING
              code  = DATA(lv_delete_code) ).
          ls_zeinv_pxk = CORRESPONDING #( data-header ).
          ls_zeinv_pxk-uuidstatus = ''.
          MODIFY zeinv_tb_pxk FROM @ls_zeinv_pxk.
          COMMIT WORK AND WAIT.
        ENDIF.

        DATA(request_import) = VALUE zeinv_import_inv_by_pattern_s1(
            account      = gs_auth-account
            acpass       = gs_auth-acpass
            xml_inv_data = format_xml_import( )
            username     = gs_auth-username
            password     = gs_auth-password
            pattern      = data-header-zpattern
            serial       = data-header-zserial
        ).
        gv_vnpt_service->import_inv_by_pattern(
          EXPORTING
            input = request_import
            fkey  = data-header-uuid
          IMPORTING
            code  = DATA(lv_import_code) ).
        IF lv_import_code = 'OK'.
          ls_zeinv_pxk = CORRESPONDING #( data-header ).
          ls_zeinv_pxk-uuidstatus = zeinv_if_constants~status_drafted.
          MODIFY zeinv_tb_pxk FROM @ls_zeinv_pxk.

          LOOP AT data-item REFERENCE INTO DATA(ls_item).
            CLEAR ls_zeinv_pxk_i.
            ls_zeinv_pxk_i =  CORRESPONDING #( ls_item->* ).
            ls_zeinv_pxk_i-uuid = ls_zeinv_pxk-uuid.
            MODIFY zeinv_tb_pxk_i FROM @ls_zeinv_pxk_i.
          ENDLOOP.
          COMMIT WORK.
        ENDIF.
      CATCH zeinv_cx_vnpt_service INTO DATA(lx_vnpt_service).
        RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = lx_vnpt_service->get_textid( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD publish_invoice.
    DATA:
      lv_einvoiceno  TYPE zeinv_einvoiceno,

      ls_zeinv_pxk   TYPE zeinv_tb_pxk,
      ls_zeinv_pxk_i TYPE zeinv_tb_pxk_i.

    DATA: lv_function TYPE string.
    TRY.
        IF data-header-uuidstatus = zeinv_if_constants=>status_drafted.
          lv_function = 'PublishInvFkey'.
          DATA(request_publish_fkey) = VALUE zeinv_publish_inv_fkey_soap_in(
              username = gs_auth-username
              password = gs_auth-password
              account  = gs_auth-account
              acpass   = gs_auth-acpass
              pattern  = data-header-zpattern
              serial   = data-header-zserial
              ls_fkey  = data-header-uuid
          ).
          gv_vnpt_service->publish_inv_fkey(
            EXPORTING
              input      = request_publish_fkey
              fkey       = data-header-uuid
            IMPORTING
              code       = DATA(lv_code)
              einvoiceno = lv_einvoiceno ).
          IF lv_code = 'OK'.

            ls_zeinv_pxk = CORRESPONDING #( data-header ).
            ls_zeinv_pxk-uuidstatus = zeinv_if_constants~status_published.
            ls_zeinv_pxk-einvoiceno = lv_einvoiceno.
            ls_zeinv_pxk-einvoiceno_long = |{ data-header-zpattern(1) }{ data-header-zserial }.{ lv_einvoiceno }|.
            "GET CURRENT TIME
            GET TIME STAMP FIELD DATA(lw_timestamp).
            CONVERT TIME STAMP lw_timestamp TIME ZONE 'UTC+7'
            INTO DATE DATA(lw_cr_date) TIME DATA(lw_cr_time)
            DAYLIGHT SAVING TIME DATA(dst).
            ls_zeinv_pxk-ngayphathanhhoadon = lw_cr_date.
            MODIFY zeinv_tb_pxk FROM @ls_zeinv_pxk.
            response_data-status = 'S'.
            response_data-message = |Phát hành thành công hoá đơn { ls_zeinv_pxk-einvoiceno_long }|.
          ENDIF.
        ELSE.
          lv_function = 'ImportAndPublishInv'.
          DATA(request_import_n_publish) = VALUE zeinv_import_and_publish_inv_6(
              username     = gs_auth-username
              password     = gs_auth-password
              account      = gs_auth-account
              acpass       = gs_auth-acpass
              pattern      = data-header-zpattern
              serial       = data-header-zserial
              xml_inv_data = format_xml_import( )
          ).
          gv_vnpt_service->import_and_publish_inv(
            EXPORTING
              input      = request_import_n_publish
              fkey       = data-header-uuid
            IMPORTING
              code       = lv_code
              einvoiceno = lv_einvoiceno ).
          IF lv_code = 'OK'.

            ls_zeinv_pxk = CORRESPONDING #( data-header ).
            ls_zeinv_pxk-uuidstatus = zeinv_if_constants~status_published.
            ls_zeinv_pxk-einvoiceno = lv_einvoiceno.
            ls_zeinv_pxk-einvoiceno_long = |{ data-header-zpattern(1) }{ data-header-zserial }.{ lv_einvoiceno }|.
            MODIFY zeinv_tb_pxk FROM @ls_zeinv_pxk.
            response_data-status = 'S'.
            response_data-message = |Phát hành thành công phiếu xuất kho { ls_zeinv_pxk-einvoiceno_long }|.
            LOOP AT data-item REFERENCE INTO DATA(ls_item).
              CLEAR ls_zeinv_pxk_i.
              ls_zeinv_pxk_i =  CORRESPONDING #( ls_item->* ).
              ls_zeinv_pxk_i-uuid = ls_zeinv_pxk-uuid.
              MODIFY zeinv_tb_pxk_i FROM @ls_zeinv_pxk_i.
            ENDLOOP.
          ENDIF.
        ENDIF.
      CATCH zeinv_cx_vnpt_service INTO DATA(lx_vnpt_service).
        RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = lx_vnpt_service->get_textid( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD vnpt_delete_draft.
    DATA:
      ls_zeinv_pxk   TYPE zeinv_tb_pxk,
      ls_zeinv_pxk_i TYPE zeinv_tb_pxk_i.
    TRY.
        IF data-header-uuidstatus =  zeinv_if_constants~status_drafted.
          DATA(request_delete_draft) = VALUE zeinv_delete_invoice_by_fkey_1(
               account  = gs_auth-account
               acpass   = gs_auth-acpass
               lst_fkey = |{ data-header-uuid }|
               username = gs_auth-username
               password = gs_auth-password ).

          gv_vnpt_service->delete_invoice_by_fkey(
            EXPORTING
              input = request_delete_draft
              fkey  = data-header-uuid
            IMPORTING
              code  = DATA(lv_delete_code) ).
          ls_zeinv_pxk  = CORRESPONDING #( data-header ).
          ls_zeinv_pxk-uuidstatus = ''.
          MODIFY zeinv_tb_pxk FROM @ls_zeinv_pxk.
          COMMIT WORK AND WAIT.
        ENDIF.
      CATCH zeinv_cx_vnpt_service INTO DATA(lx_vnpt_service).
        RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = lx_vnpt_service->get_textid( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
