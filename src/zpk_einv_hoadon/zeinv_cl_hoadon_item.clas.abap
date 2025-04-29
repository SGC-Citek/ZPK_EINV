*----------------------------------------------------------------------*
* Citek JSC.
* (C) Copyright Citek JSC.
* All Rights Reserved
*----------------------------------------------------------------------*
* Application : E-Invoice
* Creation Date: Jan 01, 2024
* Created by: NganNM
*----------------------------------------------------------------------*
CLASS zeinv_cl_hoadon_item DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider .

    DATA:
      gr_belnr          TYPE RANGE OF belnr_d,
      gr_vbeln          TYPE RANGE OF vbeln_vl,
      gr_posnr          TYPE RANGE OF zde_posnr,
      gr_companycode    TYPE RANGE OF bukrs, "bill-fi-po
      gr_gjahr          TYPE RANGE OF gjahr,
      p_sourcetype      TYPE zeinv_sourcetype,
      p_loainvdc        TYPE zeinv_i_hoadon-loainghiepvudieuchinh,
      p_sothamkhao      TYPE  c LENGTH 30,
      p_itemforeinvoice TYPE n LENGTH 5.

    DATA:
      p_billingaltunit   TYPE abap_boolean,
      p_billinggeneral   TYPE abap_boolean,
      p_allbillingdetail TYPE abap_boolean,
      p_formatnumber     TYPE zeinv_de_numberformat.

    DATA: p_loaihoadon TYPE c LENGTH 5.


    DATA:

      p_dispnsx       TYPE abap_boolean,
      p_numformattype TYPE abap_boolean,
      p_dispvaluedv   TYPE c LENGTH 1,

      p_normal        TYPE abap_boolean,
      p_replace       TYPE abap_boolean,
      p_adjust        TYPE abap_boolean,
      p_cancel        TYPE abap_boolean.

    DATA:     gt_goodtype TYPE HASHED TABLE OF zeinv_i_goodtype WITH UNIQUE KEY goodtype.

    DATA : gt_data TYPE TABLE OF zeinv_i_hoadon_item.

  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS: gc_comm_scenario TYPE if_com_management=>ty_cscn_id VALUE 'ZCORE_CS_SAP',
               gc_service_id    TYPE if_com_management=>ty_cscn_outb_srv_id VALUE 'Z_API_SAP_REST'.

    METHODS get_billing_item.
    METHODS get_published_item.
    METHODS get_po_item .
    METHODS convert_dec_4 IMPORTING i_value        TYPE zeinv_i_hoadon_item-amountaftertax
                          RETURNING VALUE(o_value) TYPE zeinv_i_hoadon_item-amountaftertax.
    METHODS get_fi_item.
    METHODS convert_external_amount CHANGING data TYPE  zeinv_i_hoadon_item.
ENDCLASS.



CLASS ZEINV_CL_HOADON_ITEM IMPLEMENTATION.


  METHOD convert_dec_4.
    DATA: lv_dec_4 TYPE zde_31_dec_4.
    lv_dec_4 = i_value.
    o_value = lv_dec_4.
  ENDMETHOD.


  METHOD convert_external_amount.
    IF data-transactioncurrency = 'VND'.
      data-taxamount = data-taxamount * 100.
      data-netpriceafterdiscount = data-netpriceafterdiscount * 100.
      data-netpricebeforediscount = data-netpricebeforediscount * 100.
      data-amountaftertax = data-amountaftertax * 100.
      data-amountbeforetax = data-amountbeforetax * 100.
    ENDIF.
  ENDMETHOD.


  METHOD get_billing_item.
    TYPES:
      BEGIN OF lty_key_billing,
        billingdocument     TYPE i_billingdocument-billingdocument,
        billingdocumentitem TYPE i_billingdocumentitem-billingdocumentitem,
      END OF lty_key_billing,
      BEGIN OF lty_key_saleorder,
        salesdocument     TYPE i_salesdocumentitem-salesdocument,
        salesdocumentitem TYPE i_salesdocumentitem-salesdocumentitem,
      END OF lty_key_saleorder.
    DATA:
      lt_key_billing   TYPE HASHED TABLE OF lty_key_billing WITH UNIQUE KEY billingdocument billingdocumentitem,
      lt_key_saleorder TYPE HASHED TABLE OF lty_key_saleorder WITH UNIQUE KEY salesdocument salesdocumentitem.
    IF p_replace = abap_true.
      SELECT
          originbill~billingdocument AS originbill,
          originbill~fiscalyear,
          originbill~companycode,
          originbill~accountingdocument,
          zeinv_tb_hd~zpattern,
          zeinv_tb_hd~zserial,
          zeinv_tb_hd~einvoiceno,
          zeinv_tb_hd~ngayhoadon,
          replacebill~billingdocument AS replacebill
      FROM i_billingdocument AS originbill
      INNER JOIN i_billingdocumentitem AS originbillitem ON originbill~billingdocument = originbillitem~billingdocument
      INNER JOIN i_billingdocumentitem AS replacebillitem ON replacebillitem~referencesddocument = originbillitem~referencesddocument
      INNER JOIN i_billingdocument AS replacebill ON replacebill~billingdocument = replacebillitem~billingdocument
      INNER JOIN zeinv_tb_hd ON zeinv_tb_hd~billingdocument = originbill~billingdocument
