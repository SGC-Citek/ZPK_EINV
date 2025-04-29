*----------------------------------------------------------------------*
* Citek JSC.
* (C) Copyright Citek JSC.
* All Rights Reserved
*----------------------------------------------------------------------*
* Application : Send data to VNPT and save log
* Creation Date: Jan 7, 2024 8:44:25 PM
* Created by: NganNM
*----------------------------------------------------------------------*
* ZEIV01 gửi request -> ZEINV_CL_API_HOADON -> check einvoice provider là : nếu VNPT : sử dụng zeinv_cl_vnpt_service_soap
*----------------------------------------------------------------------*

CLASS zeinv_cl_api_hoadon DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_http_service_extension .
    INTERFACES if_oo_adt_classrun.
    INTERFACES zeinv_if_constants .

    TYPES:

      BEGIN OF ty_request_data_hdr,
        sourcetype             TYPE string,
        billingdocument        TYPE string,
        referencesddocument    TYPE string,
        loaihoadon             TYPE string,
        companycode            TYPE string,
        accountingdocument     TYPE string,
        fiscalyear             TYPE string,
        purchaseorder          TYPE string,
        allbillingdetail       TYPE string,
        billinggeneral         TYPE string,
        billingaltunit         TYPE string,
        sothamkhao             TYPE string,
        billingdocumenttype    TYPE string,
        billnghiepvu           TYPE string,
        billnghiepvu_text      TYPE string,
        documentdate           TYPE string,
        postingdate            TYPE string,
        customer               TYPE string,
        vendor                 TYPE string,
        salesoffice            TYPE string,
        salesgroup             TYPE string,
        createdby              TYPE string,
        documentreferenceid    TYPE string,
        buyer                  TYPE string,
        tendonvi               TYPE string,
        buyeraddress           TYPE string,
        buyervatnumber         TYPE string,
        buyeremail             TYPE string,
        buyercompany           TYPE string,
        buyerbpgroup           TYPE string,
        shippingaddress        TYPE string,
        zserial                TYPE string,
        zpattern               TYPE string,
        ghichu                 TYPE string,
        paymentmethod          TYPE string,
        paymentmethodname      TYPE string,
        accountingexchangerate TYPE string,
        transactioncurrency    TYPE string,
        amountbeforetax        TYPE string,
        taxamount              TYPE string,
        amountaftertax         TYPE string,
        amountinwords          TYPE string,
        uuid                   TYPE string,
        uuidstatus             TYPE string,
        originuuid             TYPE string,
        origineinvoiceno       TYPE string,
      END OF ty_request_data_hdr,

      BEGIN OF ty_request_data_item,
        sourcetype              TYPE string,
        billingdocument         TYPE string,
        billingdocumentitem     TYPE string,
        companycode             TYPE string,
        accountingdocument      TYPE string,
        fiscalyear              TYPE string,
        accountingdocumentitem  TYPE string,
        referencesddocument     TYPE string,
        purchaseorder           TYPE string,
        allbillingdetail        TYPE string,
        billinggeneral          TYPE string,
        billingaltunit          TYPE string,
        itemforeinvoice         TYPE string,
        sothamkhao              TYPE string,
        salesdocument           TYPE string,
        salesdocumentitem       TYPE string,
        referencesddocumentitem TYPE string,
        product                 TYPE string,
        producttype             TYPE string,
        itemtext                TYPE string,
        einvoicetax             TYPE string,
        goodtypeineinvoice      TYPE string,
        goodtypeineinvoicetext  TYPE string,
        billingquantityunit     TYPE string,
        billingquantity         TYPE string,
        nongdohamluong          TYPE string,
        quycachdonggoi          TYPE string,
        nuocsanxuat             TYPE string,
        batchncc                TYPE string,
        hansudung               TYPE string,
        unitname                TYPE string,
        einvoicequanity         TYPE string,
        einvoiceunit            TYPE string,
        yy1_einvoiceunit_prd    TYPE string,
        transactioncurrency     TYPE string,
        netpricebeforediscount  TYPE string,
        discountrate            TYPE string,
        netpriceafterdiscount   TYPE string,
        amountbeforetax         TYPE string,
        taxrate                 TYPE string,
        taxamount               TYPE string,
        amountaftertax          TYPE string,
      END OF ty_request_data_item,

      BEGIN OF ty_request_data,
        function TYPE string,
        header   TYPE ty_request_data_hdr,
        item     TYPE STANDARD TABLE OF ty_request_data_item WITH EMPTY KEY,
      END OF ty_request_data,

      BEGIN OF ty_data,
        uuid   TYPE zeinv_fkey,
        header TYPE zeinv_i_hoadon,
        item   TYPE STANDARD TABLE OF zeinv_i_hoadon_item WITH EMPTY KEY,
      END OF ty_data,

      BEGIN OF ty_response_data,
        status   TYPE string,
        message  TYPE string,
        uuid     TYPE string,
        pdf      TYPE string,
        messages TYPE STANDARD TABLE OF zeinv_st_response WITH EMPTY KEY,
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
    METHODS:
      format_xml_import
        RETURNING VALUE(xml) TYPE string,
      format_xml_replace
        RETURNING VALUE(xml) TYPE string,
      format_xml_adjust
        RETURNING VALUE(xml) TYPE string,
      format_xml_replace_78
        RETURNING VALUE(xml) TYPE string,
      check_data,
      check_init
        IMPORTING data          TYPE any
        RETURNING VALUE(result) TYPE string,
*  tạo hoá đơn nháp
      import_inv
        RAISING zeinv_cx_vnpt_service,

*  lấy pdf của hoá đơn nháp
      get_pdf
        RETURNING VALUE(pdf_string) TYPE string
        RAISING   zeinv_cx_vnpt_service,

*  lấy pdf của hoá đơn điều chỉnh nháp
      get_draft_adjust
        RETURNING VALUE(html_string) TYPE string
        RAISING   zeinv_cx_vnpt_service,

*  lấy pdf của hoá đơn thay thế nháp
      get_draft_replace
        RETURNING VALUE(html_string) TYPE string
        RAISING   zeinv_cx_vnpt_service,
      create_proxy,
      update_reference
        IMPORTING i_einvoice_long TYPE zeinv_einvoiceno_long,

*  phát hành/ ký hoá đơn
      publish_invoice
        RAISING zeinv_cx_vnpt_service,

*  huỷ hoá đơn đã phát hành
      cancel_invoice
        RAISING zeinv_cx_vnpt_service,

*  phát hành hoá đơn thay thế
      replace_invoice
        RAISING zeinv_cx_vnpt_service,

*  phát hành hoá đơn điều chỉnh
      adjust_invoice
        RAISING zeinv_cx_vnpt_service,