*      where originbill~yy1_sd_07_bdh = @abap_true
       WHERE originbill~cancelledbillingdocument IS INITIAL
        AND replacebill~cancelledbillingdocument IS INITIAL
        AND replacebill~billingdocumentiscancelled IS INITIAL
        AND replacebill~billingdocument IN @gr_vbeln
      INTO TABLE @DATA(lt_replacebill).
    ENDIF.

    IF p_adjust = abap_true.
      SELECT
          creditmemo~accountingdocexternalreference AS originbill,
          originbill~fiscalyear,
          originbill~companycode,
          originbill~accountingdocument,
          zeinv_tb_hd~zpattern,
          zeinv_tb_hd~zserial,
          zeinv_tb_hd~einvoiceno,
          zeinv_tb_hd~ngayhoadon,
          adjustbill~billingdocument AS adjustbill
      FROM i_billingdocument AS adjustbill
      INNER JOIN i_billingdocumentitem AS adjustbillitem ON adjustbill~billingdocument = adjustbillitem~billingdocument
      INNER JOIN i_creditmemorequest AS creditmemo ON adjustbillitem~referencesddocument = creditmemo~creditmemorequest
      INNER JOIN i_billingdocument AS originbill ON originbill~billingdocument = creditmemo~accountingdocexternalreference
      INNER JOIN zeinv_tb_hd ON zeinv_tb_hd~billingdocument = originbill~billingdocument
      WHERE originbill~cancelledbillingdocument IS INITIAL
        AND adjustbill~cancelledbillingdocument IS INITIAL
        AND adjustbill~billingdocumentiscancelled IS INITIAL
        AND adjustbill~billingdocument IN @gr_vbeln
      INTO TABLE @DATA(lt_adjustbill).
    ENDIF.

    IF p_adjust = abap_true OR p_replace = abap_true.
      SELECT zeinv_tb_hd_i~uuid,
             zeinv_tb_hd_i~itemforeinvoice,
             zeinv_tb_hd~billingdocument,
             zeinv_tb_hd_i~itemtext
        FROM zeinv_tb_hd
        INNER JOIN zeinv_tb_hd_i ON zeinv_tb_hd~uuid = zeinv_tb_hd_i~uuid
        WHERE zeinv_tb_hd~billingdocument IN @gr_vbeln
          AND zeinv_tb_hd~uuidstatus      IN ( '5', '1','2' )
        INTO TABLE @DATA(lt_itemtext_addjust).
      IF sy-subrc = 0.
        SORT lt_itemtext_addjust BY billingdocument itemforeinvoice.
      ENDIF.
    ENDIF.

    SELECT
        'BILL' AS sourcetype,
        @p_loaihoadon AS loaihoadon,
        @p_billingaltunit AS billingaltunit,
        @p_billinggeneral AS billinggeneral ,
        @p_allbillingdetail AS allbillingdetail,
        @p_loainvdc AS loainghiepvudieuchinh,
        @p_formatnumber     AS formatnumber,
        vbrk~companycode,
        vbrk~accountingdocument,
        vbrk~fiscalyear,
        vbrp~billingdocument,
        vbrp~billingdocumentitem,
        vbrp~salesdocument,
        vbrp~salesdocumentitem,
        vbrp~referencesddocument,
        vbrp~referencesddocumentitem,
        vbrp~salesdocumentitemcategory,
        vbrp~sddocumentreason,
        vbrp~product,
        vbrp~taxcode,
        billtyp~billnghiepvu,
*        billtyp~note AS ghichu,
*        billtyp~note_mvgr1 AS notekm,
        billtyp~note_mvgr1 AS ghichu,
        i_product~producttype,
        batchncc~charcvalue AS batchncc,
        hansudung~charcfromdate AS hansudung,
        vbrp~billingdocumentitemtext AS itemtext,
        vbrp~billingquantityunit,
        i_unitofmeasuretext~unitofmeasurename AS unitname,
        altunit~unitofmeasurename AS altunitname,
        vbrk~transactioncurrency,
        vbrk~accountingexchangerate,
        vbrp~billingquantity,
        vbrp~subtotal4amount,
        vbrp~subtotal5amount,
        vbrp~subtotal3amount,
        vbrp~subtotal2amount,
        vbrp~subtotal1amount,
        vbrp~taxamount,
        abs( discount~conditionratevalue ) AS discountrate,
        CASE WHEN vbrp~salesdocumentitemcategory = 'TAD' THEN @abap_true
              ELSE @abap_false END AS isdichvu
    FROM i_billingdocument AS vbrk
    INNER JOIN i_billingdocumentitem  AS vbrp ON vbrk~billingdocument = vbrp~billingdocument
    INNER JOIN zeinv_tb_billtyp AS billtyp ON billtyp~billingtype = vbrk~billingdocumenttype
                               AND billtyp~orderreason = vbrp~sddocumentreason
                               AND billtyp~mvgr1       = vbrp~additionalmaterialgroup1
    LEFT JOIN i_product ON i_product~product = vbrp~product
    LEFT JOIN i_unitofmeasuretext ON i_unitofmeasuretext~unitofmeasure = vbrp~billingquantityunit
                                 AND i_unitofmeasuretext~language = @sy-langu
    LEFT JOIN i_unitofmeasuretext AS altunit ON altunit~unitofmeasure = vbrp~billingquantityunit
                                            AND altunit~language = @sy-langu
    LEFT JOIN i_billingdocumentitemprcgelmnt AS discount ON  discount~billingdocument    = vbrp~billingdocument
                                                        AND discount~billingdocumentitem = vbrp~billingdocumentitem
                                                        AND discount~conditiontype       = 'ZDC1'
*    LEFT JOIN i_salesdocumentitem ON i_salesdocumentitem~salesdocument = vbrp~salesdocument
*                                 AND i_salesdocumentitem~salesdocumentitem = vbrp~salesdocumentitem
    LEFT JOIN zi_batch_ncc AS batchncc ON batchncc~material = vbrp~product
                                      AND batchncc~plant = vbrp~plant
                                      AND batchncc~batch = vbrp~batch
    LEFT JOIN zi_batch_hansudung AS hansudung ON hansudung~material = vbrp~product
                                      AND hansudung~plant = vbrp~plant
                                      AND hansudung~batch = vbrp~batch
    WHERE vbrk~billingdocument IN @gr_vbeln
    AND vbrp~billingquantity <> 0 "Chỉ lấy những dòng dữ liệu có Billed qty <> 0
    ORDER BY vbrp~billingdocument, vbrp~billingdocumentitem
    INTO TABLE @DATA(lt_data).

    SELECT DISTINCT
        zeinv_tb_taxcode~taxcode,
        zeinv_tb_taxcode~einvoicetax
     FROM zeinv_tb_taxcode
     ORDER BY  zeinv_tb_taxcode~taxcode
     INTO TABLE @DATA(lt_taxcode).

    DATA:
      ls_append_data     LIKE LINE OF gt_data,
      iv_addlast         TYPE abap_boolean,
      iv_isdieuchinh     TYPE abap_boolean,
      iv_iskmcdk         TYPE abap_boolean,
      iv_iskmkdk         TYPE abap_boolean,
      lv_itemforeinvoice TYPE n LENGTH 5.

    IF  lt_data IS NOT INITIAL.

*  check neu Item co hang uy thac thi xuat hd VND
      SELECT
          i_billingdocumentitem~billingdocument,
          data~accountingexchangerate,
          matlaccountassignmentgroup
      FROM i_billingdocumentitem
      INNER JOIN @lt_data AS data ON data~billingdocument = i_billingdocumentitem~billingdocument
      WHERE i_billingdocumentitem~matlaccountassignmentgroup = 'ZC' "Hàng ủy thác
      ORDER BY i_billingdocumentitem~billingdocument
      INTO TABLE @DATA(lt_hanguythac).