* lấy pdf các hoá đơn đã sinh số
      get_pdf_published
        RETURNING VALUE(pdf_string) TYPE string
        RAISING   zeinv_cx_vnpt_service.

ENDCLASS.



CLASS ZEINV_CL_API_HOADON IMPLEMENTATION.


  METHOD adjust_invoice.
    DATA:
      lv_einvoiceno TYPE zeinv_einvoiceno,
      ls_zeinv_hd   TYPE zeinv_tb_hd,
      ls_zeinv_hd_i TYPE zeinv_tb_hd_i.
    DATA(request_action) = VALUE zeinv_adjust_invoice_action_s1(
              username     = gs_auth-username
              pass         = gs_auth-password
              account      = gs_auth-account
              acpass       = gs_auth-acpass
              pattern      = data-header-zpattern
              serial       = data-header-zserial
              xml_inv_data = format_xml_adjust( )
              fkey         = data-header-originuuid
    ).
    gv_vnpt_service->adjust_invoice_action(
      EXPORTING
        input      = request_action
        fkey       = data-header-uuid
      IMPORTING
        code       = DATA(lv_code)
        einvoiceno = lv_einvoiceno ).
    IF lv_code = 'OK'.
      ls_zeinv_hd = CORRESPONDING #( data-header ).
      ls_zeinv_hd-einvoiceno_long = |{ data-header-zpattern(1) }{ data-header-zserial }.{ lv_einvoiceno }|.
      update_reference( i_einvoice_long = |{ ls_zeinv_hd-einvoiceno_long }| ).
      ls_zeinv_hd-uuidstatus = zeinv_if_constants~status_published.
      ls_zeinv_hd-einvoiceno = lv_einvoiceno.
      MODIFY zeinv_tb_hd FROM @ls_zeinv_hd.
      response_data-status = 'S'.
      response_data-message = |Phát hành thành công hoá đơn { ls_zeinv_hd-einvoiceno_long }|.
      LOOP AT data-item REFERENCE INTO DATA(ls_item).
        CLEAR ls_zeinv_hd_i.
        ls_zeinv_hd_i =  CORRESPONDING #( ls_item->* ).
        ls_zeinv_hd_i-uuid = ls_zeinv_hd-uuid.
        MODIFY zeinv_tb_hd_i FROM @ls_zeinv_hd_i.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD cancel_invoice.
    DATA:
      lv_einvoiceno TYPE zeinv_einvoiceno,

      ls_zeinv_hd   TYPE zeinv_tb_hd,
      ls_zeinv_hd_i TYPE zeinv_tb_hd_i.

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
        UPDATE zeinv_tb_hd SET uuidstatus = @zeinv_if_constants~status_cancelled
                           WHERE uuid = @data-header-uuid.
        COMMIT WORK AND WAIT.
        response_data-status = 'S'.
        response_data-message = |Cancel thành công hoá đơn { data-header-einvoiceno_long }|.
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
    data-header = CORRESPONDING #( request_data-header EXCEPT postingdate ).
    IF request_data-header-uuid IS INITIAL.
*      data-header-uuid = |{ request_data-header-sourcetype }@{ request_data-header-sothamkhao }|.
*    else.
      data-header-uuid = request_data-header-uuid.
    ENDIF.
    data-uuid = request_data-header-uuid.
    data-header-billingdocument = |{ request_data-header-billingdocument ALPHA = IN }|.
    data-header-accountingdocument = |{ request_data-header-accountingdocument ALPHA = IN }|.

    IF  data-header-zpattern IS INITIAL OR data-header-zserial IS INITIAL.
      response_data-status = 'F'.
      response_data-message = 'Check cấu hình mẫu số ký hiệu'.
      RETURN.
    ENDIF.

    IF request_data-header-postingdate IS NOT INITIAL.
      CONDENSE request_data-header-postingdate.
      data-header-postingdate = |{ request_data-header-postingdate(4) }{ request_data-header-postingdate+5(2) }{ request_data-header-postingdate+8(2) }|.
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
      CONDENSE ls_request_item->hansudung."2026-12-31
      ls_date = ls_request_item->hansudung.
      APPEND VALUE #(
      sourcetype              = ls_request_item->sourcetype
      billingdocument         = |{ ls_request_item->billingdocument ALPHA = IN  }|
      billingdocumentitem     = |{ ls_request_item->billingdocumentitem  ALPHA = IN }|
      companycode             = ls_request_item->companycode
      accountingdocument      = |{ ls_request_item->accountingdocument ALPHA = IN  }|
      fiscalyear              = ls_request_item->fiscalyear
      accountingdocumentitem  = |{ ls_request_item->accountingdocumentitem ALPHA = IN  }|
      referencesddocument     = ls_request_item->referencesddocument
      purchaseorder           = |{ ls_request_item->purchaseorder  ALPHA = IN }|
      allbillingdetail        = ls_request_item->allbillingdetail
      billinggeneral          = ls_request_item->billinggeneral
      billingaltunit          = ls_request_item->billingaltunit
      itemforeinvoice         = |{ ls_request_item->itemforeinvoice ALPHA = IN  }|
      einvoicetax             = |{ ls_request_item->einvoicetax }|
      sothamkhao              = ls_request_item->sothamkhao
      salesdocument           = |{ ls_request_item->salesdocument ALPHA = IN }|
      salesdocumentitem       = |{ ls_request_item->salesdocumentitem ALPHA = IN  }|
      referencesddocumentitem = |{ ls_request_item->referencesddocumentitem ALPHA = IN  }|
      product                 = ls_request_item->product
      producttype             = ls_request_item->producttype
      itemtext                = ls_request_item->itemtext
      goodtypeineinvoice      = ls_request_item->goodtypeineinvoice
      goodtypeineinvoicetext  = ls_request_item->goodtypeineinvoicetext
      nongdohamluong          = ls_request_item->nongdohamluong
      quycachdonggoi          = ls_request_item->quycachdonggoi
      nuocsanxuat             = ls_request_item->nuocsanxuat
      batchncc                = ls_request_item->batchncc
      hansudung               = |{ COND #( WHEN ls_request_item->hansudung IS INITIAL THEN '00000000'
                                            ELSE |{ ls_date-year }{ ls_date-month }{ ls_date-date }| ) }|
      unitname                = ls_request_item->unitname
      einvoicequanity         = ls_request_item->einvoicequanity
      einvoiceunit            = ls_request_item->einvoiceunit
      yy1_einvoiceunit_prd    = ls_request_item->yy1_einvoiceunit_prd
      transactioncurrency     = ls_request_item->transactioncurrency
      netpricebeforediscount  = ls_request_item->netpricebeforediscount
      discountrate            = ls_request_item->discountrate
      netpriceafterdiscount   = ls_request_item->netpriceafterdiscount
      amountbeforetax         = ls_request_item->amountbeforetax
      taxrate                 = ls_request_item->taxrate
      taxamount               = ls_request_item->taxamount
      amountaftertax          = ls_request_item->amountaftertax
      ) TO data-item.
    ENDLOOP.

  ENDMETHOD.


  METHOD check_init.
    IF data IS INITIAL.
      result = ||.
    ELSE.
      result = |{ data }|.
    ENDIF.
  ENDMETHOD.


  METHOD create_proxy.
    DATA:
      lr_destination_publish TYPE REF TO if_proxy_destination,
      lr_destination_portal  TYPE REF TO if_proxy_destination.
    SELECT SINGLE * FROM zeinv_vnpt_auth WHERE companycode = @data-header-companycode INTO @gs_auth.
    gv_vnpt_service = NEW zeinv_cl_vnpt_service_soap( i_auth = gs_auth i_type = '1' ).

  ENDMETHOD.


  METHOD format_xml_adjust.
    DATA:
      lv_taxamt       TYPE fins_vwcur12,
      lv_amt          TYPE fins_vwcur12,

      lv_taxamt_0     TYPE fins_vwcur12,
      lv_amt_0        TYPE fins_vwcur12,
      lv_taxamt_5     TYPE fins_vwcur12,
      lv_amt_5        TYPE fins_vwcur12,
      lv_taxamt_8     TYPE fins_vwcur12,
      lv_amt_8        TYPE fins_vwcur12,
      lv_taxamt_10    TYPE fins_vwcur12,
      lv_amt_10       TYPE fins_vwcur12,
      lv_taxamt_kct   TYPE fins_vwcur12,
      lv_amt_kct      TYPE fins_vwcur12,
      lv_taxamt_kkknt TYPE fins_vwcur12,
      lv_amt_kkknt    TYPE fins_vwcur12,
      lv_total        TYPE fins_vwcur12,
      lv_amount       TYPE fins_vwcur12,
      lv_vatamount    TYPE fins_vwcur12.
    DATA: lv_taxrate      TYPE i,
          lv_discountrate TYPE i.