*  check neu Item co hang uy thac thi xuat hd VND
      SELECT DISTINCT
          data~companycode,
          sourcecurrency,
          numberofsourcecurrencyunits,
          numberoftargetcurrencyunits
      FROM i_exchangeraterawdata
      INNER JOIN i_companycode ON i_exchangeraterawdata~targetcurrency = i_companycode~currency
      INNER JOIN @lt_data AS data ON data~companycode = i_companycode~companycode
                                 AND data~transactioncurrency = i_exchangeraterawdata~sourcecurrency
      ORDER BY  data~companycode, sourcecurrency
      INTO TABLE @DATA(lt_curr).


      iv_addlast = abap_false.
      iv_iskmcdk = abap_false.
      iv_iskmkdk = abap_false.

      IF p_billingaltunit =  abap_true.
        SELECT DISTINCT
            i_productunitsofmeasure~product,
            i_productunitsofmeasure~alternativeunit,
            i_productunitsofmeasure~quantitydenominator,
            i_productunitsofmeasure~quantitynumerator,
            i_unitofmeasure~unitofmeasure,
            i_unitofmeasure~unitofmeasure_e,
            i_unitofmeasuretext~unitofmeasurename
        FROM i_productunitsofmeasure
        INNER JOIN i_unitofmeasure ON i_unitofmeasure~unitofmeasure = i_productunitsofmeasure~alternativeunit
        INNER JOIN i_unitofmeasuretext ON i_unitofmeasuretext~unitofmeasure = i_unitofmeasure~unitofmeasure
                                      AND i_unitofmeasuretext~language = @sy-langu
        INNER JOIN @lt_data AS data ON data~product = i_productunitsofmeasure~product
        ORDER BY i_productunitsofmeasure~product
        INTO TABLE @DATA(lt_productunitsofmeasure).
      ENDIF.

      " get billing long text
      DATA(lt_billing) = CORRESPONDING zcore_cl_get_long_text=>ty_billing( lt_data DISCARDING DUPLICATES ).
      DATA(lt_billingheadertext) = zcore_cl_get_long_text=>get_multi_billing_header_text( it_billing = lt_billing ).
      DATA(lt_billingitemtext) = zcore_cl_get_long_text=>get_multi_billing_item_text( it_billing = lt_billing ).

      " get material header text
      DATA(lt_product) = CORRESPONDING zcore_cl_get_long_text=>ty_product( lt_data DISCARDING DUPLICATES ).
      DATA(lt_productbasictext) = zcore_cl_get_long_text=>get_multi_material_basic_text( it_material = lt_product ).
      DATA(lt_productsalestext) = zcore_cl_get_long_text=>get_multi_product_text( it_material = lt_product what_get = 'sales' ).

      lt_key_saleorder = CORRESPONDING #( lt_data DISCARDING DUPLICATES ).
      SELECT
          salesorder~salesdocument,
          salesorder~salesdocumentitem,
          pricingprocedurestep,
          conditiontype,
          conditionrateamount,
          conditionquantity,
          conditionratevalue,
          transactioncurrency,
          conditionamount,
          taxcode
      FROM @lt_key_saleorder AS salesorder
      LEFT JOIN i_salesdocitempricingelement ON i_salesdocitempricingelement~salesdocument = salesorder~salesdocument
                                            AND i_salesdocitempricingelement~salesdocumentitem = salesorder~salesdocumentitem
     WHERE i_salesdocitempricingelement~conditioninactivereason = @space
      ORDER BY salesorder~salesdocument,
               salesorder~salesdocumentitem,
               i_salesdocitempricingelement~pricingprocedurestep,
               conditiontype
      INTO TABLE @DATA(lt_salesorderitemprice).

      DATA:
        ls_data   LIKE LINE OF gt_data,
        lv_per    TYPE i_billingdocumentitemprcgelmnt-conditionquantity,
        lt_dichvu TYPE HASHED TABLE OF zeinv_i_hoadon_item WITH UNIQUE KEY billingdocument product.
      DATA:
        lv_ghichu_nghiepvu TYPE string.

      LOOP AT lt_data REFERENCE INTO DATA(ls_temp).

        ls_data = CORRESPONDING #( ls_temp->* ).
        ls_data-sothamkhao = |{ ls_temp->billingdocument ALPHA = OUT }|.
        ls_data-loaihoadon = p_loaihoadon.
        CLEAR ls_data-billingdocumentitem.

        lv_ghichu_nghiepvu = ls_temp->ghichu.

        "Đơn giá trước chiết khấu
*        READ TABLE lt_salesorderitemprice REFERENCE INTO DATA(ls_salesorderpriceitem)
*        WITH KEY salesdocument = ls_temp->salesdocument
*                 salesdocumentitem = ls_temp->salesdocumentitem
*                 conditiontype = 'ZPRR'.
*        IF sy-subrc = 0.
*          ls_data-netpricebeforediscount = ls_salesorderpriceitem->conditionrateamount / ls_salesorderpriceitem->conditionquantity.
*        ELSE.
*          READ TABLE lt_salesorderitemprice REFERENCE INTO ls_salesorderpriceitem
*          WITH KEY salesdocument = ls_temp->salesdocument
*                 salesdocumentitem = ls_temp->salesdocumentitem
*                   conditiontype = 'ZPR1'.
*          IF sy-subrc = 0.
*            ls_data-netpricebeforediscount = ls_salesorderpriceitem->conditionrateamount / ls_salesorderpriceitem->conditionquantity.
*          ELSE.
*            READ TABLE lt_salesorderitemprice REFERENCE INTO ls_salesorderpriceitem
*            WITH KEY salesdocument = ls_temp->salesdocument
*                     salesdocumentitem = ls_temp->salesdocumentitem
*                     conditiontype = 'ZPR0'.
*            IF sy-subrc = 0.
*              ls_data-netpricebeforediscount = ls_salesorderpriceitem->conditionrateamount / ls_salesorderpriceitem->conditionquantity.
*            ENDIF.
*          ENDIF.
*        ENDIF.
*        ls_data-netpricebeforediscount = convert_dec_4( ls_data-netpricebeforediscount ).



        READ TABLE lt_salesorderitemprice REFERENCE INTO DATA(ls_salesorderpriceitem)
            WITH KEY salesdocument     = ls_temp->salesdocument
                     salesdocumentitem = ls_temp->salesdocumentitem
                     conditiontype     = 'TTX1'.
        IF sy-subrc = 0.
          ls_data-taxrate = ls_salesorderpriceitem->conditionratevalue.
        ENDIF.
        READ TABLE lt_taxcode REFERENCE INTO DATA(ls_taxcode)
         WITH KEY taxcode = ls_data-taxcode BINARY SEARCH.
        IF sy-subrc = 0.
          ls_data-einvoicetax = ls_taxcode->einvoicetax.
        ENDIF.

        ls_data-amountbeforetax = ls_temp->subtotal1amount .
        IF ls_data-transactioncurrency = 'VND'.
          ls_data-amountbeforetax  = ls_data-amountbeforetax  * 100.
          ls_data-taxamount  = ls_data-taxamount  * 100.
        ENDIF.
        ls_data-taxamount = convert_dec_4( ls_data-taxamount ).

        ls_data-amountaftertax = ls_data-amountbeforetax + ls_data-taxamount.

        ls_data-einvoicequanity = ls_temp->billingquantity.
        ls_data-einvoiceunit = ls_temp->billingquantityunit.

        IF p_dispvaluedv = abap_false  AND ls_temp->producttype = 'M98'.
          CLEAR : ls_data-einvoiceunit, ls_data-unitname, ls_data-einvoicequanity,ls_data-netpriceafterdiscount, ls_data-netpricebeforediscount.
        ENDIF.

        "Hóa đơn CKTM: đối với billing có loại nghiệp vụ = 5 - HĐ CKTM thì để trống các thông tin Đơn vị tính, số lượng, đơn giá, CK, Đơn giá sau CK
        IF ls_temp->billnghiepvu = '5'.
          CLEAR:
          ls_data-einvoiceunit, ls_data-einvoicequanity, ls_data-netpricebeforediscount, ls_data-discountrate, ls_data-netpriceafterdiscount, ls_data-unitname.
          ls_data-goodtypeineinvoice =  zeinv_if_constants=>line_discount_78.
        ELSEIF ls_temp->salesdocumentitemcategory = 'CBXN' AND ls_temp->sddocumentreason =  'Z03'.
          ls_data-goodtypeineinvoice = zeinv_if_constants=>line_good_service_78.
        ELSEIF ls_temp->salesdocumentitemcategory = 'TANN' OR ls_temp->salesdocumentitemcategory = 'CBXN'.
          ls_data-goodtypeineinvoice = zeinv_if_constants=>line_promo_78.
        ELSE.
          IF ls_data-amountbeforetax = 0.
            "Trường hợp billing line có giá trị = 0 thì hiển thị
            "“Hàng khuyến mãi không thu tiền”  tách thành dòng cuối cùng trên hóa đơn
            iv_addlast = abap_true.
          ELSE.
            ls_data-goodtypeineinvoice = zeinv_if_constants=>line_good_service_78.
          ENDIF.
        ENDIF.

        "HĐ KM có ĐK
        IF ls_temp->billnghiepvu = '1'.
          iv_iskmcdk = abap_true.
        ENDIF.
        "HĐ KM không ĐK
        IF ls_temp->billnghiepvu = '2'.
          iv_iskmkdk = abap_true.
        ENDIF.