*///Binding theo thông tư 32
    xml = |<AdjustInv>|
       && |<key>{ data-header-uuid }</key>|
       && |<CusCode>{ data-header-customer }</CusCode>|
       && |<CusName><![CDATA[{ data-header-tendonvi }]]></CusName>|
       && |<CusAddress><![CDATA[{ data-header-buyeraddress }]]></CusAddress>|
       && |<CusTaxCode>{ data-header-buyervatnumber }</CusTaxCode>|
       && |<Buyer>{ data-header-buyer }</Buyer>|
       && |<Extra1><![CDATA[{ data-header-shippingaddress }]]></Extra1>|
       && |<CusBankNo />|
       && |<CusBankName />|
       && |<PaymentMethod> { data-header-paymentmethodname }</PaymentMethod>|
       && |<EmailDeliver>{ data-header-buyeremail }</EmailDeliver>|
       && |<CurrencyUnit>{ data-header-transactioncurrency }</CurrencyUnit>|
       && |<Products>|.

    LOOP AT data-item INTO DATA(ls_item).

      CASE ls_item-taxrate.
        WHEN 0.
          lv_taxamt_0 += ls_item-taxamount.
          lv_amt_0 += ls_item-amountbeforetax.
        WHEN 5.
          lv_taxamt_5 += ls_item-taxamount.
          lv_amt_5 += ls_item-amountbeforetax.
        WHEN 8.
          lv_taxamt_8 += ls_item-taxamount.
          lv_amt_8 += ls_item-amountbeforetax.
        WHEN 10.
          lv_taxamt_10 += ls_item-taxamount.
          lv_amt_10 += ls_item-amountbeforetax.
        WHEN 'KCT' OR '-1'.
          lv_taxamt_kct += ls_item-taxamount.
          lv_amt_kct += ls_item-amountbeforetax.
        WHEN 'KKKNT' OR '-2'.
          lv_taxamt_kkknt += ls_item-taxamount.
          lv_amt_kkknt += ls_item-amountbeforetax.
      ENDCASE.

      lv_taxrate = ls_item-taxrate .
      lv_discountrate = ls_item-discountrate .

      lv_total += ls_item-amountbeforetax.
      lv_amount += ls_item-amountaftertax.
      lv_vatamount += ls_item-taxamount.