*    "tem text - Diễn giải hàng hoá - Material Description
*    "Trường hợp xuất hóa đơn bán hàng từ SD thì lấy tên hàng hóa từ Billing.
*    "Lấy theo các ưu tiên sau:
*       + Ưu  tiên 1: [App] Display Billing Document VF03 Item Text  lấy Material Sales text, ID type = 0001
*       + Ưu tiên 2: [App] Display Material MM03 => Tab Basic Data 1 => Field Basic Data Text của Material
*       + Ưu tiên 3: [App] Display Billing Document VF03 => Lấy description của material trong MM03

        READ TABLE lt_productsalestext INTO DATA(ls_productsalestext)
        WITH KEY  product = ls_temp->product.
        IF  sy-subrc = 0 AND ls_productsalestext-long_text IS NOT INITIAL.
          ls_data-itemtext = ls_productsalestext-long_text.
        ELSE.
          READ TABLE lt_productbasictext INTO DATA(ls_productbasictext)
          WITH KEY product = ls_temp->product.
          IF sy-subrc = 0 AND ls_productbasictext-long_text IS NOT INITIAL.
            ls_data-itemtext = ls_productbasictext-long_text.
          ENDIF.
        ENDIF.

        "lấy description cho issum
        READ  TABLE gt_goodtype WITH KEY goodtype = ls_data-goodtypeineinvoice REFERENCE INTO DATA(ls_goodtype).
        IF sy-subrc = 0.
          ls_data-goodtypeineinvoicetext = ls_goodtype->goodtypetext.
        ENDIF.

        "tách riêng line dịch vụ và line hàng hoá
        IF p_billinggeneral = abap_true.
          READ TABLE lt_dichvu REFERENCE INTO DATA(ls_dichvu)
          WITH KEY billingdocument = ls_temp->billingdocument
                   product = ls_temp->product.
          IF sy-subrc = 0.
            ls_dichvu->itemtext               = ls_dichvu->itemtext.
            ls_dichvu->amountaftertax         = ls_dichvu->amountaftertax + ls_data-amountaftertax.
            ls_dichvu->amountbeforetax        = ls_dichvu->amountbeforetax + ls_data-amountbeforetax.
            ls_dichvu->taxamount              = ls_dichvu->taxamount +  ls_data-taxamount.
            ls_dichvu->netpriceafterdiscount  = ls_data-netpriceafterdiscount.
            ls_dichvu->netpricebeforediscount = ls_dichvu->netpricebeforediscount.
            ls_dichvu->einvoicequanity        = ls_dichvu->einvoicequanity + ls_data-einvoicequanity.
            IF ls_data-einvoicetax IS NOT INITIAL.
              ls_dichvu->einvoicetax            = ls_data-einvoicetax.
            ENDIF.

          ELSE.
*            CLEAR : ls_data-billingdocumentitem, ls_data-taxcode, ls_data-taxrate, ls_data-einvoicetax.
            INSERT ls_data INTO TABLE lt_dichvu.
          ENDIF.
        ELSE.



          "append line hàng hoá/dịch vụ chính của hoá đơn
          APPEND ls_data TO gt_data.

          CLEAR ls_data.
        ENDIF.
      ENDLOOP.