**&---------------------------------------------------------------------*
*& Item
      IF ls_item-goodtypeineinvoice = 4.
        xml = xml
              && |<Product>|
              && |<Code></Code>|
              && |<ProdName><![CDATA[{ ls_item-itemtext }]]></ProdName>|
              && |<ProdUnit>{ ls_item-unitname }</ProdUnit>|
              && |<ProdQuantity> { ls_item-einvoicequanity }</ProdQuantity>|
              && |<IsSum>{ ls_item-goodtypeineinvoice }</IsSum>|
              && |</Product>|.
      ELSE.
        xml = xml
            && |<Product>|
            && |<Code>{ COND #( WHEN condense( |{ ls_item-product ALPHA = OUT }| ) <> 0 THEN condense( |{ ls_item-product ALPHA = OUT }| )
                                ELSE '' ) }</Code>|
            && |<ProdName><![CDATA[{ ls_item-itemtext }]]></ProdName>|
            && |<ProdUnit>{ ls_item-unitname }</ProdUnit>|
            && |<ProdQuantity> { ls_item-einvoicequanity }</ProdQuantity>|
            "Đơn giá sau chiết khấu
            && |<ProdPrice>{ ls_item-netpriceafterdiscount }</ProdPrice>|
            "Thành tiền
            && |<Total>{ ls_item-amountbeforetax }</Total>|
            "Thuế suất
            && |<VATRate>{ ls_item-taxrate  }</VATRate>|
            "Thuế GTGT
            && |<VATAmount>{ ls_item-taxamount }</VATAmount>|
            "Số tiền thanh toán
            && |<Amount>{ ls_item-amountaftertax }</Amount>|
            "Nước sản xuất
            && |<Remark>{ ls_item-nuocsanxuat }</Remark>|
            "Số lô, nồng độ hàm lượng
            && |<Extra1>{ ls_item-batchncc };{ ls_item-nongdohamluong }</Extra1>|
            "Hạn dùng : Quy cách đóng gói
            && |<Extra2>{ |{ COND string( WHEN ls_item-hansudung IS INITIAL THEN ''
                                     ELSE |{ ls_item-hansudung DATE = ENVIRONMENT }| ) }| };{ ls_item-quycachdonggoi }</Extra2>|
            && |<Discount>{ ls_item-discountrate }</Discount>|
            && |<IsSum>{ ls_item-goodtypeineinvoice }</IsSum>|
            && |</Product>|.
      ENDIF.
    ENDLOOP.

    xml = |{ xml }</Products>|
       && |<Type>{ COND #( WHEN data-header-billnghiepvu = '3' THEN '3' "3-giảm, 4-tăng
                                WHEN data-header-billnghiepvu = '4' THEN '2' ) }</Type>|
       && |<GrossValue>{ lv_amount }</GrossValue>|
       && |<GrossValue0>{ lv_amt_0 }</GrossValue0>|
       && |<GrossValue5>{ lv_amt_5 }</GrossValue5>|
       && |<GrossValue8>{ lv_amt_8 }</GrossValue8>|
       && |<GrossValue10>{ lv_amt_10 }</GrossValue10>|
       && |<VatAmount0>{ lv_taxamt_0 }</VatAmount0>|
       && |<VatAmount5>{ lv_taxamt_5 }</VatAmount5>|
       && |<VatAmount8>{ lv_taxamt_8 }</VatAmount8>|
       && |<VatAmount10>{ lv_taxamt_10 }</VatAmount10>|
       && |<VatAmountOther>{ lv_taxamt_kct }</VatAmountOther>|
       && |<Note><![CDATA[{ data-header-ghichu }]]></Note>|
       && |<Total>{ lv_total }</Total>|
       && |<Amount>{ lv_amount }</Amount>|
       && |<VATAmount>{ lv_vatamount }</VATAmount>|
       && |<AmountInWords>{ data-header-amountinwords }</AmountInWords>|
       && |<KindOfService/>|
       && |<ConvertedAmount>0</ConvertedAmount>|
       && |</AdjustInv>|.

  ENDMETHOD.


  METHOD format_xml_import.
    DATA:
      lv_taxamt       TYPE fins_vwcur12,
      lv_amt          TYPE fins_vwcur12,

      lv_taxamt_0     TYPE fins_vwcur12,
      lv_amt_0        TYPE fins_vwcur12,
      lv_taxamt_5     TYPE fins_vwcur12,
      lv_amt_5        TYPE fins_vwcur12,
      lv_taxamt_8     TYPE fins_vwcur12,
      lv_amt_8        TYPE fins_vwcur12,
      lv_taxamt_10    TYPE fins_vwcur12,
      lv_amt_10       TYPE fins_vwcur12,
      lv_taxamt_kct   TYPE fins_vwcur12,
      lv_amt_kct      TYPE fins_vwcur12,
      lv_taxamt_kkknt TYPE fins_vwcur12,
      lv_amt_kkknt    TYPE fins_vwcur12,
      lv_total        TYPE fins_vwcur12,
      lv_amount       TYPE fins_vwcur12,
      lv_vatamount    TYPE fins_vwcur12.
    DATA: lv_taxrate      TYPE i,
          lv_discountrate TYPE i.
*///Binding theo thông tư 32
    xml = |<Invoices>|
       && |<Inv>|
       && |<key>{ data-header-uuid }</key>|
       && |<Invoice>|
       && |<CusCode>{ data-header-customer }</CusCode>|
       && |<Buyer> { data-header-buyer }</Buyer>|
       && |<CusName><![CDATA[{ data-header-tendonvi }]]></CusName>|
       && |<CusAddress><![CDATA[{ data-header-buyeraddress }]]></CusAddress>|
       && |<CusTaxCode>{ data-header-buyervatnumber }</CusTaxCode>|
*       && |<Extra1><![CDATA[{ data-header-shippingaddress }]]></Extra1>|
       && |<Extra3>{ data-header-sothamkhao ALPHA = OUT }</Extra3>|
*       && |<Extra4>{ data-header-PlantName }</Extra4>|
       && |<CusBankNo />|
       && |<CusBankName />|
       && |<PaymentMethod><![CDATA[CK/TM]]></PaymentMethod>|
*       && |<PaymentMethod> { data-header-paymentmethodname }</PaymentMethod>|
       && |<EmailDeliver>{ data-header-buyeremail }</EmailDeliver>|
       && |<CurrencyUnit>{ data-header-transactioncurrency }</CurrencyUnit>|
       && |<ExchangeRate>{ data-header-accountingexchangerate }</ExchangeRate>|
       && |<Products>|.

    LOOP AT data-item INTO DATA(ls_item).

      CASE ls_item-taxrate.
        WHEN 0.
          lv_taxamt_0 += ls_item-taxamount.
          lv_amt_0 += ls_item-amountbeforetax.
        WHEN 5.
          lv_taxamt_5 += ls_item-taxamount.
          lv_amt_5 += ls_item-amountbeforetax.
        WHEN 8.
          lv_taxamt_8 += ls_item-taxamount.
          lv_amt_8 += ls_item-amountbeforetax.
        WHEN 10.
          lv_taxamt_10 += ls_item-taxamount.
          lv_amt_10 += ls_item-amountbeforetax.
        WHEN 'KCT' OR '-1'.
          lv_taxamt_kct += ls_item-taxamount.
          lv_amt_kct += ls_item-amountbeforetax.
        WHEN 'KKKNT' OR '-2'.
          lv_taxamt_kkknt += ls_item-taxamount.
          lv_amt_kkknt += ls_item-amountbeforetax.
      ENDCASE.

      lv_taxrate = ls_item-taxrate .
      lv_discountrate = ls_item-discountrate .

      lv_total += ls_item-amountbeforetax.
      lv_amount += ls_item-amountaftertax.
      lv_vatamount += ls_item-taxamount.
**&---------------------------------------------------------------------*
*& Item
      IF ls_item-goodtypeineinvoice = 4.
        xml = xml
              && |<Product>|
              && |<Code></Code>|
              && |<ProdName><![CDATA[{ ls_item-itemtext }]]></ProdName>|
              && |<ProdUnit>{ ls_item-unitname }</ProdUnit>|
              && |<ProdQuantity>{ ls_item-einvoicequanity }</ProdQuantity>|
              && |<IsSum>{ ls_item-goodtypeineinvoice }</IsSum>|
              && |</Product>|.
      ELSE.