*///////Đơn vị quy đổi
      FREE lt_data.
      FREE lt_salesorderitemprice.
      APPEND LINES OF lt_dichvu TO gt_data.
      FREE lt_dichvu.
      LOOP AT gt_data REFERENCE INTO DATA(lr_data).
        lr_data->netpriceafterdiscount = lr_data->amountbeforetax.
        lr_data->netpriceafterdiscount = lr_data->netpriceafterdiscount / lr_data->einvoicequanity.
        lr_data->netpriceafterdiscount = convert_dec_4( lr_data->netpriceafterdiscount ).
        "FORMAT NUMBER HOÁ ĐƠN THAY THẾ
        IF p_loaihoadon = 'ADJ'.
          CASE p_formatnumber.
            WHEN '1'.
              lr_data->netpriceafterdiscount = lr_data->netpriceafterdiscount * -1.
            WHEN '2'.
            WHEN '3'.
              lr_data->einvoicequanity = lr_data->einvoicequanity * -1.
          ENDCASE.

        ENDIF.
      ENDLOOP.

      DATA: lv_item TYPE n LENGTH 5.
      lv_item = 0.
      LOOP AT gt_data REFERENCE INTO lr_data WHERE goodtypeineinvoice <> zeinv_if_constants=>line_note_78.
        lv_item += 1.
        lr_data->itemforeinvoice = lv_item.
        "append line đơn vị quy đổi
        IF p_billingaltunit =  abap_true.
          IF lr_data->einvoiceunit <> lr_data->yy1_einvoiceunit_prd.
            READ TABLE lt_productunitsofmeasure REFERENCE INTO DATA(ls_unitout)
            WITH KEY product = lr_data->product
                     unitofmeasure_e = lr_data->yy1_einvoiceunit_prd.
            IF sy-subrc = 0.
              READ TABLE lt_productunitsofmeasure REFERENCE INTO DATA(ls_unitin)
              WITH KEY product = lr_data->product
                       alternativeunit = lr_data->einvoiceunit BINARY SEARCH.
              IF sy-subrc = 0.
                lv_item += 1.
                APPEND VALUE #(
                     sourcetype             = lr_data->sourcetype
                     loaihoadon             = p_loaihoadon
                     billingdocument        = lr_data->billingdocument
                     billingdocumentitem    = lr_data->billingdocumentitem
                     companycode            = lr_data->companycode
                     accountingdocument     = lr_data->accountingdocument
                     fiscalyear             = lr_data->fiscalyear
                     accountingdocumentitem = lr_data->accountingdocumentitem
                     referencesddocument    = lr_data->referencesddocument
                     purchaseorder          = lr_data->purchaseorder
                     allbillingdetail       = lr_data->allbillingdetail
                     billinggeneral         = lr_data->billinggeneral
                     billingaltunit         = lr_data->billingaltunit
                     sothamkhao             = lr_data->sothamkhao
                     goodtypeineinvoice     = zeinv_if_constants=>line_note_78
                     goodtypeineinvoicetext = 'Ghi chú/diễn giải'
                     itemforeinvoice        = lv_item
                     itemtext               = 'Đơn vị quy đổi:'
                     einvoiceunit           = ls_unitout->unitofmeasure
                     unitname               = ls_unitout->unitofmeasurename
                     einvoicequanity        = ( lr_data->einvoicequanity * ls_unitin->quantitynumerator * ls_unitout->quantitydenominator ) / ( ls_unitin->quantitydenominator * ls_unitout->quantitynumerator )
                ) TO gt_data.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.

      ENDLOOP.

*///////Hàng khuyến mãi không thu tiền
      IF iv_addlast = abap_true.
        lv_item += 1.
        APPEND VALUE #( sourcetype             = lr_data->sourcetype
                        loaihoadon             = p_loaihoadon
                        billingdocument        = lr_data->billingdocument
                        companycode            = lr_data->companycode
                        accountingdocument     = lr_data->accountingdocument
                        fiscalyear             = lr_data->fiscalyear
                        accountingdocumentitem = lr_data->accountingdocumentitem
                        referencesddocument    = lr_data->referencesddocument
                        purchaseorder          = lr_data->purchaseorder
                        allbillingdetail       = lr_data->allbillingdetail
                        billinggeneral         = lr_data->billinggeneral
                        billingaltunit         = lr_data->billingaltunit
                        sothamkhao             = lr_data->sothamkhao
                        itemforeinvoice        = lv_item
                        itemtext               = 'Hàng khuyến mãi không thu tiền'
                        goodtypeineinvoice     = zeinv_if_constants=>line_note_78
                        goodtypeineinvoicetext = 'Ghi chú/diễn giải' ) TO gt_data.
      ENDIF.


*///////Xử lý ghi chú nghiệp vụ
      IF lv_ghichu_nghiepvu IS NOT INITIAL.
        lv_item += 1.
        APPEND VALUE #(
                      sourcetype             = lr_data->sourcetype
                      loaihoadon             = p_loaihoadon
                      billingdocument        = lr_data->billingdocument
                      billingdocumentitem    = lr_data->billingdocumentitem
                      companycode            = lr_data->companycode
                      accountingdocument     = lr_data->accountingdocument
                      fiscalyear             = lr_data->fiscalyear
                      referencesddocument    = lr_data->referencesddocument
                      allbillingdetail       = lr_data->allbillingdetail
                      billinggeneral         = lr_data->billinggeneral
                      billingaltunit         = lr_data->billingaltunit
                      sothamkhao             = lr_data->billingdocument
                      goodtypeineinvoice     = zeinv_if_constants=>line_note_78
                      itemforeinvoice        = lv_item
                      goodtypeineinvoicetext = 'Ghi chú/diễn giải'
                      itemtext               = lv_ghichu_nghiepvu
        ) TO gt_data.
      ENDIF.
      lv_item += 1.
      READ TABLE lt_billingheadertext REFERENCE INTO DATA(ls_billingheadertext)
                                      WITH KEY billing_document = lr_data->billingdocument
                                               long_text_id     = 'Z002'.
      IF sy-subrc = 0.
        lv_item += 1.
        APPEND VALUE #(
                      sourcetype             = lr_data->sourcetype
                      loaihoadon             = p_loaihoadon
                      billingdocument        = lr_data->billingdocument
                      billingdocumentitem    = lr_data->billingdocumentitem
                      companycode            = lr_data->companycode
                      accountingdocument     = lr_data->accountingdocument
                      fiscalyear             = lr_data->fiscalyear
                      referencesddocument    = lr_data->referencesddocument
                      allbillingdetail       = lr_data->allbillingdetail
                      billinggeneral         = lr_data->billinggeneral
                      billingaltunit         = lr_data->billingaltunit
                      sothamkhao             = lr_data->billingdocument
                      goodtypeineinvoice     = zeinv_if_constants=>line_note_78
                      itemforeinvoice        = lv_item
                      goodtypeineinvoicetext = 'Ghi chú/diễn giải'
                      itemtext               = ls_billingheadertext->long_text
        ) TO gt_data.
      ENDIF.
      FREE   lv_ghichu_nghiepvu.

*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      DATA:
          lv_exchangerate TYPE zde_kursf.
      SELECT SINGLE * FROM zeinv_tb_debcre WHERE type = @p_numformattype INTO @DATA(ls_debcre).
      LOOP AT gt_data REFERENCE INTO lr_data.
*////// Check hàng uỷ thác
        lv_exchangerate = 1.
        READ TABLE lt_hanguythac REFERENCE INTO DATA(ls_hanguythac)
        WITH KEY billingdocument = lr_data->billingdocument BINARY SEARCH.
        IF sy-subrc = 0.

          lv_exchangerate = ls_hanguythac->accountingexchangerate .

          lr_data->amountaftertax = lr_data->amountaftertax * lv_exchangerate.
          lr_data->amountbeforetax = lr_data->amountbeforetax * lv_exchangerate.
          lr_data->netpriceafterdiscount = lr_data->netpriceafterdiscount * lv_exchangerate.
          lr_data->netpricebeforediscount = lr_data->netpricebeforediscount * lv_exchangerate.
          lr_data->taxamount = lr_data->taxamount * lv_exchangerate.

        ENDIF.
        IF p_adjust IS NOT INITIAL OR p_replace IS NOT INITIAL.
          READ TABLE lt_itemtext_addjust INTO DATA(ls_itemtext_addjust) WITH KEY billingdocument = lr_data->billingdocument
                                                                                 itemforeinvoice = lr_data->itemforeinvoice BINARY SEARCH.
          IF sy-subrc = 0.
            lr_data->itemtext = ls_itemtext_addjust-itemtext.
            CLEAR: ls_itemtext_addjust.
          ENDIF.
        ENDIF.

      ENDLOOP.