*        if ls_item-product is initial .
*        ls_item-product = space.
*        endif.
        xml = xml
            && |<Product>|
            && |<Code>{ COND #( WHEN condense( |{ ls_item-product ALPHA = OUT }| ) <> 0 THEN condense( |{ ls_item-product ALPHA = OUT }| )
                                ELSE '' ) }</Code>|
            && |<ProdName><![CDATA[{ ls_item-itemtext }]]></ProdName>|
            && |<ProdUnit>{ ls_item-unitname }</ProdUnit>|
            && |<ProdQuantity>{ ls_item-einvoicequanity }</ProdQuantity>|
            "Đơn giá sau chiết khấu
            && |<ProdPrice>{ ls_item-netpriceafterdiscount }</ProdPrice>|
            "Thành tiền
            && |<Total>{ ls_item-amountbeforetax }</Total>|
            "Thuế suất
            && |<VATRate>{ ls_item-einvoicetax  }</VATRate>|
            "Thuế GTGT
            && |<VATAmount>{ ls_item-taxamount }</VATAmount>|
            "Số tiền thanh toán
            && |<Amount>{ ls_item-amountaftertax }</Amount>|
            "Nước sản xuất
            && |<Remark>{ ls_item-nuocsanxuat }</Remark>|
            "Số lô, nồng độ hàm lượng
            && |<Extra1><![CDATA[{ ls_item-batchncc };{ ls_item-nongdohamluong }]]></Extra1>|
            "Hạn dùng : Quy cách đóng gói
            && |<Extra2> { |{ COND string( WHEN ls_item-hansudung IS INITIAL THEN ''
                                     ELSE |{ ls_item-hansudung DATE = ENVIRONMENT }| ) }| };{ ls_item-quycachdonggoi }</Extra2>|
            && |<Discount>{ ls_item-discountrate }</Discount>|
            && |<IsSum>{ ls_item-goodtypeineinvoice }</IsSum>|
            && |</Product>|.
      ENDIF.
    ENDLOOP.

    xml = |{ xml }</Products>|
       && |<GrossValue>{ lv_amount }</GrossValue>|
       && |<GrossValue0>{ lv_amt_0 }</GrossValue0>|
       && |<GrossValue5>{ lv_amt_5 }</GrossValue5>|
       && |<GrossValue8>{ lv_amt_8 }</GrossValue8>|
       && |<GrossValue10>{ lv_amt_10 }</GrossValue10>|
       && |<VatAmount0>{ lv_taxamt_0 }</VatAmount0>|
       && |<VatAmount5>{ lv_taxamt_5 }</VatAmount5>|
       && |<VatAmount8>{ lv_taxamt_8 }</VatAmount8>|
       && |<VatAmount10>{ lv_taxamt_10 }</VatAmount10>|
       && |<VatAmountOther>{ lv_taxamt_kct }</VatAmountOther>|
       && |<Note><![CDATA[{ data-header-ghichu }]]></Note>|
       && |<Total>{ lv_total }</Total>|
       && |<Amount>{ lv_amount }</Amount>|
       && |<VATAmount>{ lv_vatamount }</VATAmount>|
       && |<AmountInWords>{ data-header-amountinwords }</AmountInWords>|
       && |<KindOfService/>|
       && |<ConvertedAmount>0</ConvertedAmount>|
       && |</Invoice>|
       && |</Inv>|
       && |</Invoices>|.
  ENDMETHOD.


  METHOD format_xml_replace.
    DATA:
      lv_taxamt       TYPE fins_vwcur12,
      lv_amt          TYPE fins_vwcur12,

      lv_taxamt_0     TYPE fins_vwcur12,
      lv_amt_0        TYPE fins_vwcur12,
      lv_taxamt_5     TYPE fins_vwcur12,
      lv_amt_5        TYPE fins_vwcur12,
      lv_taxamt_8     TYPE fins_vwcur12,
      lv_amt_8        TYPE fins_vwcur12,
      lv_taxamt_10    TYPE fins_vwcur12,
      lv_amt_10       TYPE fins_vwcur12,
      lv_taxamt_kct   TYPE fins_vwcur12,
      lv_amt_kct      TYPE fins_vwcur12,
      lv_taxamt_kkknt TYPE fins_vwcur12,
      lv_amt_kkknt    TYPE fins_vwcur12,
      lv_total        TYPE fins_vwcur12,
      lv_amount       TYPE fins_vwcur12,
      lv_vatamount    TYPE fins_vwcur12.
    DATA: lv_taxrate      TYPE i,
          lv_discountrate TYPE i.
*///Binding theo thông tư 32
    xml = |<ReplaceInv>|
       && |<key>{ data-header-uuid }</key>|
       && |<CusCode>{ data-header-customer }</CusCode>|
       && |<CusName><![CDATA[{ data-header-tendonvi }]]></CusName>|
       && |<CusAddress><![CDATA[{ data-header-buyeraddress }]]></CusAddress>|
       && |<CusTaxCode>{ data-header-buyervatnumber }</CusTaxCode>|
       && |<Buyer><![CDATA[{ data-header-buyer }]]></Buyer>|
       && |<Extra1><![CDATA[{ data-header-shippingaddress }]]></Extra1>|
       && |<CusBankNo />|
       && |<CusBankName />|
       && |<PaymentMethod> { data-header-paymentmethodname }</PaymentMethod>|
       && |<EmailDeliver>{ data-header-buyeremail }</EmailDeliver>|
       && |<CurrencyUnit>{ data-header-transactioncurrency }</CurrencyUnit>|
       && |<Products>|.

    LOOP AT data-item INTO DATA(ls_item).

      CASE ls_item-taxrate.
        WHEN 0.
          lv_taxamt_0 += ls_item-taxamount.
          lv_amt_0 += ls_item-amountbeforetax.
        WHEN 5.
          lv_taxamt_5 += ls_item-taxamount.
          lv_amt_5 += ls_item-amountbeforetax.
        WHEN 8.
          lv_taxamt_8 += ls_item-taxamount.
          lv_amt_8 += ls_item-amountbeforetax.
        WHEN 10.
          lv_taxamt_10 += ls_item-taxamount.
          lv_amt_10 += ls_item-amountbeforetax.
        WHEN 'KCT' OR '-1'.
          lv_taxamt_kct += ls_item-taxamount.
          lv_amt_kct += ls_item-amountbeforetax.
        WHEN 'KKKNT' OR '-2'.
          lv_taxamt_kkknt += ls_item-taxamount.
          lv_amt_kkknt += ls_item-amountbeforetax.
      ENDCASE.

      lv_taxrate = ls_item-taxrate .
      lv_discountrate = ls_item-discountrate .

      lv_total += ls_item-amountbeforetax.
      lv_amount += ls_item-amountaftertax.
      lv_vatamount += ls_item-taxamount.