*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      SORT gt_data BY itemforeinvoice.
      IF p_itemforeinvoice IS NOT INITIAL.
        DELETE gt_data WHERE itemforeinvoice <> p_itemforeinvoice.
      ENDIF.

    ENDIF.
  ENDMETHOD.


  METHOD get_fi_item.

    DATA: lw_tax  TYPE fins_vwcur12.

    SELECT DISTINCT
       zeinv_tb_taxcode~taxcode,
       zeinv_tb_taxcode~einvoicetax  AS value
    FROM zeinv_tb_taxcode
    ORDER BY  zeinv_tb_taxcode~taxcode
    INTO TABLE @DATA(lt_taxcode).

    DATA: ls_data TYPE zeinv_i_hoadon_item.
    SELECT
       'FI' AS sourcetype,

        bkpf~companycode,
        bkpf~fiscalyear,
        bkpf~accountingdocument,
        @p_formatnumber     AS formatnumber,
        CASE WHEN bseg~documentitemtext IS NOT INITIAL
             THEN bseg~documentitemtext
             ELSE bkpf_it~documentitemtext END AS  itemtext,
        bkpf~transactioncurrency,
        bseg~product,
        i_producttext~productname,
        bseg~taxcode,
        bseg~baseunit,
        bseg~amountintransactioncurrency,
        bseg~quantity,
        bseg~accountingdocumentitem,
        i_unitofmeasuretext~unitofmeasurename AS unitname
    FROM i_journalentry AS bkpf
    INNER JOIN i_operationalacctgdocitem AS bseg ON bkpf~companycode = bseg~companycode
                                                AND bkpf~fiscalyear = bseg~fiscalyear
                                                AND bkpf~accountingdocument = bseg~accountingdocument
    LEFT JOIN i_journalentryitem AS bkpf_it
                                 ON bkpf_it~accountingdocument = bseg~accountingdocument
                                AND bkpf_it~ledgergllineitem   = bseg~ledgergllineitem
                                AND bkpf_it~companycode        = bseg~companycode
                                AND bkpf~fiscalyear            = bseg~fiscalyear
    LEFT JOIN zeinv_i_fisum AS fisum ON bkpf~companycode = fisum~companycode
                                    AND bkpf~fiscalyear  = fisum~fiscalyear
                                    AND bkpf~accountingdocument = fisum~accountingdocument
    LEFT JOIN zeinv_i_fisumtax AS fisumtax ON bkpf~companycode        = fisumtax~companycode
                                          AND bkpf~fiscalyear         = fisumtax~fiscalyear
                                          AND bkpf~accountingdocument = fisumtax~accountingdocument
    LEFT JOIN i_producttext ON i_producttext~product = bseg~product
                           AND i_producttext~language = 'E'
    LEFT JOIN i_unitofmeasuretext ON i_unitofmeasuretext~unitofmeasure = bseg~baseunit
                                 AND i_unitofmeasuretext~language = 'E'
    WHERE ( bkpf~accountingdocumenttype  = 'DR' OR bkpf~accountingdocumenttype = 'DG' ) AND
            bkpf~companycode             IN @gr_companycode AND
            bkpf~accountingdocument      IN @gr_belnr AND
            bkpf~fiscalyear              IN @gr_gjahr AND
            ( bseg~glaccount LIKE '5%' OR bseg~glaccount LIKE '7%' ) AND
            ( bseg~postingkey = '40'     OR bseg~postingkey = '50')
*            bkpf~transactioncode         in ( 'FB70' , 'FB75', 'F-92', 'F-02', 'ZUP', 'FB50' )
    INTO TABLE @DATA(lt_data).
    IF sy-subrc = 0.
      LOOP AT lt_data REFERENCE INTO DATA(ls_temp).
        ls_temp->amountintransactioncurrency = abs( ls_temp->amountintransactioncurrency ).

        ls_data = CORRESPONDING #( ls_temp->* ).
        ls_data-loaihoadon             = p_loaihoadon.
        ls_data-itemforeinvoice = sy-tabix.
        ls_data-goodtypeineinvoice = zeinv_if_constants=>line_good_service_78.

        IF ls_temp->productname IS NOT INITIAL.
          ls_data-itemtext = ls_temp->productname.
        ENDIF.

        ls_data-einvoiceunit = ls_temp->baseunit.
        ls_data-einvoicequanity = ls_temp->quantity.

        READ TABLE lt_taxcode REFERENCE INTO DATA(ls_taxcode)
         WITH KEY taxcode = ls_temp->taxcode BINARY SEARCH.
        IF sy-subrc = 0.
          ls_data-taxrate     = ls_taxcode->value.
          ls_data-einvoicetax = ls_taxcode->value.
          "TaxCode
          IF ls_temp->taxcode = 'IK'  OR ls_temp->taxcode = 'NA'
           OR ls_temp->taxcode = 'NK' OR ls_temp->taxcode = 'NO' OR ls_temp->taxcode = 'NX'.
            lw_tax = 0.
          ELSE.
            lw_tax  =  ls_taxcode->value.
          ENDIF.
        ENDIF.
        TRY.
            ls_data-netpricebeforediscount = ls_temp->amountintransactioncurrency / ls_data-einvoicequanity.
            ls_data-netpriceafterdiscount = ls_temp->amountintransactioncurrency / ls_data-einvoicequanity.
          CATCH cx_sy_zerodivide.
            ls_data-netpricebeforediscount = ls_temp->amountintransactioncurrency.
            ls_data-netpriceafterdiscount = ls_temp->amountintransactioncurrency .
        ENDTRY.

        ls_data-amountbeforetax = ls_temp->amountintransactioncurrency.
        ls_data-taxamount = ls_data-amountbeforetax * lw_tax / 100.
        ls_data-amountaftertax = ls_data-amountbeforetax + ls_data-taxamount.

        convert_external_amount( CHANGING data = ls_data ).
        APPEND ls_data TO gt_data.
      ENDLOOP.

    ENDIF.
  ENDMETHOD.


  METHOD get_po_item.
    DATA: ls_data LIKE LINE OF gt_data,
          lw_tax  TYPE fins_vwcur12.

    SELECT DISTINCT
       zeinv_tb_taxcode~taxcode,
       zeinv_tb_taxcode~einvoicetax  AS value
    FROM zeinv_tb_taxcode
    ORDER BY  zeinv_tb_taxcode~taxcode
    INTO TABLE @DATA(lt_taxcode).

    SELECT FROM i_journalentry AS bkpf
     INNER JOIN i_journalentryitem AS bseg ON  bseg~companycode = bkpf~companycode
                                           AND bseg~fiscalyear = bkpf~fiscalyear
                                           AND bseg~accountingdocument = bkpf~accountingdocument
                                           AND substring( bseg~glaccount, 1 , 3 ) = '331'
                                           AND bseg~purchasingdocument IS NOT INITIAL
     LEFT JOIN i_suplrinvcitempurordrefapi01 AS resg
                                             ON resg~supplierinvoice   = bseg~referencedocument
                                            AND resg~purchaseorder     = bseg~purchasingdocument
                                            AND resg~purchaseorderitem = bseg~purchasingdocumentitem
     LEFT JOIN i_supplierinvoiceapi01 AS rbkp
                                      ON rbkp~supplierinvoice = resg~supplierinvoice
                                     AND rbkp~fiscalyear      = resg~fiscalyear
     LEFT JOIN zeinv_i_config ON zeinv_i_config~type = '1'
                                     AND zeinv_i_config~companycode = bkpf~companycode
                                     AND zeinv_i_config~sourcetype = 'PO'
                                     AND zeinv_i_config~validfrom <= @sy-datum
                                     AND zeinv_i_config~validto >= @sy-datum
                                     AND bseg~plant = zeinv_i_config~plant
     LEFT JOIN zeinv_tb_taxcode ON zeinv_tb_taxcode~taxcode = bseg~taxcode
     LEFT JOIN zeinv_i_loaithue ON zeinv_tb_taxcode~einvoicetax = zeinv_i_loaithue~einvoicetax
     LEFT JOIN i_product AS mara
                         ON mara~product = resg~purchaseorderitemmaterial
     LEFT JOIN i_unitofmeasuretext  AS uomtext
                                    ON uomtext~language      = 'E'
                                   AND uomtext~unitofmeasure = resg~purchaseorderquantityunit
    FIELDS DISTINCT
         'PO' AS sourcetype,
         @p_allbillingdetail AS allbillingdetail,
         @p_formatnumber     AS formatnumber,
         zeinv_i_config~zpattern,
         zeinv_i_config~zserial,
         bkpf~postingdate,
         bkpf~companycode,
         bkpf~fiscalyear,
         bkpf~accountingdocument,
         bkpf~transactioncurrency,
         bkpf~postingdate  AS ngayhoadon,
         bseg~taxcode,
         bseg~taxcode AS tax,
         bseg~plant,
         bseg~\_plant-plantname,
         bkpf~documentreferenceid,
         bseg~purchasingdocument AS purchaseorder,
         bseg~purchasingdocumentitem AS itemforeinvoice,
*          bseg~referencedocument AS documentnumber,
         resg~supplierinvoiceitem,
         resg~supplierinvoice,
         "PRODUCT
         resg~purchaseorderitemmaterial AS product,
         mara~\_text[ language = 'E' ]-productname AS itemtext,
         resg~quantityinpurchaseorderunit          AS einvoicequanity,
*         resg~purchaseorderquantityunit            AS unitname,
         uomtext~unitofmeasuretechnicalname        AS unitname,
         resg~supplierinvoiceitemamount            AS amountbeforetax,
         bkpf~absoluteexchangerate                 AS accountingexchangerate,
*          bseg~amountintransactioncurrency          AS amountbeforetax,

         "Value
         CASE zeinv_tb_taxcode~einvoicetax
           WHEN @zeinv_if_constants=>gc_tax_rate_id-_0pc THEN 0
           WHEN @zeinv_if_constants=>gc_tax_rate_id-_5pc THEN 5
           WHEN @zeinv_if_constants=>gc_tax_rate_id-_8pc THEN 8
           WHEN @zeinv_if_constants=>gc_tax_rate_id-_10pc THEN 10
         END AS vatrate,
         zeinv_i_loaithue~einvoicetaxtext AS desvatrate

     WHERE   bkpf~accountingdocumenttype = 'RE' AND
             bkpf~companycode            IN @gr_companycode AND
             bkpf~accountingdocument     IN @gr_belnr AND
             bkpf~isreversed IS INITIAL AND
             bkpf~isreversal IS INITIAL AND
             rbkp~isinvoice               = ' '  AND
             resg~issubsequentdebitcredit = ' '
     INTO TABLE @DATA(lt_data).
    IF sy-subrc = 0.

      DATA(lt_matnr)           = CORRESPONDING zcore_cl_get_long_text=>ty_product( lt_data DISCARDING DUPLICATES  ).
      DATA(lt_productsaletext) = zcore_cl_get_long_text=>get_multi_product_text( it_material = lt_matnr what_get = 'SALES'  ).
      LOOP AT lt_data REFERENCE INTO DATA(ls_temp).
        ls_data = CORRESPONDING #( ls_temp->* ).
        ls_data-loaihoadon      = p_loaihoadon.

        READ TABLE lt_productsaletext INTO DATA(ls_productsaletext)
                                      WITH KEY product = ls_data-product.
        IF sy-subrc = 0 AND ls_productsaletext-long_text IS NOT INITIAL.
          ls_data-itemtext = ls_productsaletext-long_text.
        ENDIF.

        READ TABLE lt_taxcode REFERENCE INTO DATA(ls_taxcode)
             WITH KEY taxcode = ls_temp->taxcode .
        IF sy-subrc = 0.
          ls_data-taxrate     = ls_taxcode->value.
          ls_data-einvoicetax = ls_taxcode->value.
          "TaxCode
          IF ls_temp->taxcode = 'IK'  OR ls_temp->taxcode = 'NA'
           OR ls_temp->taxcode = 'NK' OR ls_temp->taxcode = 'NO' OR ls_temp->taxcode = 'NX'.
            lw_tax = 0.
          ELSE.
            lw_tax  =  ls_taxcode->value.
          ENDIF.
          IF  ls_temp->transactioncurrency = 'VND'.
            ls_data-amountbeforetax = ls_data-amountbeforetax * 100.
            ls_data-taxamount      = ls_data-amountbeforetax * ( lw_tax / 100 ) .
            ls_data-amountaftertax = ls_data-amountbeforetax + ls_data-taxamount.

          ELSEIF ls_temp->transactioncurrency = 'USD'.
            ls_data-taxamount      = ls_data-amountbeforetax * ( lw_tax / 100 ) .
            ls_data-amountaftertax = ls_data-amountbeforetax + ls_data-taxamount.
          ENDIF.
        ENDIF.

        ls_data-netpriceafterdiscount = ls_data-amountbeforetax / ls_data-einvoicequanity.