**&---------------------------------------------------------------------*
*& Item
      IF ls_item-goodtypeineinvoice = 4.
        xml = xml
              && |<Product>|
              && |<Code></Code>|
              && |<ProdName><![CDATA[{ ls_item-itemtext }]]></ProdName>|
              && |<ProdUnit>{ ls_item-unitname }</ProdUnit>|
              && |<ProdQuantity> { ls_item-einvoicequanity }</ProdQuantity>|
              && |<IsSum>{ ls_item-goodtypeineinvoice }</IsSum>|
              && |</Product>|.
      ELSE.
        xml = xml
            && |<Product>|
            && |<Code>{ COND #( WHEN condense( |{ ls_item-product ALPHA = OUT }| ) <> 0 THEN condense( |{ ls_item-product ALPHA = OUT }| )
                                ELSE '' ) }</Code>|
            && |<ProdName><![CDATA[{ ls_item-itemtext }]]></ProdName>|
            && |<ProdUnit>{ ls_item-unitname }</ProdUnit>|
            && |<ProdQuantity> { ls_item-einvoicequanity }</ProdQuantity>|
            "Đơn giá sau chiết khấu
            && |<ProdPrice>{ ls_item-netpriceafterdiscount }</ProdPrice>|
            "Thành tiền
            && |<Total>{ ls_item-amountbeforetax }</Total>|
            "Thuế suất
            && |<VATRate>{ ls_item-taxrate  }</VATRate>|
            "Thuế GTGT
            && |<VATAmount>{ ls_item-taxamount }</VATAmount>|
            "Số tiền thanh toán
            && |<Amount>{ ls_item-amountaftertax }</Amount>|
            "Nước sản xuất
            && |<Remark>{ ls_item-nuocsanxuat }</Remark>|
            "Số lô, nồng độ hàm lượng
            && |<Extra1><![CDATA[{ ls_item-batchncc };{ ls_item-nongdohamluong }]]></Extra1>|
            "Hạn dùng : Quy cách đóng gói
            && |<Extra2>{ |{ COND string( WHEN ls_item-hansudung IS INITIAL THEN ''
                                     ELSE |{ ls_item-hansudung DATE = ENVIRONMENT }| ) }| };{ ls_item-quycachdonggoi }</Extra2>|
            && |<Discount>{ ls_item-discountrate }</Discount    >|
            && |<IsSum>{ ls_item-goodtypeineinvoice }</IsSum>|
            && |</Product>|.
      ENDIF.
    ENDLOOP.

    xml = |{ xml }</Products>|
       && |<GrossValue>{ lv_amount }</GrossValue>|
       && |<GrossValue0>{ lv_amt_0 }</GrossValue0>|
       && |<GrossValue5>{ lv_amt_5 }</GrossValue5>|
       && |<GrossValue8>{ lv_amt_8 }</GrossValue8>|
       && |<GrossValue10>{ lv_amt_10 }</GrossValue10>|
       && |<VatAmount0>{ lv_taxamt_0 }</VatAmount0>|
       && |<VatAmount5>{ lv_taxamt_5 }</VatAmount5>|
       && |<VatAmount8>{ lv_taxamt_8 }</VatAmount8>|
       && |<VatAmount10>{ lv_taxamt_10 }</VatAmount10>|
       && |<VatAmountOther>{ lv_taxamt_kct }</VatAmountOther>|
       && |<Note><![CDATA[{ data-header-ghichu }]]></Note>|
       && |<Total>{ lv_total }</Total>|
       && |<Amount>{ lv_amount }</Amount>|
       && |<VATAmount>{ lv_vatamount }</VATAmount>|
       && |<AmountInWords>{ data-header-amountinwords }</AmountInWords>|
       && |<KindOfService/>|
       && |<ConvertedAmount>0</ConvertedAmount>|
       && |</ReplaceInv>|.
  ENDMETHOD.


  METHOD format_xml_replace_78.
    DATA:
      lv_taxamt       TYPE fins_vwcur12,
      lv_amt          TYPE fins_vwcur12,

      lv_taxamt_0     TYPE fins_vwcur12,
      lv_amt_0        TYPE fins_vwcur12,
      lv_taxamt_5     TYPE fins_vwcur12,
      lv_amt_5        TYPE fins_vwcur12,
      lv_taxamt_8     TYPE fins_vwcur12,
      lv_amt_8        TYPE fins_vwcur12,
      lv_taxamt_10    TYPE fins_vwcur12,
      lv_amt_10       TYPE fins_vwcur12,
      lv_taxamt_kct   TYPE fins_vwcur12,
      lv_amt_kct      TYPE fins_vwcur12,
      lv_taxamt_kkknt TYPE fins_vwcur12,
      lv_amt_kkknt    TYPE fins_vwcur12,
      lv_total        TYPE fins_vwcur12,
      lv_amount       TYPE fins_vwcur12,
      lv_vatamount    TYPE fins_vwcur12,
      lv_thuesuat     TYPE c LENGTH 20.
    DATA: lv_taxrate      TYPE i,
          lv_discountrate TYPE i.
*///Binding theo thông tư 78
    xml = |<ThayTheHD>|
       && |<key>{ data-header-uuid }</key>|
            && |<DVTTe>{ data-header-transactioncurrency }</DVTTe>|
            && |<TGia>1</TGia>|
            && |<HTTToan>{ data-header-paymentmethodname } </HTTToan>|
            && |<TTKhac>|
             && |<TTin>|
                 && |<TTruong>HTTToan</TTruong>|
                 && |<KDLieu>string</KDLieu>|
                 && |<DLieu>TM/CK</DLieu>|
             && |</TTin>|
            && |</TTKhac>|
       && |</TTChung>|

       && |<NDHDon>|
        && |<NBan/>|
        && |<NMua>|
           && |<Ten><![CDATA[{ data-header-tendonvi }]]></Ten>|
           && |<MST>1402063770-111</MST>|
           && |<DChi><![CDATA[{ data-header-buyeraddress }]]></DChi>|
           && |<STKNHang><![CDATA[{ data-header-bankaccount }]]></STKNHang>|
*           && |<MKHang>{ data-header-customer }</MKHang>|
*           && |<HVTNMHang><![CDATA[{ data-header-buyer }]]></HVTNMHang>|
        && |</NMua>|
        && |<DSHHDVu>|.

    DATA(lv_stt) = 0.
    LOOP AT data-item INTO DATA(ls_item).
      lv_stt += 1.
      CASE ls_item-taxrate.
        WHEN 0.
          lv_taxamt_0 += ls_item-taxamount.
          lv_amt_0 += ls_item-amountbeforetax.
          lv_thuesuat = '0'.
        WHEN 5.
          lv_taxamt_5 += ls_item-taxamount.
          lv_amt_5 += ls_item-amountbeforetax.
          lv_thuesuat = '5'.
        WHEN 8.
          lv_taxamt_8 += ls_item-taxamount.
          lv_amt_8 += ls_item-amountbeforetax.
          lv_thuesuat = '8'.
        WHEN 10.
          lv_taxamt_10 += ls_item-taxamount.
          lv_amt_10 += ls_item-amountbeforetax.
          lv_thuesuat = '10'.
        WHEN 'KCT' OR '-1'.
          lv_taxamt_kct += ls_item-taxamount.
          lv_amt_kct += ls_item-amountbeforetax.
          lv_thuesuat = 'KCT'.
        WHEN 'KKKNT' OR '-2'.
          lv_taxamt_kkknt += ls_item-taxamount.
          lv_amt_kkknt += ls_item-amountbeforetax.
          lv_thuesuat = 'KKKNT'.
      ENDCASE.

      lv_taxrate = ls_item-taxrate .
      lv_discountrate = ls_item-discountrate .

      lv_total += ls_item-amountbeforetax.
      lv_amount += ls_item-amountaftertax.
      lv_vatamount += ls_item-taxamount.