*        ls_data-taxamount      = ls_data-amountbeforetax * ls_data-taxrate / 100.
*        ls_data-amountaftertax = ls_data-amountbeforetax + ls_data-taxamount.
        ls_data-goodtypeineinvoice = zeinv_if_constants=>line_good_service_78.
        "lấy description cho issum
        READ  TABLE gt_goodtype WITH KEY goodtype = ls_data-goodtypeineinvoice REFERENCE INTO DATA(ls_goodtype).
        IF sy-subrc = 0.
          ls_data-goodtypeineinvoicetext = ls_goodtype->goodtypetext.
        ENDIF.

        APPEND ls_data TO gt_data.

      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD get_published_item.

    DATA:
      lv_uuid TYPE zeinv_fkey,
      ls_data LIKE LINE OF gt_data.
    lv_uuid = |{ p_sourcetype }@{ p_sothamkhao }|.

    SELECT
        zeinv_tb_hd~*,
        zeinv_tb_hd_i~*
    FROM zeinv_tb_hd
    INNER JOIN zeinv_tb_hd_i ON zeinv_tb_hd_i~uuid = zeinv_tb_hd~uuid
    WHERE zeinv_tb_hd_i~uuid = @lv_uuid
    INTO CORRESPONDING FIELDS OF TABLE @gt_data.
*    loop at lt_log reference into data(ls_log).
*      clear ls_data.
*      ls_data = corresponding #( ls_log->zeinv_tb_hd_i ).
*      ls_data-billingdocument = ls_log->zeinv_tb_hd-billingdocument.
*      ls_data-sothamkhao =  p_sothamkhao.
*      append ls_data to gt_data.
*    endloop.

  ENDMETHOD.


  METHOD if_rap_query_provider~select.
    IF io_request->is_data_requested( ).

      DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
      DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
      DATA(lv_max_rows) = COND #( WHEN lv_top = if_rap_query_paging=>page_size_unlimited THEN 0
                                  ELSE lv_top ).
      DATA(lt_parameter)     = io_request->get_parameters( ).
      DATA(lt_fields)        = io_request->get_requested_elements( ).
      DATA(lt_sort)          = io_request->get_sort_elements( ).
      DATA(lt_aggregation) = io_request->get_aggregation(  ).
      DATA(lt_aggregation_element) = io_request->get_aggregation( )->get_aggregated_elements( ).
      DATA(lt_aggregation_group) = io_request->get_aggregation( )->get_grouped_elements( ).

*--->Filter
      TRY.
          DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
        CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
      ENDTRY.

      LOOP AT lt_filter_cond REFERENCE INTO DATA(ls_filter_cond).
        CASE ls_filter_cond->name.
          WHEN 'COMPANYCODE'.
            gr_companycode = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'SOURCETYPE'.
            READ TABLE ls_filter_cond->range[] INDEX 1 INTO DATA(ls_range).
            IF sy-subrc = 0.
              p_sourcetype = ls_range-low.
            ENDIF.
          WHEN 'SOTHAMKHAO'.
            READ TABLE ls_filter_cond->range[] INDEX 1 INTO ls_range.
            IF sy-subrc = 0.
              p_sothamkhao = ls_range-low.
            ENDIF.
          WHEN 'ACCOUNTINGDOCUMENT'.
            DELETE ls_filter_cond->range[] WHERE low IS INITIAL.
            gr_belnr = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'FISCALYEAR'.
            DELETE ls_filter_cond->range[] WHERE low IS INITIAL OR low = '0000'.
            gr_gjahr = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'BILLINGDOCUMENT'.
            gr_vbeln = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'BILLINGDOCUMENTITEM'.
            gr_posnr = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'BILLINGALTUNIT'.
            READ TABLE ls_filter_cond->range[] INDEX 1 INTO ls_range.
            IF sy-subrc = 0.
              p_billingaltunit = ls_range-low.
            ENDIF.
          WHEN 'ITEMFOREINVOICE'.
            READ TABLE ls_filter_cond->range[] INDEX 1 INTO ls_range.
            IF sy-subrc = 0.
              p_itemforeinvoice = ls_range-low.
            ENDIF.
          WHEN 'ALLBILLINGDETAIL'.
            READ TABLE ls_filter_cond->range[] INDEX 1 INTO ls_range.
            IF sy-subrc = 0.
              p_allbillingdetail = ls_range-low.
            ENDIF.
          WHEN 'BILLINGGENERAL'.
            READ TABLE ls_filter_cond->range[] INDEX 1 INTO ls_range.
            IF sy-subrc = 0.
              p_billinggeneral = ls_range-low.
            ENDIF.
          WHEN 'LOAIHOADON'.
            READ TABLE ls_filter_cond->range[] INDEX 1 INTO ls_range.
            IF sy-subrc = 0.
              CASE ls_range-low.
                WHEN 'NORM'.
                  p_normal = abap_true.
                WHEN 'REP'.
                  p_replace = abap_true.
                WHEN 'ADJ'.
                  p_adjust = abap_true.
                WHEN 'CANC'.
                  p_cancel = abap_true.
              ENDCASE.
              p_loaihoadon = ls_range-low.
            ENDIF.
          WHEN 'DISPNSX'.
            p_dispnsx = ls_filter_cond->range[ 1 ]-low.

          WHEN 'DISPVALUEDV'.
            p_dispvaluedv = ls_filter_cond->range[ 1 ]-low.

          WHEN 'NUMBERFORMATTYPE'.
            p_numformattype = ls_filter_cond->range[ 1 ]-low.
          WHEN 'LOAINGHIEPVUDIEUCHINH'.
            p_loainvdc = ls_filter_cond->range[ 1 ]-low.
          WHEN 'FORMATNUMBER'.
            p_formatnumber = ls_filter_cond->range[ 1 ]-low.
        ENDCASE.
      ENDLOOP.

      SELECT
          goodtype,
          goodtypetext
      FROM zeinv_i_goodtype
      INTO CORRESPONDING FIELDS OF TABLE @gt_goodtype.

      IF p_cancel = abap_true.
        get_published_item(  ).
      ELSE.
        CASE p_sourcetype.
          WHEN 'BILL'.
            get_billing_item(  ).
          WHEN 'FI'.
            get_fi_item(  ).
          WHEN 'PO'.
            get_po_item(  ).
        ENDCASE.
      ENDIF.

*----->paging way to return huge amount of data
      lv_max_rows = lv_skip + lv_top.
      IF lv_skip > 0.
        lv_skip = lv_skip + 1.
      ENDIF.

      IF lv_max_rows = -1 .
        lv_max_rows = 1.
      ENDIF.
      DATA: lt_responseout LIKE gt_data.
      LOOP AT gt_data REFERENCE INTO DATA(ls_data) FROM lv_skip TO lv_max_rows.
        "Nếu Material có Material type = M98 – Dịch vụ thì để trống field này
        IF ls_data->producttype = 'M98'.
          CLEAR ls_data->product.
        ENDIF.

        APPEND ls_data->* TO lt_responseout.

      ENDLOOP.

      io_response->set_total_number_of_records( lines( gt_data ) ).
      io_response->set_data( lt_responseout ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