**&---------------------------------------------------------------------*
*& Item

      xml = xml
            && |<HHDVu>|
                && |<TChat>{ ls_item-goodtypeineinvoice }</TChat>|
                && |<STT>{ lv_stt }</STT>|
                && |<MHHDVu>{ ls_item-product }</MHHDVu>|
                && |<THHDVu><![CDATA[{ ls_item-itemtext }]]></THHDVu>|
                && |<SLuong>{ ls_item-einvoicequanity }</SLuong>|
                && |<DVTinh><![CDATA[{ ls_item-unitname }]]></DVTinh>|
                && |<DGia>{ ls_item-netpriceafterdiscount }</DGia>|
                && |<TLCKhau>{ abs( lv_discountrate ) }</TLCKhau>|
                && |<TSuat>{ lv_taxrate }%</TSuat>|
                && |<ThTien>{ ls_item-amountbeforetax }</ThTien>|
            && |</HHDVu>|.
    ENDLOOP.

    xml = |{ xml }</DSHHDVu>|
      && |<TToan>|
        && |<THTTLTSuat>|
            && |<LTSuat>|
                 && |<TSuat>{ lv_thuesuat }</TSuat>|
                 && |<TThue>{ lv_vatamount }</TThue>|
                 && |<ThTien>{ lv_amt_10 }</ThTien>|
            && |</LTSuat>|
        && |</THTTLTSuat>|
        && |<TgTCThue>{  lv_total }</TgTCThue>|
        && |<TgTThue>{ lv_vatamount }</TgTThue>|
        && |<TgTTTBSo>{ lv_amount }</tgtttbso>|
        && |<TgTTTBChu><![CDATA[{ data-header-amountinwords }]]></TgTTTBChu>|
       && |</TToan>|
       && |</NDHDon>|
       && |</ThayTheHD>|
    .

  ENDMETHOD.


  METHOD get_draft_adjust.
    DATA(request_draft_adjust) = VALUE zeinv_adjust_invoice_no_publi1(
          account      = gs_auth-account
          acpass       = gs_auth-acpass
          username     = gs_auth-username
          pass         = gs_auth-password
          fkey         = data-header-originuuid
          pattern      = data-header-zpattern
          serial       = data-header-zserial
          xml_inv_data = format_xml_adjust( )
    ).

    TRY.
        html_string = gv_vnpt_service->adjust_invoice_no_publish(
          EXPORTING
            fkey  = data-header-uuid
            input = request_draft_adjust ).
      CATCH zeinv_cx_vnpt_service INTO DATA(lx_vnpt_service).
        RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = lx_vnpt_service->get_textid( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD get_draft_replace.
    DATA(request_draft_replace) = VALUE zeinv_replace_invoice_no_publ1(
          account      = gs_auth-account
          acpass       = gs_auth-acpass
          username     = gs_auth-username
          pass         = gs_auth-password
          fkey         = data-header-originuuid
          pattern      = data-header-zpattern
          serial       = data-header-zserial
          xml_inv_data = format_xml_replace( )
    ).

    TRY.
        html_string = gv_vnpt_service->replace_invoice_no_publish(
          EXPORTING
            fkey  = data-header-uuid
            input = request_draft_replace ).
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
                WHEN zeinv_if_constants~func_get_xml.
                  response_body = format_xml_import( ).

                WHEN zeinv_if_constants~func_get_xml_replace.
                  response_body = format_xml_replace( ).

                WHEN zeinv_if_constants~func_get_xml_adjust.
                  response_body = format_xml_adjust( ).

                WHEN  zeinv_if_constants~func_get_draft.
                  import_inv(  ).
                  response_data-pdf = get_pdf( ).
                  response_data-status = 'S'.
                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).
                WHEN  zeinv_if_constants~func_publish.
                  publish_invoice(  ).
                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).
                WHEN  zeinv_if_constants~func_cancel.
                  cancel_invoice(  ).
                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).
                WHEN zeinv_if_constants=>func_replace.
                  replace_invoice(  ).
                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).

                WHEN zeinv_if_constants=>func_adjust.
                  adjust_invoice(  ).
                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).

                WHEN zeinv_if_constants=>func_get_draft_adjust.
                  response_data-pdf = get_draft_adjust( ).
                  response_data-status = 'S'.
                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).
                WHEN zeinv_if_constants=>func_get_draft_replace.
                  response_data-pdf = get_draft_replace( ).
                  response_data-status = 'S'.
                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).

                WHEN zeinv_if_constants=>func_get_published_pdf.
                  response_data-pdf = get_pdf_published( ).
                  response_data-status = 'S'.
                  response_body = xco_cp_json=>data->from_abap( response_data )->apply( VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case )
                                                                                                 ( xco_cp_json=>transformation->boolean_to_abap_bool ) ) )->to_string( ).

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


  METHOD if_oo_adt_classrun~main.
  ENDMETHOD.


  METHOD import_inv.
    DATA:
      ls_zeinv_hd   TYPE zeinv_tb_hd,
      ls_zeinv_hd_i TYPE zeinv_tb_hd_i.
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
          ls_zeinv_hd = CORRESPONDING #( data-header ).
          ls_zeinv_hd-uuidstatus = ''.
          MODIFY zeinv_tb_hd FROM @ls_zeinv_hd.
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
          ls_zeinv_hd = CORRESPONDING #( data-header ).
          ls_zeinv_hd-uuidstatus = zeinv_if_constants~status_drafted.
          CASE ls_zeinv_hd-sourcetype.
            WHEN 'BILL'.
              ls_zeinv_hd-ngayhoadon  = data-header-postingdate.
            WHEN 'FI'.
              ls_zeinv_hd-ngayhoadon  = data-header-documentdate.
          ENDCASE.
          MODIFY zeinv_tb_hd FROM @ls_zeinv_hd.

          LOOP AT data-item REFERENCE INTO DATA(ls_item).
            CLEAR ls_zeinv_hd_i.
            ls_zeinv_hd_i =  CORRESPONDING #( ls_item->* ).
            ls_zeinv_hd_i-uuid = ls_zeinv_hd-uuid.
            MODIFY zeinv_tb_hd_i FROM @ls_zeinv_hd_i.
          ENDLOOP.
          COMMIT WORK.
        ENDIF.
      CATCH zeinv_cx_vnpt_service INTO DATA(lx_vnpt_service).
        RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = lx_vnpt_service->get_textid( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD publish_invoice.
    DATA:
      lv_einvoiceno TYPE zeinv_einvoiceno,

      ls_zeinv_hd   TYPE zeinv_tb_hd,
      ls_zeinv_hd_i TYPE zeinv_tb_hd_i.

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

            ls_zeinv_hd = CORRESPONDING #( data-header ).
            CASE ls_zeinv_hd-sourcetype.
              WHEN 'BILL'.
                ls_zeinv_hd-ngayhoadon  = data-header-postingdate.
              WHEN 'FI'.
                ls_zeinv_hd-ngayhoadon  = data-header-documentdate.
            ENDCASE.
            ls_zeinv_hd-uuidstatus = zeinv_if_constants~status_published.
            ls_zeinv_hd-einvoiceno = lv_einvoiceno.
            ls_zeinv_hd-einvoiceno_long = |{ data-header-zpattern(1) }{ data-header-zserial }.{ lv_einvoiceno }|.
            update_reference( i_einvoice_long = |{ ls_zeinv_hd-einvoiceno_long }| ).
            MODIFY zeinv_tb_hd FROM @ls_zeinv_hd.
            response_data-status = 'S'.
            response_data-message = |Phát hành thành công hoá đơn { ls_zeinv_hd-einvoiceno_long }|.
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

            ls_zeinv_hd = CORRESPONDING #( data-header ).
            CASE ls_zeinv_hd-sourcetype.
              WHEN 'BILL'.
                ls_zeinv_hd-ngayhoadon  = data-header-postingdate.
              WHEN 'FI'.
                ls_zeinv_hd-ngayhoadon  = data-header-documentdate.
            ENDCASE.
            ls_zeinv_hd-uuidstatus = zeinv_if_constants~status_published.
            ls_zeinv_hd-einvoiceno = lv_einvoiceno.
            ls_zeinv_hd-einvoiceno_long = |{ data-header-zpattern(1) }{ data-header-zserial }.{ lv_einvoiceno }|.
            update_reference( i_einvoice_long = |{ ls_zeinv_hd-einvoiceno_long }| ).
            MODIFY zeinv_tb_hd FROM @ls_zeinv_hd.
            response_data-status = 'S'.
            response_data-message = |Phát hành thành công hoá đơn { ls_zeinv_hd-einvoiceno_long }|.
            LOOP AT data-item REFERENCE INTO DATA(ls_item).
              CLEAR ls_zeinv_hd_i.
              ls_zeinv_hd_i =  CORRESPONDING #( ls_item->* ).
              ls_zeinv_hd_i-uuid = ls_zeinv_hd-uuid.
              MODIFY zeinv_tb_hd_i FROM @ls_zeinv_hd_i.
            ENDLOOP.
          ENDIF.
        ENDIF.
      CATCH zeinv_cx_vnpt_service INTO DATA(lx_vnpt_service).
        RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = lx_vnpt_service->get_textid( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD replace_invoice.
    DATA:
      lv_einvoiceno TYPE zeinv_einvoiceno,
      ls_zeinv_hd   TYPE zeinv_tb_hd,
      ls_zeinv_hd_i TYPE zeinv_tb_hd_i.
    DATA(request_replace_fkey) = VALUE zeinv_replace_invoice_action_1(
              username     = gs_auth-username
              pass         = gs_auth-password
              account      = gs_auth-account
              acpass       = gs_auth-acpass
              pattern      = data-header-zpattern
              serial       = data-header-zserial
              xml_inv_data = format_xml_replace( )
              fkey         = data-header-originuuid
    ).
    gv_vnpt_service->replace_inv(
      EXPORTING
        input      = request_replace_fkey
        fkey       = data-header-uuid
      IMPORTING
        code       = DATA(lv_code)
        einvoiceno = lv_einvoiceno ).
    IF lv_code = 'OK'.
      ls_zeinv_hd = CORRESPONDING #( data-header ).
      ls_zeinv_hd-einvoiceno_long = |{ data-header-zpattern(1) }{ data-header-zserial }.{ lv_einvoiceno }|.
      update_reference( i_einvoice_long = ls_zeinv_hd-einvoiceno_long ).

      ls_zeinv_hd-uuidstatus = zeinv_if_constants~status_published.
      ls_zeinv_hd-einvoiceno = lv_einvoiceno.

      MODIFY zeinv_tb_hd FROM @ls_zeinv_hd.
      response_data-status = 'S'.
      response_data-message = |Phát hành thành công hoá đơn { ls_zeinv_hd-einvoiceno_long }|.
      LOOP AT data-item REFERENCE INTO DATA(ls_item).
        CLEAR ls_zeinv_hd_i.
        ls_zeinv_hd_i =  CORRESPONDING #( ls_item->* ).
        ls_zeinv_hd_i-uuid = ls_zeinv_hd-uuid.
        MODIFY zeinv_tb_hd_i FROM @ls_zeinv_hd_i.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD update_reference.


    DATA: lt_je  TYPE TABLE FOR ACTION IMPORT i_journalentrytp~change.
    APPEND INITIAL LINE TO lt_je ASSIGNING FIELD-SYMBOL(<je>).
    <je>-accountingdocument = data-header-accountingdocument.
    <je>-fiscalyear = data-header-fiscalyear.
    <je>-companycode = data-header-companycode.
    <je>-%param-documentreferenceid = i_einvoice_long.
    <je>-%param-%control-documentreferenceid = if_abap_behv=>mk-on.

    MODIFY ENTITIES OF i_journalentrytp
         ENTITY journalentry
         EXECUTE change FROM lt_je
           FAILED DATA(ls_failed_deep)
           REPORTED DATA(ls_reported_deep)
           MAPPED DATA(ls_mapped_deep).
    IF ls_failed_deep IS NOT INITIAL.
      ROLLBACK ENTITIES.
    ELSE.
      COMMIT ENTITIES BEGIN
        RESPONSE OF i_journalentrytp
          FAILED DATA(lt_commit_failed)
          REPORTED DATA(lt_commit_reported).
      COMMIT ENTITIES END.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
