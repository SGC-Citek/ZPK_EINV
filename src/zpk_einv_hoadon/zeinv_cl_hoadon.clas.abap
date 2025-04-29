*----------------------------------------------------------------------*
* Citek JSC.
* (C) Copyright Citek JSC.
* All Rights Reserved
*----------------------------------------------------------------------*
* Application : E-Invoice
* Creation Date: Jan 01, 2024
* Created by: NganNM
*----------------------------------------------------------------------*
CLASS zeinv_cl_hoadon DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider .
    DATA:
      "general
      p_sourcetype       TYPE zeinv_sourcetype,
      gr_companycode     TYPE RANGE OF bukrs, "bill-fi-po
      gr_fiscalyear      TYPE RANGE OF zeinv_i_hoadon-fiscalyear, "bill-fi-po
      gr_belnr           TYPE RANGE OF belnr_d, "bill-fi-po
      gr_bldat           TYPE RANGE OF dats, "bill-fi-po
      gr_budat           TYPE RANGE OF dats, "bill-fi-po
      gr_usnam           TYPE RANGE OF sy-uname, "bill-fi-po

      "billing
      gr_vbeln           TYPE RANGE OF vbeln_vl,
      gr_fkart           TYPE RANGE OF zde_fkart,
      gr_kunnr           TYPE RANGE OF lifnr,
      gr_vkbur           TYPE RANGE OF i_salesoffice-salesoffice,
      gr_vkgrp           TYPE RANGE OF i_salesgroup-salesgroup,

      p_billingaltunit   TYPE abap_boolean,
      p_billinggeneral   TYPE abap_boolean,
      p_allbillingdetail TYPE abap_boolean,

      p_dispnsx          TYPE abap_boolean,
      p_dispvaluedv      TYPE c LENGTH 1,
      p_numformattype    TYPE abap_boolean,

      p_normal           TYPE abap_boolean,
      p_replace          TYPE abap_boolean,
      p_adjust           TYPE abap_boolean,
      p_cancel           TYPE abap_boolean,
      p_loaihoadon       TYPE string,
      p_loainvdc         TYPE zeinv_i_hoadon-loainghiepvudieuchinh,

      p_pattern          TYPE zeinv_pattern,
      p_serial           TYPE zeinv_serial,

      "po
      gr_ebeln           TYPE RANGE OF ebeln,
      gr_aedat           TYPE RANGE OF dats,
      gr_lifnr           TYPE RANGE OF lifnr,
      gr_reference       TYPE RANGE OF zde_reference,
      gr_uuidstatus      TYPE RANGE OF zeinv_status,

      p_headoffice       TYPE abap_boolean,
      p_billto           TYPE abap_boolean,
      p_formatnumber     TYPE zeinv_de_numberformat
      .

    DATA:
      gt_data   TYPE TABLE OF zeinv_i_hoadon,
      gt_config TYPE TABLE OF zeinv_i_config.
  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS: gc_comm_scenario TYPE if_com_management=>ty_cscn_id VALUE 'ZCORE_CS_SAP',
               gc_service_id    TYPE if_com_management=>ty_cscn_outb_srv_id VALUE 'Z_API_SAP_REST'.
    METHODS get_billing.
    METHODS get_po.
    METHODS get_fi.
    METHODS :
      get_data_view
        RETURNING
          VALUE(r_result) LIKE gt_data,
      get_data_drafed
        RETURNING
          VALUE(r_result) LIKE gt_data.
*    methods: get_tabname importing fieldname      type string
*                         returning value(tabname) type string.

ENDCLASS.



CLASS zeinv_cl_hoadon IMPLEMENTATION.


  METHOD get_billing.
    DATA: tzone   TYPE timezone VALUE 'UTC+7',
          lw_time TYPE cl_abap_context_info=>ty_system_time VALUE '000000'.

    DATA:
      lv_query          TYPE string,
      lv_query_nghiepvu TYPE string,
      lv_query_thaythe  TYPE string,
      lv_query_2        TYPE string,
      lr_replacebill    TYPE RANGE OF vbeln_vl,
      lr_adjustbill     TYPE RANGE OF vbeln_vl.
    CASE p_loaihoadon.
      WHEN zeinv_if_constants=>move.

        SELECT DISTINCT
                'BILL' AS sourcetype,
                @p_billingaltunit   AS billingaltunit,
                @p_billinggeneral   AS billinggeneral ,
                @p_allbillingdetail AS allbillingdetail,
                @p_headoffice       AS xuathoadonheadoffice,
                @p_loainvdc         AS loainghiepvudieuchinh,
                @p_formatnumber     AS formatnumber,
                vbrk~billingdocument,
                vbrp~plant,
                vbrp~\_plant-plantname,
*                    vbrp~referencesddocument,
                vbrk~companycode,
                vbrk~billingdocumenttype,
                vbrk~billingdocumentdate  AS ngayhoadon,
                vbrk~billingdocumentdate  AS invoicedate,
                dats_tims_to_tstmp(
                     date     = vbrk~billingdocumentdate ,
                     time     = @lw_time,
                     tzone    = @tzone,
                     client   = @sy-mandt )
                       AS dat_tim,
                billtyp~billnghiepvu,
                billtyp~note AS ghichu,
                billtyp~nofidoc,
                nghiepvu~billnghiepvu_text,
                vbrk~documentreferenceid,
                vbrk~accountingexchangerate,
                vbrk~transactioncurrency,
                vbrk~accountingdocument,
                vbrk~fiscalyear,
                vbrk~paymentmethod,
                zeinv_tb_hd~uuid,
                zeinv_tb_hd~uuidstatus,
                zeinv_status~uuidstatustext AS uuidstatusname,
                zeinv_tb_hd~einvoiceno,
                zeinv_tb_hd~einvoiceno_long,
                i_paymentmethod~paymentmethodname,
                i_journalentry~postingdate,
                _billtoparty~customer,
                _billtoparty~companyname AS buyercompany,
                _billtoparty~customerbusinesspartnergroup AS buyerbpgroup,
                _shiptoparty~fulladdress AS shippingaddress,
                zeinv_i_billingsum~subtotal1amount AS amountbeforetax,
                zeinv_i_billingsum~taxamount,
                ( zeinv_i_billingsum~subtotal1amount + zeinv_i_billingsum~taxamount ) AS amountaftertax,
                companycode~vatregistration,
*                    CASE WHEN adrc~addresseename2 <> ' ' OR adrc~addresseename3 <> ' ' OR adrc~addresseename4 <> ' '
*                         THEN concat_with_space( concat_with_space( adrc~addresseename2, adrc~addresseename3,1 ),adrc~addresseename4 ,1 )
*                         ELSE adrc~addresseename1                                                       END AS tennguoiban,

*                     concat_with_space( concat_with_space( concat_with_space(
*                                        concat_with_space( adrc~streetname, adrc~streetprefixname1,1 ),
*                                                           adrc~streetprefixname2 ,1 ), adrc~streetsuffixname1, 1 ),adrc~streetsuffixname2,1 )
*                      AS diachinban,

               "Ten Don Vi
                CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
*                                                            THEN bsec~businesspartnername1
                                                        THEN 'Người mua không cung cấp mã số thuế'
                                                        ELSE _billtoparty~fullname
                                                   END
                                              ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
                                                        THEN 'Người mua không cung cấp mã số thuế'
                                                         ELSE _soldtoparty~fullname
                                                    END
                                              END AS tendonvi,
                "Dia Chi

                CASE @p_headoffice WHEN  'X' THEN  _billtoparty~fulladdress
                                             ELSE _soldtoparty~fulladdress  END AS buyeraddress,
                CASE @p_headoffice WHEN  'X' THEN  _billtoparty~emailaddress
                                             ELSE _soldtoparty~emailaddress  END AS buyeremail,
                "MÃ SỐ THUẾ
                CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
                                                        THEN vbrk~vatregistration
                                                        ELSE _billtoparty~customervat
                                                   END
                                              ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
                                                        THEN vbrk~vatregistration
                                                        ELSE _soldtoparty~customervat
                                                    END
                                              END AS buyervatnumber,
                 "Value
                    CASE tax~einvoicetax
                      WHEN @zeinv_if_constants=>gc_tax_rate_id-_0pc THEN 0
                      WHEN @zeinv_if_constants=>gc_tax_rate_id-_5pc THEN 5
                      WHEN @zeinv_if_constants=>gc_tax_rate_id-_8pc THEN 8
                      WHEN @zeinv_if_constants=>gc_tax_rate_id-_10pc THEN 10
                    END AS vatrate,
              "Ngày đăng ký phát hành
              zeinv_tb_hd~ngayphathanhhoadon,
              vbrk~yy1_billingttoldhd_bdh               AS billingmove,
              zeinv_tb_hd~check_thaythe_dieuchinh,
              zeinv_tb_hd~loaihoadon                    AS loaihoadon

            FROM i_billingdocument AS vbrk
            INNER JOIN i_billingdocumentitem AS vbrp
                                             ON vbrp~billingdocument = vbrk~billingdocument
            INNER JOIN zeinv_i_billingsum ON zeinv_i_billingsum~billingdocument = vbrk~billingdocument

            INNER JOIN zeinv_tb_billtyp AS billtyp
                                        ON billtyp~billingtype = vbrk~billingdocumenttype
                                       AND billtyp~orderreason = vbrp~sddocumentreason
                                       AND billtyp~mvgr1       = vbrp~additionalmaterialgroup1
            INNER JOIN zeinv_i_bill_nghiepvu AS nghiepvu
                                             ON nghiepvu~billnghiepvu = billtyp~billnghiepvu
            LEFT JOIN i_journalentry ON i_journalentry~accountingdocument = vbrk~accountingdocument
                                    AND i_journalentry~fiscalyear = vbrk~fiscalyear
                                    AND i_journalentry~companycode = vbrk~companycode
            LEFT JOIN i_companycode  AS companycode ON companycode~companycode = vbrk~companycode
            LEFT JOIN zi_organizationaddress AS adrc ON companycode~addressid = adrc~addressid
            LEFT JOIN i_onetimeaccountcustomer AS bsec
                                               ON bsec~accountingdocument = vbrk~accountingdocument
            LEFT JOIN zcore_i_profile_pf AS _billtoparty ON _billtoparty~sddocument      = vbrk~billingdocument
                                                        AND _billtoparty~partnerfunction = 'RE'
            LEFT JOIN zcore_i_profile_pf AS _soldtoparty ON _soldtoparty~sddocument      = vbrk~billingdocument
                                                        AND _soldtoparty~partnerfunction = 'AG'
            LEFT JOIN zcore_i_profile_pf AS _shiptoparty ON _shiptoparty~sddocument = vbrk~billingdocument
                                                        AND _shiptoparty~partnerfunction = 'WE'

            LEFT JOIN i_customercompany AS knb1 ON knb1~customer    = _billtoparty~customer
                                               AND knb1~companycode = vbrk~companycode
            LEFT JOIN zcore_i_profile_customer AS kna1 ON kna1~customer = knb1~customerheadoffice
            LEFT JOIN zeinv_i_config ON zeinv_i_config~type        =  '1'
                                    AND zeinv_i_config~companycode = vbrk~companycode
                                    AND zeinv_i_config~sourcetype  = 'BILL'
                                    AND zeinv_i_config~validfrom   <= @sy-datum
                                    AND zeinv_i_config~validto     >= @sy-datum
                                    AND zeinv_i_config~plant       = vbrp~plant

            LEFT JOIN zeinv_tb_hd ON zeinv_tb_hd~billingdocument = vbrk~billingdocument
            LEFT JOIN zeinv_i_status AS zeinv_status ON zeinv_status~uuidstatus = zeinv_tb_hd~uuidstatus
            LEFT JOIN zeinv_tb_taxcode AS tax ON tax~taxcode = vbrp~taxcode
            LEFT JOIN i_paymentmethod ON i_paymentmethod~paymentmethod = vbrk~paymentmethod
                                     AND i_paymentmethod~country       = 'VN'
            WHERE vbrk~billingdocumenttype   IN @gr_fkart AND
                  vbrk~companycode           IN @gr_companycode AND
                  vbrk~billingdocumenttype   IN @gr_fkart AND
                  vbrk~documentreferenceid   IN @gr_reference AND
                  vbrk~billingdocument       IN @gr_vbeln AND
                  _billtoparty~customer      IN @gr_kunnr AND
                  vbrk~billingdocumentdate   IN @gr_bldat AND
                  vbrk~billingdocumentdate   IN @gr_budat AND
                  vbrk~creationdate          IN @gr_aedat AND
                  vbrk~createdbyuser         IN @gr_usnam AND
                  vbrk~accountingdocument    IN @gr_belnr AND
                  vbrp~salesoffice           IN @gr_vkbur AND
                  vbrp~salesgroup            IN @gr_vkgrp AND
                  zeinv_tb_hd~uuidstatus     IN @gr_uuidstatus AND
                  ( zeinv_tb_hd~is_move        IS INITIAL OR
                    zeinv_tb_hd~is_move        IS NULL )       AND
                  vbrk~yy1_billingttoldhd_bdh IS NOT INITIAL
                  AND ( zeinv_tb_hd~uuidstatus EQ @zeinv_if_constants=>status_init OR zeinv_tb_hd~uuidstatus IS NULL )
         INTO TABLE @DATA(lt_data).

        lv_query = `vbrk~yy1_billingttoldhd_bdh IS NOT INITIAL AND ( zeinv_tb_hd~uuidstatus EQ @zeinv_if_constants=>status_init OR zeinv_tb_hd~uuidstatus IS NULL )`.

      WHEN zeinv_if_constants=>canc.
        SELECT DISTINCT
            'BILL' AS sourcetype,
            @p_billingaltunit   AS billingaltunit,
            @p_billinggeneral   AS billinggeneral ,
            @p_allbillingdetail AS allbillingdetail,
            @p_headoffice       AS xuathoadonheadoffice,
            @p_loainvdc         AS loainghiepvudieuchinh,
            @p_formatnumber     AS formatnumber,
            vbrk~billingdocument,
            vbrp~plant,
            vbrp~\_plant-plantname,
*                    vbrp~referencesddocument,
            vbrk~companycode,
            vbrk~billingdocumenttype,
            vbrk~billingdocumentdate  AS ngayhoadon,
            vbrk~billingdocumentdate  AS invoicedate,
            dats_tims_to_tstmp(
             date     = vbrk~billingdocumentdate ,
             time     = @lw_time,
             tzone    = @tzone,
             client   = @sy-mandt )
               AS dat_tim,
            billtyp~billnghiepvu,
            billtyp~note AS ghichu,
            billtyp~nofidoc,
            nghiepvu~billnghiepvu_text,
            vbrk~documentreferenceid,
            vbrk~accountingexchangerate,
            vbrk~transactioncurrency,
            vbrk~accountingdocument,
            vbrk~fiscalyear,
            vbrk~paymentmethod,
            zeinv_tb_hd~uuid,
            zeinv_tb_hd~uuidstatus,
            zeinv_status~uuidstatustext AS uuidstatusname,
            zeinv_tb_hd~einvoiceno,
            zeinv_tb_hd~einvoiceno_long,
            i_paymentmethod~paymentmethodname,
            i_journalentry~postingdate,
            _billtoparty~customer,
            _billtoparty~companyname AS buyercompany,
            _billtoparty~customerbusinesspartnergroup AS buyerbpgroup,
            _shiptoparty~fulladdress AS shippingaddress,
            zeinv_i_billingsum~subtotal1amount AS amountbeforetax,
            zeinv_i_billingsum~taxamount,
            ( zeinv_i_billingsum~subtotal1amount + zeinv_i_billingsum~taxamount ) AS amountaftertax,
            companycode~vatregistration,
*                    CASE WHEN adrc~addresseename2 <> ' ' OR adrc~addresseename3 <> ' ' OR adrc~addresseename4 <> ' '
*                         THEN concat_with_space( concat_with_space( adrc~addresseename2, adrc~addresseename3,1 ),adrc~addresseename4 ,1 )
*                         ELSE adrc~addresseename1                                                       END AS tennguoiban,

*                     concat_with_space( concat_with_space( concat_with_space(
*                                        concat_with_space( adrc~streetname, adrc~streetprefixname1,1 ),
*                                                           adrc~streetprefixname2 ,1 ), adrc~streetsuffixname1, 1 ),adrc~streetsuffixname2,1 )
*                      AS diachinban,

            "Ten Don Vi
            CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
*                                                            THEN bsec~businesspartnername1
                                                THEN 'Người mua không cung cấp mã số thuế'
                                                ELSE _billtoparty~fullname
                                           END
                                      ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
                                                THEN 'Người mua không cung cấp mã số thuế'
                                                 ELSE _soldtoparty~fullname
                                            END
                                      END AS tendonvi,
            "Dia Chi

            CASE @p_headoffice WHEN  'X' THEN  _billtoparty~fulladdress
                                     ELSE _soldtoparty~fulladdress  END AS buyeraddress,
            CASE @p_headoffice WHEN  'X' THEN  _billtoparty~emailaddress
                                     ELSE _soldtoparty~emailaddress  END AS buyeremail,
            "MÃ SỐ THUẾ
            CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
                                                THEN vbrk~vatregistration
                                                ELSE _billtoparty~customervat
                                           END
                                      ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
                                                THEN vbrk~vatregistration
                                                ELSE _soldtoparty~customervat
                                            END
                                      END AS buyervatnumber,
            "Value
            CASE tax~einvoicetax
              WHEN @zeinv_if_constants=>gc_tax_rate_id-_0pc THEN 0
              WHEN @zeinv_if_constants=>gc_tax_rate_id-_5pc THEN 5
              WHEN @zeinv_if_constants=>gc_tax_rate_id-_8pc THEN 8
              WHEN @zeinv_if_constants=>gc_tax_rate_id-_10pc THEN 10
            END AS vatrate,
            "Ngày đăng ký phát hành
            zeinv_tb_hd~ngayphathanhhoadon,
            vbrk~yy1_billingttoldhd_bdh               AS billingmove,
            zeinv_tb_hd~check_thaythe_dieuchinh,
            zeinv_tb_hd~loaihoadon                    AS loaihoadon

            FROM i_billingdocument AS vbrk
            INNER JOIN i_billingdocumentitem AS vbrp
                                     ON vbrp~billingdocument = vbrk~billingdocument
            INNER JOIN zeinv_i_billingsum ON zeinv_i_billingsum~billingdocument = vbrk~billingdocument

            INNER JOIN zeinv_tb_billtyp AS billtyp
                                ON billtyp~billingtype = vbrk~billingdocumenttype
                               AND billtyp~orderreason = vbrp~sddocumentreason
                               AND billtyp~mvgr1       = vbrp~additionalmaterialgroup1
            INNER JOIN zeinv_i_bill_nghiepvu AS nghiepvu
                                     ON nghiepvu~billnghiepvu = billtyp~billnghiepvu
            LEFT JOIN i_journalentry ON i_journalentry~accountingdocument = vbrk~accountingdocument
                            AND i_journalentry~fiscalyear = vbrk~fiscalyear
                            AND i_journalentry~companycode = vbrk~companycode
            LEFT JOIN i_companycode  AS companycode ON companycode~companycode = vbrk~companycode
            LEFT JOIN zi_organizationaddress AS adrc ON companycode~addressid = adrc~addressid
            LEFT JOIN i_onetimeaccountcustomer AS bsec
                                       ON bsec~accountingdocument = vbrk~accountingdocument
            LEFT JOIN zcore_i_profile_pf AS _billtoparty ON _billtoparty~sddocument      = vbrk~billingdocument
                                                AND _billtoparty~partnerfunction = 'RE'
            LEFT JOIN zcore_i_profile_pf AS _soldtoparty ON _soldtoparty~sddocument      = vbrk~billingdocument
                                                AND _soldtoparty~partnerfunction = 'AG'
            LEFT JOIN zcore_i_profile_pf AS _shiptoparty ON _shiptoparty~sddocument = vbrk~billingdocument
                                                AND _shiptoparty~partnerfunction = 'WE'

            LEFT JOIN i_customercompany AS knb1 ON knb1~customer    = _billtoparty~customer
                                       AND knb1~companycode = vbrk~companycode
            LEFT JOIN zcore_i_profile_customer AS kna1 ON kna1~customer = knb1~customerheadoffice
            LEFT JOIN zeinv_i_config ON zeinv_i_config~type        =  '1'
                            AND zeinv_i_config~companycode = vbrk~companycode
                            AND zeinv_i_config~sourcetype  = 'BILL'
                            AND zeinv_i_config~validfrom   <= @sy-datum
                            AND zeinv_i_config~validto     >= @sy-datum
                            AND zeinv_i_config~plant       = vbrp~plant

            LEFT JOIN zeinv_tb_hd ON zeinv_tb_hd~billingdocument = vbrk~billingdocument
            LEFT JOIN zeinv_i_status AS zeinv_status ON zeinv_status~uuidstatus = zeinv_tb_hd~uuidstatus
            LEFT JOIN zeinv_tb_taxcode AS tax ON tax~taxcode = vbrp~taxcode
            LEFT JOIN i_paymentmethod ON i_paymentmethod~paymentmethod = vbrk~paymentmethod
                             AND i_paymentmethod~country       = 'VN'
            WHERE vbrk~billingdocumenttype   IN @gr_fkart AND
            vbrk~companycode           IN @gr_companycode AND
            vbrk~billingdocumenttype   IN @gr_fkart AND
            vbrk~documentreferenceid   IN @gr_reference AND
            vbrk~billingdocument       IN @gr_vbeln AND
            _billtoparty~customer      IN @gr_kunnr AND
            vbrk~billingdocumentdate   IN @gr_bldat AND
            vbrk~billingdocumentdate   IN @gr_budat AND
            vbrk~creationdate          IN @gr_aedat AND
            vbrk~createdbyuser         IN @gr_usnam AND
            vbrk~accountingdocument    IN @gr_belnr AND
            vbrp~salesoffice           IN @gr_vkbur AND
            vbrp~salesgroup            IN @gr_vkgrp AND
           ( zeinv_tb_hd~is_move        IS INITIAL OR
             zeinv_tb_hd~is_move        IS NULL )       AND
            ( zeinv_tb_hd~uuidstatus     IN @gr_uuidstatus AND
              zeinv_tb_hd~uuidstatus = @zeinv_if_constants=>status_published AND
             vbrk~billingdocumentiscancelled = @abap_true AND
             vbrk~reversalreason <> 'ZZ' AND
             vbrk~yy1_hdtt_bdh IS INITIAL ) AND
             NOT EXISTS ( SELECT hddt_move~billingdocument FROM i_billingdocument AS hddt_move WHERE ltrim( hddt_move~yy1_billingttoldhd_bdh,'0' ) = ltrim( vbrk~billingdocument,'0' ) )
        INTO TABLE @lt_data.

        lv_query  =  `zeinv_tb_hd~uuidstatus = @zeinv_if_constants=>status_published and vbrk~billingdocumentiscancelled = @abap_true and vbrk~reversalreason <> 'ZZ' and vbrk~yy1_hdtt_bdh IS INITIAL`.
        lv_query_2 = `NOT EXISTS ( SELECT hddt_move~billingdocument FROM i_billingdocument AS hddt_move WHERE ltrim( hddt_move~yy1_billingttoldhd_bdh,'0' ) = ltrim( vbrk~billingdocument,'0' ) )` .
      WHEN zeinv_if_constants=>view.
        SELECT DISTINCT
            'BILL' AS sourcetype,
            @p_billingaltunit   AS billingaltunit,
            @p_billinggeneral   AS billinggeneral ,
            @p_allbillingdetail AS allbillingdetail,
            @p_headoffice       AS xuathoadonheadoffice,
            @p_loainvdc         AS loainghiepvudieuchinh,
            @p_formatnumber     AS formatnumber,
            vbrk~billingdocument,
            vbrp~plant,
            vbrp~\_plant-plantname,
*                    vbrp~referencesddocument,
            vbrk~companycode,
            vbrk~billingdocumenttype,
            vbrk~billingdocumentdate  AS ngayhoadon,
            vbrk~billingdocumentdate  AS invoicedate,
            dats_tims_to_tstmp(
            date     = vbrk~billingdocumentdate ,
            time     = @lw_time,
            tzone    = @tzone,
            client   = @sy-mandt )
            AS dat_tim,
            billtyp~billnghiepvu,
            billtyp~note AS ghichu,
            billtyp~nofidoc,
            nghiepvu~billnghiepvu_text,
            vbrk~documentreferenceid,
            vbrk~accountingexchangerate,
            vbrk~transactioncurrency,
            vbrk~accountingdocument,
            vbrk~fiscalyear,
            vbrk~paymentmethod,
            zeinv_tb_hd~uuid,
            zeinv_tb_hd~uuidstatus,
            zeinv_status~uuidstatustext AS uuidstatusname,
            zeinv_tb_hd~einvoiceno,
            zeinv_tb_hd~einvoiceno_long,
            i_paymentmethod~paymentmethodname,
            i_journalentry~postingdate,
            _billtoparty~customer,
            _billtoparty~companyname AS buyercompany,
            _billtoparty~customerbusinesspartnergroup AS buyerbpgroup,
            _shiptoparty~fulladdress AS shippingaddress,
            zeinv_i_billingsum~subtotal1amount AS amountbeforetax,
            zeinv_i_billingsum~taxamount,
            ( zeinv_i_billingsum~subtotal1amount + zeinv_i_billingsum~taxamount ) AS amountaftertax,
            companycode~vatregistration,
*                    CASE WHEN adrc~addresseename2 <> ' ' OR adrc~addresseename3 <> ' ' OR adrc~addresseename4 <> ' '
*                         THEN concat_with_space( concat_with_space( adrc~addresseename2, adrc~addresseename3,1 ),adrc~addresseename4 ,1 )
*                         ELSE adrc~addresseename1                                                       END AS tennguoiban,

*                     concat_with_space( concat_with_space( concat_with_space(
*                                        concat_with_space( adrc~streetname, adrc~streetprefixname1,1 ),
*                                                           adrc~streetprefixname2 ,1 ), adrc~streetsuffixname1, 1 ),adrc~streetsuffixname2,1 )
*                      AS diachinban,

            "Ten Don Vi
            CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
*                                                            THEN bsec~businesspartnername1
                                          THEN 'Người mua không cung cấp mã số thuế'
                                          ELSE _billtoparty~fullname
                                     END
                                ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
                                          THEN 'Người mua không cung cấp mã số thuế'
                                           ELSE _soldtoparty~fullname
                                      END
                                END AS tendonvi,
            "Dia Chi

            CASE @p_headoffice WHEN  'X' THEN  _billtoparty~fulladdress
                               ELSE _soldtoparty~fulladdress  END AS buyeraddress,
            CASE @p_headoffice WHEN  'X' THEN  _billtoparty~emailaddress
                               ELSE _soldtoparty~emailaddress  END AS buyeremail,
            "MÃ SỐ THUẾ
            CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
                                          THEN vbrk~vatregistration
                                          ELSE _billtoparty~customervat
                                     END
                                ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
                                          THEN vbrk~vatregistration
                                          ELSE _soldtoparty~customervat
                                      END
                                END AS buyervatnumber,
            "Value
            CASE tax~einvoicetax
            WHEN @zeinv_if_constants=>gc_tax_rate_id-_0pc THEN 0
            WHEN @zeinv_if_constants=>gc_tax_rate_id-_5pc THEN 5
            WHEN @zeinv_if_constants=>gc_tax_rate_id-_8pc THEN 8
            WHEN @zeinv_if_constants=>gc_tax_rate_id-_10pc THEN 10
            END AS vatrate,
            "Ngày đăng ký phát hành
            zeinv_tb_hd~ngayphathanhhoadon,
            vbrk~yy1_billingttoldhd_bdh               AS billingmove,
            zeinv_tb_hd~check_thaythe_dieuchinh,
            zeinv_tb_hd~loaihoadon                    AS loaihoadon

            FROM i_billingdocument AS vbrk
            INNER JOIN i_billingdocumentitem AS vbrp
                               ON vbrp~billingdocument = vbrk~billingdocument
            INNER JOIN zeinv_i_billingsum ON zeinv_i_billingsum~billingdocument = vbrk~billingdocument

            INNER JOIN zeinv_tb_billtyp AS billtyp
                          ON billtyp~billingtype = vbrk~billingdocumenttype
                         AND billtyp~orderreason = vbrp~sddocumentreason
                         AND billtyp~mvgr1       = vbrp~additionalmaterialgroup1
            INNER JOIN zeinv_i_bill_nghiepvu AS nghiepvu
                               ON nghiepvu~billnghiepvu = billtyp~billnghiepvu
            LEFT JOIN i_journalentry ON i_journalentry~accountingdocument = vbrk~accountingdocument
                      AND i_journalentry~fiscalyear = vbrk~fiscalyear
                      AND i_journalentry~companycode = vbrk~companycode
            LEFT JOIN i_companycode  AS companycode ON companycode~companycode = vbrk~companycode
            LEFT JOIN zi_organizationaddress AS adrc ON companycode~addressid = adrc~addressid
            LEFT JOIN i_onetimeaccountcustomer AS bsec
                                 ON bsec~accountingdocument = vbrk~accountingdocument
            LEFT JOIN zcore_i_profile_pf AS _billtoparty ON _billtoparty~sddocument      = vbrk~billingdocument
                                          AND _billtoparty~partnerfunction = 'RE'
            LEFT JOIN zcore_i_profile_pf AS _soldtoparty ON _soldtoparty~sddocument      = vbrk~billingdocument
                                          AND _soldtoparty~partnerfunction = 'AG'
            LEFT JOIN zcore_i_profile_pf AS _shiptoparty ON _shiptoparty~sddocument = vbrk~billingdocument
                                          AND _shiptoparty~partnerfunction = 'WE'

            LEFT JOIN i_customercompany AS knb1 ON knb1~customer    = _billtoparty~customer
                                 AND knb1~companycode = vbrk~companycode
            LEFT JOIN zcore_i_profile_customer AS kna1 ON kna1~customer = knb1~customerheadoffice
            LEFT JOIN zeinv_i_config ON zeinv_i_config~type        =  '1'
                      AND zeinv_i_config~companycode = vbrk~companycode
                      AND zeinv_i_config~sourcetype  = 'BILL'
                      AND zeinv_i_config~validfrom   <= @sy-datum
                      AND zeinv_i_config~validto     >= @sy-datum
                      AND zeinv_i_config~plant       = vbrp~plant

            LEFT JOIN zeinv_tb_hd ON zeinv_tb_hd~billingdocument = vbrk~billingdocument
            LEFT JOIN zeinv_i_status AS zeinv_status ON zeinv_status~uuidstatus = zeinv_tb_hd~uuidstatus
            LEFT JOIN zeinv_tb_taxcode AS tax ON tax~taxcode = vbrp~taxcode
            LEFT JOIN i_paymentmethod ON i_paymentmethod~paymentmethod = vbrk~paymentmethod
                       AND i_paymentmethod~country       = 'VN'
            WHERE vbrk~billingdocumenttype   IN @gr_fkart AND
            vbrk~companycode           IN @gr_companycode AND
            vbrk~billingdocumenttype   IN @gr_fkart AND
            vbrk~documentreferenceid   IN @gr_reference AND
            vbrk~billingdocument       IN @gr_vbeln AND
            _billtoparty~customer      IN @gr_kunnr AND
            vbrk~billingdocumentdate   IN @gr_bldat AND
            vbrk~billingdocumentdate   IN @gr_budat AND
            vbrk~creationdate          IN @gr_aedat AND
            vbrk~createdbyuser         IN @gr_usnam AND
            vbrk~accountingdocument    IN @gr_belnr AND
            vbrp~salesoffice           IN @gr_vkbur AND
            vbrp~salesgroup            IN @gr_vkgrp AND
            zeinv_tb_hd~uuidstatus     IN @gr_uuidstatus AND
            ( zeinv_tb_hd~is_move        IS INITIAL OR
             zeinv_tb_hd~is_move        IS NULL )       AND
            ( zeinv_tb_hd~uuidstatus = @zeinv_if_constants=>status_published OR zeinv_tb_hd~uuidstatus = @zeinv_if_constants=>status_cancelled )
        INTO TABLE @lt_data.
        lv_query  =  `( zeinv_tb_hd~uuidstatus = @zeinv_if_constants=>status_published or zeinv_tb_hd~uuidstatus = @zeinv_if_constants=>status_cancelled )`.
      WHEN zeinv_if_constants=>norm.
        SELECT DISTINCT
                'BILL' AS sourcetype,
                @p_billingaltunit   AS billingaltunit,
                @p_billinggeneral   AS billinggeneral ,
                @p_allbillingdetail AS allbillingdetail,
                @p_headoffice       AS xuathoadonheadoffice,
                @p_loainvdc         AS loainghiepvudieuchinh,
                @p_formatnumber     AS formatnumber,
                vbrk~billingdocument,
                vbrp~plant,
                vbrp~\_plant-plantname,
*                        vbrp~referencesddocument,
                vbrk~companycode,
                vbrk~billingdocumenttype,
                vbrk~billingdocumentdate  AS ngayhoadon,
                vbrk~billingdocumentdate  AS invoicedate,
                dats_tims_to_tstmp(
                date     = vbrk~billingdocumentdate ,
                time     = @lw_time,
                tzone    = @tzone,
                client   = @sy-mandt )
                AS dat_tim,
                billtyp~billnghiepvu,
                billtyp~note AS ghichu,
                billtyp~nofidoc,
                nghiepvu~billnghiepvu_text,
                vbrk~documentreferenceid,
                vbrk~accountingexchangerate,
                vbrk~transactioncurrency,
                vbrk~accountingdocument,
                vbrk~fiscalyear,
                vbrk~paymentmethod,
                zeinv_tb_hd~uuid,
                zeinv_tb_hd~uuidstatus,
                zeinv_status~uuidstatustext AS uuidstatusname,
                zeinv_tb_hd~einvoiceno,
                zeinv_tb_hd~einvoiceno_long,
                i_paymentmethod~paymentmethodname,
                i_journalentry~postingdate,
                _billtoparty~customer,
                _billtoparty~companyname AS buyercompany,
                _billtoparty~customerbusinesspartnergroup AS buyerbpgroup,
                _shiptoparty~fulladdress AS shippingaddress,
                zeinv_i_billingsum~subtotal1amount AS amountbeforetax,
                zeinv_i_billingsum~taxamount,
                ( zeinv_i_billingsum~subtotal1amount + zeinv_i_billingsum~taxamount ) AS amountaftertax,
                companycode~vatregistration,
*                        CASE WHEN adrc~addresseename2 <> ' ' OR adrc~addresseename3 <> ' ' OR adrc~addresseename4 <> ' '
*                             THEN concat_with_space( concat_with_space( adrc~addresseename2, adrc~addresseename3,1 ),adrc~addresseename4 ,1 )
*                             ELSE adrc~addresseename1                                                       END AS tennguoiban,

*                         concat_with_space( concat_with_space( concat_with_space(
*                                            concat_with_space( adrc~streetname, adrc~streetprefixname1,1 ),
*                                                               adrc~streetprefixname2 ,1 ), adrc~streetsuffixname1, 1 ),adrc~streetsuffixname2,1 )
*                          AS diachinban,

                "Ten Don Vi
                CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
*                                                                THEN bsec~businesspartnername1
                                      THEN 'Người mua không cung cấp mã số thuế'
                                      ELSE _billtoparty~fullname
                                 END
                            ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
                                      THEN 'Người mua không cung cấp mã số thuế'
                                       ELSE _soldtoparty~fullname
                                  END
                            END AS tendonvi,
                "Dia Chi

                CASE @p_headoffice WHEN  'X' THEN  _billtoparty~fulladdress
                           ELSE _soldtoparty~fulladdress  END AS buyeraddress,
                CASE @p_headoffice WHEN  'X' THEN  _billtoparty~emailaddress
                           ELSE _soldtoparty~emailaddress  END AS buyeremail,
                "MÃ SỐ THUẾ
                CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
                                      THEN vbrk~vatregistration
                                      ELSE _billtoparty~customervat
                                 END
                            ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
                                      THEN vbrk~vatregistration
                                      ELSE _soldtoparty~customervat
                                  END
                            END AS buyervatnumber,
                "Value
                CASE tax~einvoicetax
                WHEN @zeinv_if_constants=>gc_tax_rate_id-_0pc THEN 0
                WHEN @zeinv_if_constants=>gc_tax_rate_id-_5pc THEN 5
                WHEN @zeinv_if_constants=>gc_tax_rate_id-_8pc THEN 8
                WHEN @zeinv_if_constants=>gc_tax_rate_id-_10pc THEN 10
                END AS vatrate,
                "Ngày đăng ký phát hành
                zeinv_tb_hd~ngayphathanhhoadon,
                vbrk~yy1_billingttoldhd_bdh               AS billingmove,
                zeinv_tb_hd~check_thaythe_dieuchinh,
                zeinv_tb_hd~loaihoadon                    AS loaihoadon

                FROM i_billingdocument AS vbrk
                INNER JOIN i_billingdocumentitem AS vbrp
                           ON vbrp~billingdocument = vbrk~billingdocument
                INNER JOIN zeinv_i_billingsum ON zeinv_i_billingsum~billingdocument = vbrk~billingdocument

                INNER JOIN zeinv_tb_billtyp AS billtyp
                      ON billtyp~billingtype = vbrk~billingdocumenttype
                     AND billtyp~orderreason = vbrp~sddocumentreason
                     AND billtyp~mvgr1       = vbrp~additionalmaterialgroup1
                INNER JOIN zeinv_i_bill_nghiepvu AS nghiepvu
                           ON nghiepvu~billnghiepvu = billtyp~billnghiepvu
                LEFT JOIN i_journalentry ON i_journalentry~accountingdocument = vbrk~accountingdocument
                  AND i_journalentry~fiscalyear = vbrk~fiscalyear
                  AND i_journalentry~companycode = vbrk~companycode
                LEFT JOIN i_companycode  AS companycode ON companycode~companycode = vbrk~companycode
                LEFT JOIN zi_organizationaddress AS adrc ON companycode~addressid = adrc~addressid
                LEFT JOIN i_onetimeaccountcustomer AS bsec
                             ON bsec~accountingdocument = vbrk~accountingdocument
                LEFT JOIN zcore_i_profile_pf AS _billtoparty ON _billtoparty~sddocument      = vbrk~billingdocument
                                      AND _billtoparty~partnerfunction = 'RE'
                LEFT JOIN zcore_i_profile_pf AS _soldtoparty ON _soldtoparty~sddocument      = vbrk~billingdocument
                                      AND _soldtoparty~partnerfunction = 'AG'
                LEFT JOIN zcore_i_profile_pf AS _shiptoparty ON _shiptoparty~sddocument = vbrk~billingdocument
                                      AND _shiptoparty~partnerfunction = 'WE'

                LEFT JOIN i_customercompany AS knb1 ON knb1~customer    = _billtoparty~customer
                             AND knb1~companycode = vbrk~companycode
                LEFT JOIN zcore_i_profile_customer AS kna1 ON kna1~customer = knb1~customerheadoffice
                LEFT JOIN zeinv_i_config ON zeinv_i_config~type        =  '1'
                  AND zeinv_i_config~companycode = vbrk~companycode
                  AND zeinv_i_config~sourcetype  = 'BILL'
                  AND zeinv_i_config~validfrom   <= @sy-datum
                  AND zeinv_i_config~validto     >= @sy-datum
                  AND zeinv_i_config~plant       = vbrp~plant

                LEFT JOIN zeinv_tb_hd ON zeinv_tb_hd~billingdocument = vbrk~billingdocument
                LEFT JOIN zeinv_i_status AS zeinv_status ON zeinv_status~uuidstatus = zeinv_tb_hd~uuidstatus
                LEFT JOIN zeinv_tb_taxcode AS tax ON tax~taxcode = vbrp~taxcode
                LEFT JOIN i_paymentmethod ON i_paymentmethod~paymentmethod = vbrk~paymentmethod
                   AND i_paymentmethod~country       = 'VN'
                WHERE vbrk~billingdocumenttype   IN @gr_fkart AND
                vbrk~companycode           IN @gr_companycode AND
                vbrk~billingdocumenttype   IN @gr_fkart AND
                vbrk~documentreferenceid   IN @gr_reference AND
                vbrk~billingdocument       IN @gr_vbeln AND
                _billtoparty~customer      IN @gr_kunnr AND
                vbrk~billingdocumentdate   IN @gr_bldat AND
                vbrk~billingdocumentdate   IN @gr_budat AND
                vbrk~creationdate          IN @gr_aedat AND
                vbrk~createdbyuser         IN @gr_usnam AND
                vbrk~accountingdocument    IN @gr_belnr AND
                vbrp~salesoffice           IN @gr_vkbur AND
                vbrp~salesgroup            IN @gr_vkgrp AND
                zeinv_tb_hd~uuidstatus     IN @gr_uuidstatus
               AND  ( zeinv_tb_hd~uuidstatus NOT IN  ( @zeinv_if_constants=>status_published, @zeinv_if_constants=>status_cancelled ) OR zeinv_tb_hd~uuidstatus IS NULL )
*               AND zeinv_tb_hd~uuidstatus IS NULL
*               AND  zeinv_tb_hd~uuidstatus <> @zeinv_if_constants=>status_cancelled OR zeinv_tb_hd~uuidstatus IS NULL
               AND  billtyp~billnghiepvu NOT IN ('3','4') AND vbrk~yy1_billingttoldhd_bdh IS INITIAL
               AND  vbrk~billingdocumentiscancelled IS INITIAL
               AND  vbrk~cancelledbillingdocument   IS INITIAL
        INTO TABLE @lt_data.

        lv_query          = 'zeinv_tb_hd~uuidstatus <> @zeinv_if_constants=>status_published and zeinv_tb_hd~uuidstatus <> @zeinv_if_constants=>status_cancelled or zeinv_tb_hd~uuidstatus is null '.
        lv_query_nghiepvu = `billtyp~billnghiepvu not in ('3','4') and vbrk~yy1_billingttoldhd_bdh IS INITIAL`.
        lv_query_2        = 'vbrk~billingdocumentiscancelled = @abap_false and vbrk~cancelledbillingdocument is initial'.
      WHEN OTHERS.
        lv_query = '( zeinv_tb_hd~uuidstatus <> @zeinv_if_constants=>status_published or zeinv_tb_hd~uuidstatus is null ) and ( vbrk~billingdocumentiscancelled = @abap_false and vbrk~cancelledbillingdocument is initial )'.
        IF p_adjust = abap_true.
          IF p_loainvdc EQ 'DCTG'.
            lv_query_nghiepvu = `billtyp~billnghiepvu in ('4')`.
          ELSE.
            lv_query_nghiepvu = `billtyp~billnghiepvu in ('3')`.
          ENDIF.
          SELECT DISTINCT
    'BILL' AS sourcetype,
    @p_billingaltunit   AS billingaltunit,
    @p_billinggeneral   AS billinggeneral ,
    @p_allbillingdetail AS allbillingdetail,
    @p_headoffice       AS xuathoadonheadoffice,
    @p_loainvdc         AS loainghiepvudieuchinh,
    @p_formatnumber     AS formatnumber,
    vbrk~billingdocument,
    vbrp~plant,
    vbrp~\_plant-plantname,
*                        vbrp~referencesddocument,
    vbrk~companycode,
    vbrk~billingdocumenttype,
    vbrk~billingdocumentdate  AS ngayhoadon,
    vbrk~billingdocumentdate  AS invoicedate,
    dats_tims_to_tstmp(
    date     = vbrk~billingdocumentdate ,
    time     = @lw_time,
    tzone    = @tzone,
    client   = @sy-mandt )
    AS dat_tim,
    billtyp~billnghiepvu,
    billtyp~note AS ghichu,
    billtyp~nofidoc,
    nghiepvu~billnghiepvu_text,
    vbrk~documentreferenceid,
    vbrk~accountingexchangerate,
    vbrk~transactioncurrency,
    vbrk~accountingdocument,
    vbrk~fiscalyear,
    vbrk~paymentmethod,
    zeinv_tb_hd~uuid,
    zeinv_tb_hd~uuidstatus,
    zeinv_status~uuidstatustext AS uuidstatusname,
    zeinv_tb_hd~einvoiceno,
    zeinv_tb_hd~einvoiceno_long,
    i_paymentmethod~paymentmethodname,
    i_journalentry~postingdate,
    _billtoparty~customer,
    _billtoparty~companyname AS buyercompany,
    _billtoparty~customerbusinesspartnergroup AS buyerbpgroup,
    _shiptoparty~fulladdress AS shippingaddress,
    zeinv_i_billingsum~subtotal1amount AS amountbeforetax,
    zeinv_i_billingsum~taxamount,
    ( zeinv_i_billingsum~subtotal1amount + zeinv_i_billingsum~taxamount ) AS amountaftertax,
    companycode~vatregistration,
*                        CASE WHEN adrc~addresseename2 <> ' ' OR adrc~addresseename3 <> ' ' OR adrc~addresseename4 <> ' '
*                             THEN concat_with_space( concat_with_space( adrc~addresseename2, adrc~addresseename3,1 ),adrc~addresseename4 ,1 )
*                             ELSE adrc~addresseename1                                                       END AS tennguoiban,

*                         concat_with_space( concat_with_space( concat_with_space(
*                                            concat_with_space( adrc~streetname, adrc~streetprefixname1,1 ),
*                                                               adrc~streetprefixname2 ,1 ), adrc~streetsuffixname1, 1 ),adrc~streetsuffixname2,1 )
*                          AS diachinban,

    "Ten Don Vi
    CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
*                                                                THEN bsec~businesspartnername1
                  THEN 'Người mua không cung cấp mã số thuế'
                  ELSE _billtoparty~fullname
             END
        ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
                  THEN 'Người mua không cung cấp mã số thuế'
                   ELSE _soldtoparty~fullname
              END
        END AS tendonvi,
    "Dia Chi

    CASE @p_headoffice WHEN  'X' THEN  _billtoparty~fulladdress
       ELSE _soldtoparty~fulladdress  END AS buyeraddress,
    CASE @p_headoffice WHEN  'X' THEN  _billtoparty~emailaddress
       ELSE _soldtoparty~emailaddress  END AS buyeremail,
    "MÃ SỐ THUẾ
    CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
                  THEN vbrk~vatregistration
                  ELSE _billtoparty~customervat
             END
        ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
                  THEN vbrk~vatregistration
                  ELSE _soldtoparty~customervat
              END
        END AS buyervatnumber,
    "Value
    CASE tax~einvoicetax
    WHEN @zeinv_if_constants=>gc_tax_rate_id-_0pc THEN 0
    WHEN @zeinv_if_constants=>gc_tax_rate_id-_5pc THEN 5
    WHEN @zeinv_if_constants=>gc_tax_rate_id-_8pc THEN 8
    WHEN @zeinv_if_constants=>gc_tax_rate_id-_10pc THEN 10
    END AS vatrate,
    "Ngày đăng ký phát hành
    zeinv_tb_hd~ngayphathanhhoadon,
    vbrk~yy1_billingttoldhd_bdh               AS billingmove,
    zeinv_tb_hd~check_thaythe_dieuchinh,
    zeinv_tb_hd~loaihoadon                    AS loaihoadon

    FROM i_billingdocument AS vbrk
    INNER JOIN i_billingdocumentitem AS vbrp
       ON vbrp~billingdocument = vbrk~billingdocument
    INNER JOIN zeinv_i_billingsum ON zeinv_i_billingsum~billingdocument = vbrk~billingdocument

    INNER JOIN zeinv_tb_billtyp AS billtyp
    ON billtyp~billingtype = vbrk~billingdocumenttype
    AND billtyp~orderreason = vbrp~sddocumentreason
    AND billtyp~mvgr1       = vbrp~additionalmaterialgroup1
    INNER JOIN zeinv_i_bill_nghiepvu AS nghiepvu
       ON nghiepvu~billnghiepvu = billtyp~billnghiepvu
    LEFT JOIN i_journalentry ON i_journalentry~accountingdocument = vbrk~accountingdocument
    AND i_journalentry~fiscalyear = vbrk~fiscalyear
    AND i_journalentry~companycode = vbrk~companycode
    LEFT JOIN i_companycode  AS companycode ON companycode~companycode = vbrk~companycode
    LEFT JOIN zi_organizationaddress AS adrc ON companycode~addressid = adrc~addressid
    LEFT JOIN i_onetimeaccountcustomer AS bsec
         ON bsec~accountingdocument = vbrk~accountingdocument
    LEFT JOIN zcore_i_profile_pf AS _billtoparty ON _billtoparty~sddocument      = vbrk~billingdocument
                  AND _billtoparty~partnerfunction = 'RE'
    LEFT JOIN zcore_i_profile_pf AS _soldtoparty ON _soldtoparty~sddocument      = vbrk~billingdocument
                  AND _soldtoparty~partnerfunction = 'AG'
    LEFT JOIN zcore_i_profile_pf AS _shiptoparty ON _shiptoparty~sddocument = vbrk~billingdocument
                  AND _shiptoparty~partnerfunction = 'WE'

    LEFT JOIN i_customercompany AS knb1 ON knb1~customer    = _billtoparty~customer
         AND knb1~companycode = vbrk~companycode
    LEFT JOIN zcore_i_profile_customer AS kna1 ON kna1~customer = knb1~customerheadoffice
    LEFT JOIN zeinv_i_config ON zeinv_i_config~type        =  '1'
    AND zeinv_i_config~companycode = vbrk~companycode
    AND zeinv_i_config~sourcetype  = 'BILL'
    AND zeinv_i_config~validfrom   <= @sy-datum
    AND zeinv_i_config~validto     >= @sy-datum
    AND zeinv_i_config~plant       = vbrp~plant

    LEFT JOIN zeinv_tb_hd ON zeinv_tb_hd~billingdocument = vbrk~billingdocument
    LEFT JOIN zeinv_i_status AS zeinv_status ON zeinv_status~uuidstatus = zeinv_tb_hd~uuidstatus
    LEFT JOIN zeinv_tb_taxcode AS tax ON tax~taxcode = vbrp~taxcode
    LEFT JOIN i_paymentmethod ON i_paymentmethod~paymentmethod = vbrk~paymentmethod
    AND i_paymentmethod~country       = 'VN'
    WHERE vbrk~billingdocumenttype   IN @gr_fkart AND
    vbrk~companycode           IN @gr_companycode AND
    vbrk~billingdocumenttype   IN @gr_fkart AND
    vbrk~documentreferenceid   IN @gr_reference AND
    vbrk~billingdocument       IN @gr_vbeln AND
    _billtoparty~customer      IN @gr_kunnr AND
    vbrk~billingdocumentdate   IN @gr_bldat AND
    vbrk~billingdocumentdate   IN @gr_budat AND
    vbrk~creationdate          IN @gr_aedat AND
    vbrk~createdbyuser         IN @gr_usnam AND
    vbrk~accountingdocument    IN @gr_belnr AND
    vbrp~salesoffice           IN @gr_vkbur AND
    vbrp~salesgroup            IN @gr_vkgrp AND
    zeinv_tb_hd~uuidstatus     IN @gr_uuidstatus AND
   ( zeinv_tb_hd~uuidstatus NOT IN (  @zeinv_if_constants=>status_published ) OR zeinv_tb_hd~uuidstatus IS NULL ) AND
   vbrk~billingdocumentiscancelled IS INITIAL AND
   vbrk~cancelledbillingdocument IS INITIAL AND
   (lv_query_nghiepvu)
   INTO TABLE @lt_data.
        ELSE.
          lv_query_nghiepvu   = `billtyp~billnghiepvu not in ('3','4')`.
          SELECT DISTINCT
'BILL' AS sourcetype,
@p_billingaltunit   AS billingaltunit,
@p_billinggeneral   AS billinggeneral ,
@p_allbillingdetail AS allbillingdetail,
@p_headoffice       AS xuathoadonheadoffice,
@p_loainvdc         AS loainghiepvudieuchinh,
@p_formatnumber     AS formatnumber,
vbrk~billingdocument,
vbrp~plant,
vbrp~\_plant-plantname,
*                        vbrp~referencesddocument,
vbrk~companycode,
vbrk~billingdocumenttype,
vbrk~billingdocumentdate  AS ngayhoadon,
vbrk~billingdocumentdate  AS invoicedate,
dats_tims_to_tstmp(
date     = vbrk~billingdocumentdate ,
time     = @lw_time,
tzone    = @tzone,
client   = @sy-mandt )
AS dat_tim,
billtyp~billnghiepvu,
billtyp~note AS ghichu,
billtyp~nofidoc,
nghiepvu~billnghiepvu_text,
vbrk~documentreferenceid,
vbrk~accountingexchangerate,
vbrk~transactioncurrency,
vbrk~accountingdocument,
vbrk~fiscalyear,
vbrk~paymentmethod,
zeinv_tb_hd~uuid,
zeinv_tb_hd~uuidstatus,
zeinv_status~uuidstatustext AS uuidstatusname,
zeinv_tb_hd~einvoiceno,
zeinv_tb_hd~einvoiceno_long,
i_paymentmethod~paymentmethodname,
i_journalentry~postingdate,
_billtoparty~customer,
_billtoparty~companyname AS buyercompany,
_billtoparty~customerbusinesspartnergroup AS buyerbpgroup,
_shiptoparty~fulladdress AS shippingaddress,
zeinv_i_billingsum~subtotal1amount AS amountbeforetax,
zeinv_i_billingsum~taxamount,
( zeinv_i_billingsum~subtotal1amount + zeinv_i_billingsum~taxamount ) AS amountaftertax,
companycode~vatregistration,
*                        CASE WHEN adrc~addresseename2 <> ' ' OR adrc~addresseename3 <> ' ' OR adrc~addresseename4 <> ' '
*                             THEN concat_with_space( concat_with_space( adrc~addresseename2, adrc~addresseename3,1 ),adrc~addresseename4 ,1 )
*                             ELSE adrc~addresseename1                                                       END AS tennguoiban,

*                         concat_with_space( concat_with_space( concat_with_space(
*                                            concat_with_space( adrc~streetname, adrc~streetprefixname1,1 ),
*                                                               adrc~streetprefixname2 ,1 ), adrc~streetsuffixname1, 1 ),adrc~streetsuffixname2,1 )
*                          AS diachinban,

"Ten Don Vi
CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
*                                                                THEN bsec~businesspartnername1
            THEN 'Người mua không cung cấp mã số thuế'
            ELSE _billtoparty~fullname
       END
  ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
            THEN 'Người mua không cung cấp mã số thuế'
             ELSE _soldtoparty~fullname
        END
  END AS tendonvi,
"Dia Chi

CASE @p_headoffice WHEN  'X' THEN  _billtoparty~fulladdress
 ELSE _soldtoparty~fulladdress  END AS buyeraddress,
CASE @p_headoffice WHEN  'X' THEN  _billtoparty~emailaddress
 ELSE _soldtoparty~emailaddress  END AS buyeremail,
"MÃ SỐ THUẾ
CASE @p_headoffice WHEN  'X'  THEN CASE WHEN _billtoparty~isonetimeaccount IS NOT INITIAL
            THEN vbrk~vatregistration
            ELSE _billtoparty~customervat
       END
  ELSE CASE WHEN _soldtoparty~isonetimeaccount IS NOT INITIAL
            THEN vbrk~vatregistration
            ELSE _soldtoparty~customervat
        END
  END AS buyervatnumber,
"Value
CASE tax~einvoicetax
WHEN @zeinv_if_constants=>gc_tax_rate_id-_0pc THEN 0
WHEN @zeinv_if_constants=>gc_tax_rate_id-_5pc THEN 5
WHEN @zeinv_if_constants=>gc_tax_rate_id-_8pc THEN 8
WHEN @zeinv_if_constants=>gc_tax_rate_id-_10pc THEN 10
END AS vatrate,
"Ngày đăng ký phát hành
zeinv_tb_hd~ngayphathanhhoadon,
vbrk~yy1_billingttoldhd_bdh               AS billingmove,
zeinv_tb_hd~check_thaythe_dieuchinh,
zeinv_tb_hd~loaihoadon                    AS loaihoadon

FROM i_billingdocument AS vbrk
INNER JOIN i_billingdocumentitem AS vbrp
 ON vbrp~billingdocument = vbrk~billingdocument
INNER JOIN zeinv_i_billingsum ON zeinv_i_billingsum~billingdocument = vbrk~billingdocument

INNER JOIN zeinv_tb_billtyp AS billtyp
ON billtyp~billingtype = vbrk~billingdocumenttype
AND billtyp~orderreason = vbrp~sddocumentreason
AND billtyp~mvgr1       = vbrp~additionalmaterialgroup1
INNER JOIN zeinv_i_bill_nghiepvu AS nghiepvu
 ON nghiepvu~billnghiepvu = billtyp~billnghiepvu
LEFT JOIN i_journalentry ON i_journalentry~accountingdocument = vbrk~accountingdocument
AND i_journalentry~fiscalyear = vbrk~fiscalyear
AND i_journalentry~companycode = vbrk~companycode
LEFT JOIN i_companycode  AS companycode ON companycode~companycode = vbrk~companycode
LEFT JOIN zi_organizationaddress AS adrc ON companycode~addressid = adrc~addressid
LEFT JOIN i_onetimeaccountcustomer AS bsec
   ON bsec~accountingdocument = vbrk~accountingdocument
LEFT JOIN zcore_i_profile_pf AS _billtoparty ON _billtoparty~sddocument      = vbrk~billingdocument
            AND _billtoparty~partnerfunction = 'RE'
LEFT JOIN zcore_i_profile_pf AS _soldtoparty ON _soldtoparty~sddocument      = vbrk~billingdocument
            AND _soldtoparty~partnerfunction = 'AG'
LEFT JOIN zcore_i_profile_pf AS _shiptoparty ON _shiptoparty~sddocument = vbrk~billingdocument
            AND _shiptoparty~partnerfunction = 'WE'

LEFT JOIN i_customercompany AS knb1 ON knb1~customer    = _billtoparty~customer
   AND knb1~companycode = vbrk~companycode
LEFT JOIN zcore_i_profile_customer AS kna1 ON kna1~customer = knb1~customerheadoffice
LEFT JOIN zeinv_i_config ON zeinv_i_config~type        =  '1'
AND zeinv_i_config~companycode = vbrk~companycode
AND zeinv_i_config~sourcetype  = 'BILL'
AND zeinv_i_config~validfrom   <= @sy-datum
AND zeinv_i_config~validto     >= @sy-datum
AND zeinv_i_config~plant       = vbrp~plant

LEFT JOIN zeinv_tb_hd ON zeinv_tb_hd~billingdocument = vbrk~billingdocument
LEFT JOIN zeinv_i_status AS zeinv_status ON zeinv_status~uuidstatus = zeinv_tb_hd~uuidstatus
LEFT JOIN zeinv_tb_taxcode AS tax ON tax~taxcode = vbrp~taxcode
LEFT JOIN i_paymentmethod ON i_paymentmethod~paymentmethod = vbrk~paymentmethod
AND i_paymentmethod~country       = 'VN'
WHERE vbrk~billingdocumenttype   IN @gr_fkart AND
vbrk~companycode           IN @gr_companycode AND
vbrk~billingdocumenttype   IN @gr_fkart AND
vbrk~documentreferenceid   IN @gr_reference AND
vbrk~billingdocument       IN @gr_vbeln AND
_billtoparty~customer      IN @gr_kunnr AND
vbrk~billingdocumentdate   IN @gr_bldat AND
vbrk~billingdocumentdate   IN @gr_budat AND
vbrk~creationdate          IN @gr_aedat AND
vbrk~createdbyuser         IN @gr_usnam AND
vbrk~accountingdocument    IN @gr_belnr AND
vbrp~salesoffice           IN @gr_vkbur AND
vbrp~salesgroup            IN @gr_vkgrp AND
zeinv_tb_hd~uuidstatus     IN @gr_uuidstatus AND
( zeinv_tb_hd~uuidstatus NOT IN (  @zeinv_if_constants=>status_published ) OR zeinv_tb_hd~uuidstatus IS NULL ) AND
vbrk~billingdocumentiscancelled IS INITIAL AND
vbrk~cancelledbillingdocument IS INITIAL AND
(lv_query_nghiepvu)
INTO TABLE @lt_data.
        ENDIF.
        IF p_adjust = abap_true.
          IF p_loainvdc = 'DCGG'.
            SELECT
                creditmemo~accountingdocexternalreference AS originbill,
                originbill~fiscalyear,
                originbill~companycode,
                originbill~accountingdocument,
                origininv~uuid AS originuuid,
                origininv~einvoiceno AS origineinvoiceno,
                adjustbill~billingdocument AS adjustbill
            FROM i_billingdocument AS adjustbill
            INNER JOIN i_billingdocumentitem AS adjustbillitem ON adjustbill~billingdocument = adjustbillitem~billingdocument
            INNER JOIN i_creditmemorequest AS creditmemo ON adjustbillitem~referencesddocument = creditmemo~creditmemorequest
            INNER JOIN i_billingdocument AS originbill ON originbill~billingdocument = creditmemo~accountingdocexternalreference
            INNER JOIN zeinv_tb_hd AS origininv ON origininv~billingdocument = originbill~billingdocument
            WHERE originbill~cancelledbillingdocument IS INITIAL
              AND adjustbill~cancelledbillingdocument IS INITIAL
              AND adjustbill~billingdocumentiscancelled IS INITIAL
              AND adjustbill~billingdocument IN @gr_vbeln
            INTO TABLE @DATA(lt_adjustbill).
            lr_adjustbill = VALUE #( FOR line_adjustbill IN lt_adjustbill
                                      ( sign   = 'I'
                                        option = 'EQ'
                                        low    = line_adjustbill-adjustbill ) ).
          ELSE.
            SELECT
               debitmemo~accountingdocexternalreference AS originbill,
               originbill~fiscalyear,
               originbill~companycode,
               originbill~accountingdocument,
               origininv~uuid AS originuuid,
               origininv~einvoiceno AS origineinvoiceno,
               adjustbill~billingdocument AS adjustbill
           FROM i_billingdocument AS adjustbill
           INNER JOIN i_billingdocumentitem AS adjustbillitem ON adjustbill~billingdocument = adjustbillitem~billingdocument
           INNER JOIN i_debitmemorequest AS debitmemo ON adjustbillitem~referencesddocument = debitmemo~debitmemorequest
           INNER JOIN i_billingdocument AS originbill ON originbill~billingdocument = debitmemo~accountingdocexternalreference
           INNER JOIN zeinv_tb_hd AS origininv ON origininv~billingdocument = originbill~billingdocument
           WHERE originbill~cancelledbillingdocument IS INITIAL
             AND adjustbill~cancelledbillingdocument IS INITIAL
             AND adjustbill~billingdocumentiscancelled IS INITIAL
             AND adjustbill~billingdocument IN @gr_vbeln
           INTO TABLE @lt_adjustbill.
            lr_adjustbill = VALUE #( FOR line_adjustbill IN lt_adjustbill
                                      ( sign   = 'I'
                                        option = 'EQ'
                                        low    = line_adjustbill-adjustbill ) ).
          ENDIF.
        ENDIF.
    ENDCASE.
    IF p_replace = abap_true OR p_normal = abap_true.
      DATA(flag) = 'X'.
      "CS_CuongHC_29.04.2025 start update logic HD thay the
      SELECT FROM i_billingdocument AS originbill
             INNER JOIN i_billingdocumentitem AS originbillit ON originbillit~billingdocument = originbill~billingdocument
             INNER JOIN i_billingdocumentitem AS replacebillit ON replacebillit~referencesddocument = originbillit~referencesddocument
             INNER JOIN i_billingdocument AS replacebill ON  replacebill~billingdocument = originbill~yy1_hoadongoc_bdh
             INNER JOIN zeinv_tb_hd AS originhd ON originhd~billingdocument = replacebill~billingdocument
      FIELDS DISTINCT
             originbill~billingdocument AS originbill,
             originhd~uuid AS originuuid,
             originhd~zpattern AS originpattern,
             originhd~zserial AS originserial,
             originhd~einvoiceno AS origineinvoiceno,
             originbill~yy1_hoadongoc_bdh AS replacebill
      WHERE
        originbill~yy1_hoadongoc_bdh IS NOT INITIAL
        AND replacebill~billingdocumentiscancelled IS NOT INITIAL
        AND originhd~uuidstatus = @zeinv_if_constants=>status_published
        AND replacebill~yy1_hdtt_bdh IS NOT  INITIAL
        AND
        originbill~billingdocument IN @gr_vbeln
        INTO TABLE @DATA(lt_replacebill).
      IF sy-subrc <> 0.
        flag = ''.
        "CS_CuongHC_29.04.2025 end update logic HD thay the
        SELECT FROM i_billingdocument AS originbill
        INNER JOIN zeinv_tb_hd AS originhd ON originhd~billingdocument = originbill~billingdocument
        INNER JOIN i_billingdocumentitem AS originbillit ON originbillit~billingdocument = originbill~billingdocument
        INNER JOIN i_billingdocumentitem AS replacebillit ON replacebillit~referencesddocument = originbillit~referencesddocument
        INNER JOIN i_billingdocument AS replacebill ON  replacebill~billingdocument = replacebillit~billingdocument
        FIELDS DISTINCT
        originbill~billingdocument AS originbill,
        originhd~uuid AS originuuid,
        originhd~zpattern AS originpattern,
        originhd~zserial AS originserial,
        originhd~einvoiceno AS origineinvoiceno,
        replacebill~billingdocument AS replacebill
 WHERE originbill~billingdocumentiscancelled IS NOT INITIAL
   AND originbill~yy1_hdtt_bdh IS NOT INITIAL
   AND replacebill~billingdocument IN @gr_vbeln
   AND replacebill~billingdocumentiscancelled IS INITIAL
   AND replacebill~cancelledbillingdocument IS INITIAL
   AND originhd~einvoiceno IS NOT INITIAL
   AND originhd~uuidstatus = @zeinv_if_constants=>status_published
       INTO TABLE @lt_replacebill.
      ENDIF.
      IF sy-subrc = 0.
        SORT lt_replacebill BY originbill DESCENDING.
        DELETE ADJACENT DUPLICATES FROM lt_replacebill COMPARING replacebill.

        lr_replacebill = VALUE #( FOR line_replace IN lt_replacebill
                                ( sign   = 'I'
                                  option = 'EQ'
                                  low    = line_replace-replacebill ) ).
      ENDIF.
    ENDIF.



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

*  check neu Item co hang uy thac thi xuat hd VND
    SELECT
        i_billingdocumentitem~billingdocument,
        matlaccountassignmentgroup
    FROM i_billingdocumentitem
    INNER JOIN @lt_data AS data ON data~billingdocument = i_billingdocumentitem~billingdocument
    WHERE i_billingdocumentitem~matlaccountassignmentgroup = 'ZC' "Hàng ủy thác
    ORDER BY i_billingdocumentitem~billingdocument
    INTO TABLE @DATA(lt_hanguythac).
*  check neu Item co hang uy thac thi xuat hd VND

    SELECT DISTINCT
        zeinv_i_config~companycode,
        zeinv_i_config~plant,
        zeinv_i_config~zpattern,
        zeinv_i_config~zserial,
        zeinv_i_config~zserialcert
    FROM zeinv_i_config
    INNER JOIN @lt_data AS data ON zeinv_i_config~type        =  '1'
                               AND zeinv_i_config~companycode = data~companycode
                               AND zeinv_i_config~sourcetype  = 'BILL'
                               AND zeinv_i_config~validfrom   <= @sy-datum
                               AND zeinv_i_config~validto     >= @sy-datum
                               AND zeinv_i_config~plant        = data~plant
    ORDER BY zeinv_i_config~companycode, zeinv_i_config~plant
    INTO CORRESPONDING FIELDS OF TABLE @gt_config.

    IF p_normal = abap_true AND lr_replacebill IS NOT INITIAL.
      DELETE lt_data WHERE billingdocument IN lr_replacebill.
    ELSEIF p_replace = abap_true.
      IF   lr_replacebill IS INITIAL.
        DELETE lt_data.
      ELSE.
        IF flag <> 'X'.
          DELETE lt_data WHERE billingdocument NOT IN lr_replacebill.
        ENDIF.
      ENDIF.

    ELSEIF p_adjust = abap_true.
      IF   lr_adjustbill IS INITIAL.
        DELETE lt_data.
      ELSE.
        DELETE lt_data WHERE billingdocument NOT IN lr_adjustbill.
      ENDIF.
    ELSEIF p_adjust = abap_true.
    ENDIF.

    SELECT FROM i_billingdocumentitem AS item
    INNER JOIN @lt_data AS data ON data~billingdocument = item~billingdocument
*    LEFT JOIN i_unitofmeasure AS einvunit ON einvunit~unitofmeasure_e = item~yy1_einvoiceunit_bdi
    FIELDS
        item~billingdocument,
        item~product,
        item~billingquantity,
        item~billingquantityunit
*        einvunit~unitofmeasure AS einvoiceunit
    ORDER BY item~billingdocument
    INTO TABLE @DATA(lt_billquan).

    " get billing header text
    DATA: lv_amount TYPE fins_vwcur12.
    DATA(lt_billing)           = CORRESPONDING zcore_cl_get_long_text=>ty_billing( lt_data DISCARDING DUPLICATES ).
    DATA(lt_billingheadertext) = zcore_cl_get_long_text=>get_multi_billing_header_text( it_billing = lt_billing ).
    IF lt_data IS NOT INITIAL.

*        Số tài khoản (Bank account)
      SELECT but0bk~businesspartner,
             but0bk~bankname,
             but0bk~banknumber
      FROM i_businesspartnerbank AS but0bk
      FOR ALL ENTRIES IN @lt_data
      WHERE but0bk~validitystartdate <= @lt_data-dat_tim
        AND but0bk~validityenddate   >= @lt_data-dat_tim
        AND but0bk~businesspartner   = @lt_data-customer
      INTO TABLE @DATA(lt_bank).
      IF sy-subrc = 0.
        SORT lt_bank BY businesspartner.
      ENDIF.

      SELECT i_billingdocumentitem~billingdocument,
             i_billingdocumentitem~referencesddocument
      FROM i_billingdocumentitem
      FOR ALL ENTRIES IN @lt_data
      WHERE i_billingdocumentitem~billingdocument = @lt_data-billingdocument
      INTO TABLE @DATA(lt_referencesddocument).
      IF sy-subrc = 0.
        SORT lt_referencesddocument BY billingdocument.
      ENDIF.


      LOOP AT lt_data REFERENCE INTO DATA(ls_temp).
        "! Điều kiện NoFIdoc trong khai báo và không có FI doc - loại
        IF ls_temp->nofidoc = space AND ls_temp->accountingdocument IS INITIAL.
          CONTINUE.
        ENDIF.


        APPEND INITIAL LINE TO gt_data REFERENCE INTO DATA(ls_data).
        ls_data->* = CORRESPONDING #( ls_temp->* ).

        IF ls_data->uuidstatus EQ '1'.
          ls_data->loaihoadon =  'VIEW'.
        ELSEIF ls_data->loaihoadon IS INITIAL.
          ls_data->loaihoadon = p_loaihoadon.
        ENDIF.

        READ TABLE lt_billingheadertext REFERENCE INTO DATA(ls_billingheadertext)
        WITH KEY billing_document = ls_temp->billingdocument
                 long_text_id = 'Z003'.
        IF sy-subrc = 0.
          ls_data->buyer = ls_billingheadertext->long_text.
        ENDIF.
        READ TABLE lt_billingheadertext REFERENCE INTO ls_billingheadertext
        WITH KEY billing_document = ls_temp->billingdocument
                 long_text_id = 'Z004'.
        IF sy-subrc = 0.
          ls_data->bankaccount = ls_billingheadertext->long_text.
        ENDIF.

        READ TABLE gt_config REFERENCE INTO DATA(ls_config) WITH KEY companycode = ls_temp->companycode
                                                                     plant       = ls_temp->plant BINARY SEARCH.
        IF sy-subrc = 0.
          ls_data->zpattern    = ls_config->zpattern.
          ls_data->zserial     = ls_config->zserial.
          ls_data->zserialcert = ls_config->zserialcert.
        ENDIF.

        IF p_replace = abap_true.
          "CS_CuongHC_29.04.2025 start update logic HD thay the
          READ TABLE lt_replacebill REFERENCE INTO DATA(ls_replacebill) WITH KEY originbill = ls_temp->billingdocument.
          IF sy-subrc = 0 AND flag EQ 'X'.
            ls_data->origineinvoiceno = ls_replacebill->origineinvoiceno.
            ls_data->originuuid       = ls_replacebill->originuuid.
            ls_data->originbill       = ls_replacebill->originbill.
          ELSE.
            "CS_CuongHC_29.04.2025 end update logic HD thay the
            READ TABLE lt_replacebill REFERENCE INTO ls_replacebill WITH KEY replacebill = ls_temp->billingdocument.
            IF sy-subrc = 0.
              ls_data->origineinvoiceno = ls_replacebill->origineinvoiceno.
              ls_data->originuuid       = ls_replacebill->originuuid.
              ls_data->originbill       = ls_replacebill->originbill.
            ENDIF.
          ENDIF.
        ELSEIF p_adjust = abap_true.
          READ TABLE lt_adjustbill REFERENCE INTO DATA(ls_adjustbill) WITH KEY adjustbill = ls_temp->billingdocument.
          IF sy-subrc = 0.
            ls_data->origineinvoiceno = ls_adjustbill->origineinvoiceno.
            ls_data->originuuid       = ls_adjustbill->originuuid.
            ls_data->originbill       = ls_adjustbill->originbill.
          ENDIF.
        ENDIF.
        IF ls_data->loaihoadon IS INITIAL.
          ls_data->loaihoadon = p_loaihoadon.
        ENDIF.
        ls_data->sothamkhao = |{ ls_temp->billingdocument }|.
        "người mua hàng
        READ TABLE lt_billingheadertext REFERENCE INTO ls_billingheadertext
        WITH KEY billing_document = ls_temp->billingdocument
                 long_text_id = 'Z013'.
        IF sy-subrc = 0.
          ls_data->buyer = ls_billingheadertext->long_text.
        ENDIF.

        READ TABLE lt_hanguythac TRANSPORTING NO FIELDS
        WITH KEY billingdocument = ls_temp->billingdocument BINARY SEARCH.
        IF sy-subrc = 0.
          ls_temp->transactioncurrency = 'VND'.
        ENDIF.
        lv_amount = |{ ls_temp->amountaftertax CURRENCY = ls_temp->transactioncurrency  }|.
        ls_data->amountinwords = zcore_cl_amount_in_words=>read_amount( i_amount = lv_amount
                                                                        i_waers  = ls_temp->transactioncurrency ).
        IF ls_data->transactioncurrency = 'USD'.
          ls_data->accountingexchangerate = ls_data->accountingexchangerate * 1000.
        ENDIF.
        "ghi chú
        READ TABLE lt_billingheadertext REFERENCE INTO ls_billingheadertext
        WITH KEY billing_document = ls_temp->billingdocument
                 long_text_id = 'Z022'.
        IF sy-subrc = 0.
          IF ls_billingheadertext->long_text IS NOT INITIAL.
            ls_temp->ghichu = ls_billingheadertext->long_text.
          ENDIF.
        ENDIF.

        READ TABLE lt_billquan TRANSPORTING NO FIELDS WITH KEY billingdocument = ls_data->billingdocument BINARY SEARCH.
        IF sy-subrc = 0.
          LOOP AT lt_billquan INTO DATA(ls_billquan) FROM sy-tabix.
            IF ls_billquan-billingdocument <> ls_data->billingdocument.
              EXIT.
            ENDIF.
            ls_data->totalquantity += ls_billquan-billingquantity.
          ENDLOOP.
        ENDIF.

        READ TABLE lt_bank REFERENCE INTO DATA(ls_bank) WITH KEY businesspartner = ls_data->customer BINARY SEARCH.
        IF sy-subrc = 0.
          ls_data->bankname    = ls_bank->bankname.
        ENDIF.

        "FORMAT NUMBER HOÁ ĐƠN THAY THẾ
        IF p_adjust = abap_true.
          CASE p_formatnumber.
            WHEN '1'.
              ls_data->taxamount      = ls_data->taxamount * -1.
              ls_data->amountaftertax = ls_data->amountaftertax * -1.
            WHEN '2'.

            WHEN '3'.
          ENDCASE.
        ENDIF.

        READ TABLE lt_referencesddocument INTO DATA(ls_referencesddocument) WITH KEY billingdocument = ls_data->billingdocument BINARY SEARCH.
        IF sy-subrc = 0.
          ls_data->referencesddocument = ls_referencesddocument-referencesddocument.
        ENDIF.

        "Payment Method
        IF ls_data->paymentmethod    = ' '.
          ls_data->paymentmethod     = 'C'.
          ls_data->paymentmethodname = 'TM/CK'.
        ENDIF.

        "KM
        IF ls_data->billnghiepvu = '1' OR ls_data->billnghiepvu = '2'.
          ls_data->paymentmethodname = 'Không thu tiền'.
        ENDIF.

      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD get_data_drafed.

    SELECT FROM zeinv_tb_hd AS hddt
          LEFT JOIN zeinv_i_status AS zeinv_status ON zeinv_status~uuidstatus = hddt~uuidstatus
          LEFT JOIN zeinv_tb_billtyp AS billtyp ON billtyp~billingtype = hddt~billingdocumenttype
          LEFT JOIN zeinv_i_bill_nghiepvu AS nghiepvu ON nghiepvu~billnghiepvu = billtyp~billnghiepvu
          LEFT JOIN i_paymentmethod ON i_paymentmethod~paymentmethod = hddt~paymentmethod
           FIELDS
           hddt~*,
           hddt~uuid,
           zeinv_status~uuidstatustext AS uuidstatusname,
           nghiepvu~billnghiepvu_text,
           CASE WHEN hddt~transactioncurrency = 'VND'
           THEN division( hddt~amountbeforetax , 100, 3 )
           ELSE hddt~amountbeforetax END AS amountbeforetax,
           CASE WHEN hddt~transactioncurrency = 'VND'
           THEN division( hddt~taxamount , 100, 3 )
           ELSE hddt~taxamount END AS taxamount,
           CASE WHEN hddt~transactioncurrency = 'VND'
           THEN division( hddt~amountaftertax , 100, 3 )
           ELSE hddt~amountaftertax END AS amountaftertax
           WHERE hddt~uuidstatus = @zeinv_if_constants=>status_drafted
             AND hddt~einvoiceno IS NOT INITIAL
             AND hddt~loaihoadon = @p_loaihoadon AND
                hddt~billingdocumenttype IN @gr_fkart AND
                hddt~companycode         IN @gr_companycode AND
                hddt~fiscalyear            IN @gr_fiscalyear AND
                hddt~billingdocumenttype   IN @gr_fkart AND
                hddt~documentreferenceid   IN @gr_reference AND
                hddt~billingdocument       IN @gr_vbeln AND
                hddt~customer              IN @gr_kunnr AND
                hddt~documentdate          IN @gr_bldat AND
                hddt~accountingdocument    IN @gr_belnr AND
                hddt~sourcetype = @p_sourcetype
*             AND (lv_status_his)
           APPENDING CORRESPONDING FIELDS OF TABLE @gt_data.

  ENDMETHOD.


  METHOD get_data_view.


    SELECT FROM zeinv_tb_hd AS hddt
          LEFT JOIN zeinv_i_status AS zeinv_status ON zeinv_status~uuidstatus = hddt~uuidstatus
          LEFT JOIN zeinv_tb_billtyp AS billtyp ON billtyp~billingtype = hddt~billingdocumenttype
          LEFT JOIN zeinv_i_bill_nghiepvu AS nghiepvu ON nghiepvu~billnghiepvu = billtyp~billnghiepvu
          FIELDS
          hddt~*,
          nghiepvu~billnghiepvu_text,
           CASE WHEN hddt~transactioncurrency = 'VND'
           THEN division( hddt~amountbeforetax , 100, 3 )
           ELSE hddt~amountbeforetax END AS amountbeforetax,
           CASE WHEN hddt~transactioncurrency = 'VND'
           THEN division( hddt~taxamount , 100, 3 )
           ELSE hddt~taxamount END AS taxamount,
           CASE WHEN hddt~transactioncurrency = 'VND'
           THEN division( hddt~amountaftertax , 100, 3 )
           ELSE hddt~amountaftertax END AS amountaftertax,
          hddt~uuid,
          zeinv_status~uuidstatustext AS uuidstatusname,

          @p_loaihoadon AS loaihoadon
          WHERE ( ( hddt~uuidstatus IN ( @zeinv_if_constants=>status_published
                                       , @zeinv_if_constants=>status_cancelled )
                    AND  hddt~einvoiceno IS NOT INITIAL )
            OR hddt~uuidstatus = @zeinv_if_constants=>status_del_draf ) AND
                hddt~billingdocumenttype IN @gr_fkart AND
                hddt~companycode         IN @gr_companycode AND
                hddt~fiscalyear            IN @gr_fiscalyear AND
                hddt~billingdocumenttype   IN @gr_fkart AND
                hddt~documentreferenceid   IN @gr_reference AND
                hddt~billingdocument       IN @gr_vbeln AND
                hddt~customer              IN @gr_kunnr AND
                hddt~documentdate          IN @gr_bldat AND
                hddt~accountingdocument    IN @gr_belnr AND
                hddt~sourcetype = @p_sourcetype
*            AND (lv_status_his)
          INTO CORRESPONDING FIELDS OF TABLE @r_result.
  ENDMETHOD.


  METHOD get_fi.
    DATA:
         lv_query          TYPE string.
    CASE p_loaihoadon.
      WHEN zeinv_if_constants=>canc.

      WHEN zeinv_if_constants=>view.
        lv_query  =  `( zeinv_tb_hd~uuidstatus = @zeinv_if_constants=>status_published or zeinv_tb_hd~uuidstatus = @zeinv_if_constants=>status_cancelled )`.
      WHEN zeinv_if_constants=>norm.
        lv_query  = 'zeinv_tb_hd~uuidstatus <> @zeinv_if_constants=>status_published and zeinv_tb_hd~uuidstatus <> @zeinv_if_constants=>status_cancelled or zeinv_tb_hd~uuidstatus is null '.
      WHEN OTHERS.

    ENDCASE.
    SELECT DISTINCT
    'FI' AS sourcetype,
    @p_formatnumber     AS formatnumber,
    bkpf~companycode,
    bkpf~fiscalyear,
    bkpf~fiscalyear AS accountingdocumentyear,
    bkpf~accountingdocument,
    bkpf~transactioncurrency,
    bkpf~documentdate,
    bkpf~postingdate,
    bkpf~documentreferenceid,
    bkpf~postingdate  AS ngayhoadon,
    bkpf~postingdate  AS invoicedate,
    zeinv_tb_hd~uuid,
    zeinv_tb_hd~uuidstatus,
    zeinv_tb_hd~einvoiceno,
    "Ngày đăng ký phát hành
      zeinv_tb_hd~ngayphathanhhoadon,
    zeinv_status~uuidstatustext AS uuidstatusname,
    bkpf~absoluteexchangerate AS accountingexchangerate,
    abs( fisum~amountintransactioncurrency )                      AS amountbeforetax,
    abs( fisumtax~amountintransactioncurrency )                    AS taxamount
*    ( abs( fisum~amountintransactioncurrency ) + abs( fisumtax~amountintransactioncurrency ) ) AS amountaftertax
    FROM i_journalentry AS bkpf
*    LEFT JOIN i_operationalacctgdoctaxitem AS bset ON bset~companycode = bkpf~companycode
*                                                  AND bset~fiscalyear = bkpf~fiscalyear
*                                                  AND bset~accountingdocument = bkpf~accountingdocument
    LEFT JOIN zeinv_i_fisum AS fisum ON bkpf~companycode = fisum~companycode
    AND bkpf~fiscalyear  = fisum~fiscalyear
    AND bkpf~accountingdocument = fisum~accountingdocument
    LEFT JOIN zeinv_i_fisumtax AS fisumtax ON bkpf~companycode        = fisumtax~companycode
    AND bkpf~fiscalyear         = fisumtax~fiscalyear
    AND bkpf~accountingdocument = fisumtax~accountingdocument
    LEFT JOIN zeinv_tb_hd ON zeinv_tb_hd~accountingdocument = bkpf~accountingdocument "
    LEFT JOIN zeinv_i_status AS zeinv_status ON zeinv_status~uuidstatus = zeinv_tb_hd~uuidstatus
*                          and zeinv_tb_hd~acc concat( 'FI@', concat( bkpf~accountingdocument, concat( bkpf~fiscalyear,  bkpf~companycode ) ) )
    AND zeinv_tb_hd~fiscalyear = bkpf~fiscalyear
    AND zeinv_tb_hd~companycode = bkpf~companycode
    WHERE ( bkpf~accountingdocumenttype = 'DR' OR bkpf~accountingdocumenttype = 'DG' ) AND
    bkpf~companycode            IN @gr_companycode AND
    bkpf~accountingdocument     IN @gr_belnr AND
    bkpf~documentdate           IN @gr_bldat AND
    bkpf~postingdate            IN @gr_budat AND
    bkpf~documentreferenceid    IN @gr_reference AND
    bkpf~accountingdoccreatedbyuser IN @gr_usnam AND
    zeinv_tb_hd~uuidstatus     IN @gr_uuidstatus AND

    bkpf~transactioncode        IN ( 'FB70' , 'FB75', 'F-92', 'F-02', 'ZUP', 'FB50', 'FB01' ) AND
    (lv_query)
    INTO TABLE @DATA(lt_data).
    IF   lt_data IS NOT INITIAL.

      SELECT DISTINCT
          zeinv_i_config~companycode,
          zeinv_i_config~zpattern,
          zeinv_i_config~zserial,
          zeinv_i_config~zserialcert
      FROM zeinv_i_config
      INNER JOIN @lt_data AS data ON zeinv_i_config~type =  '1'
                              AND zeinv_i_config~companycode = data~companycode
                              AND zeinv_i_config~sourcetype = 'FI'
                              AND zeinv_i_config~validfrom <= @sy-datum
                              AND zeinv_i_config~validto >= @sy-datum
      ORDER BY zeinv_i_config~companycode
      INTO CORRESPONDING FIELDS OF TABLE @gt_config.

      SELECT
          profile~accountingdocument,
          profile~fiscalyear,
          profile~companycode,
          profile~account,
          profile~financialaccounttype,
          profile~accountnname,
          profile~accountaddress,
          profile~accountbusinesspartnergroup,
          profile~accounttaxnumber,
          profile~paymentmethod,
          i_paymentmethod~paymentmethodname
      FROM zcore_i_profile_fidoc AS profile
      INNER JOIN @lt_data AS data ON data~accountingdocument = profile~accountingdocument
                                 AND data~accountingdocumentyear = profile~fiscalyear
                                 AND data~companycode = profile~companycode
      LEFT JOIN i_paymentmethod ON i_paymentmethod~paymentmethod = profile~paymentmethod
      ORDER BY  profile~accountingdocument,
                profile~fiscalyear,
                profile~companycode
      INTO TABLE @DATA(lt_account).

      DATA: ls_data   TYPE zeinv_i_hoadon,
            lv_amount TYPE fins_vwcur12.
      LOOP AT lt_data REFERENCE INTO DATA(ls_temp).

        ls_data = CORRESPONDING #( ls_temp->* ).
        ls_data-sothamkhao = |{ ls_temp->accountingdocument }{ ls_temp->accountingdocumentyear }{ ls_temp->companycode }|.

        ls_data-loaihoadon = p_loaihoadon.
        ls_data-amountaftertax = ls_data-amountbeforetax + ls_data-taxamount.
        "serial - pattern
        READ TABLE gt_config REFERENCE INTO DATA(ls_config)
        WITH KEY companycode = ls_temp->companycode.
        IF sy-subrc = 0.
          ls_data-zserial     = ls_config->zserial.
          ls_data-zpattern    = ls_config->zpattern.
          ls_data-zserialcert = ls_config->zserialcert.
        ENDIF.

        "tên đơn vị - người mua hàng
        READ TABLE lt_account REFERENCE INTO DATA(ls_account)
        WITH KEY accountingdocument = ls_temp->accountingdocument
                 fiscalyear = ls_temp->accountingdocumentyear
                 companycode = ls_temp->companycode BINARY SEARCH.
        IF sy-subrc = 0.

          IF ls_account->financialaccounttype = 'D'.
            ls_data-customer = ls_account->account.
          ELSE.
            ls_data-vendor = ls_account->account.
          ENDIF.

*          IF  ls_account->accountbusinesspartnergroup = '0003'. "Company
          ls_data-tendonvi = ls_account->accountnname.
*          ELSE.
*            ls_data-buyer = ls_account->accountnname.
*          ENDIF.
          ls_data-buyeraddress = ls_account->accountaddress.
          ls_data-buyervatnumber = ls_account->accounttaxnumber.
          ls_data-paymentmethod = ls_account->paymentmethod.
          ls_data-paymentmethodname = ls_account->paymentmethodname.
          IF ls_account->financialaccounttype = 'D'.
            ls_data-shippingaddress = ls_data-buyeraddress.
          ENDIF.
        ENDIF.

        IF  ls_temp->transactioncurrency = 'VND'.
          lv_amount = ls_data-amountaftertax * 100 .
*        lv_amount = |{ ls_data-amountaftertax CURRENCY = ls_temp->transactioncurrency  }|.
        ENDIF.
        ls_data-amountinwords = zcore_cl_amount_in_words=>read_amount( i_amount = lv_amount
                                                                i_waers  = ls_temp->transactioncurrency ).

        "Payment Method
        IF ls_data-paymentmethod = ' '.
          ls_data-paymentmethod  = 'C'.
          ls_data-paymentmethodname = 'TM/CK'.
        ENDIF.

        APPEND ls_data TO gt_data.

      ENDLOOP.

    ENDIF.
  ENDMETHOD.


  METHOD get_po.
    DATA: lr_invoic TYPE RANGE OF zde_reference,
          lw_tax    TYPE fins_vwcur12.


    CASE p_loaihoadon.
      WHEN zeinv_if_constants=>view.

        gt_data = get_data_view( ).

      WHEN zeinv_if_constants=>canc.

        SELECT FROM zeinv_tb_hd AS hddt
        INNER JOIN i_journalentry AS bseg ON  bseg~accountingdocument = hddt~accountingdocument
                                          AND bseg~fiscalyear = hddt~fiscalyear
                                          AND bseg~companycode = hddt~companycode
        LEFT JOIN zeinv_i_status AS zeinv_status ON zeinv_status~uuidstatus = hddt~uuidstatus
        LEFT JOIN zeinv_tb_billtyp AS billtyp ON billtyp~billingtype = hddt~billingdocumenttype
        LEFT JOIN zeinv_i_bill_nghiepvu AS nghiepvu ON nghiepvu~billnghiepvu = billtyp~billnghiepvu
        FIELDS
        hddt~*,
        hddt~uuid,
        hddt~einvoiceno AS einvoiceno,
        zeinv_status~uuidstatustext AS uuidstatusname,
        nghiepvu~billnghiepvu_text,
         CASE WHEN hddt~transactioncurrency = 'VND'
         THEN division( hddt~amountbeforetax , 100, 3 )
         ELSE hddt~amountbeforetax END AS amountbeforetax,
         CASE WHEN hddt~transactioncurrency = 'VND'
         THEN division( hddt~taxamount , 100, 3 )
         ELSE hddt~taxamount END AS taxamount,
         CASE WHEN hddt~transactioncurrency = 'VND'
         THEN division( hddt~amountaftertax , 100, 3 )
         ELSE hddt~amountaftertax END AS amountaftertax,

        @p_loaihoadon AS loaihoadon
        WHERE hddt~uuidstatus = @zeinv_if_constants=>status_published
          AND hddt~einvoiceno IS NOT INITIAL
          AND bseg~isreversed = @abap_true AND
              hddt~billingdocumenttype IN @gr_fkart AND
              hddt~companycode         IN @gr_companycode AND
              hddt~fiscalyear            IN @gr_fiscalyear AND
              hddt~billingdocumenttype   IN @gr_fkart AND
*              hddt~documentreferenceid   IN @gr_reference AND
              hddt~billingdocument       IN @gr_vbeln AND
              hddt~customer              IN @gr_kunnr AND
              hddt~documentdate          IN @gr_budat AND
              hddt~accountingdocument    IN @gr_belnr AND
              hddt~sourcetype = @p_sourcetype
        INTO CORRESPONDING FIELDS OF TABLE @gt_data.


      WHEN OTHERS.
        DATA(lv_join)  =  `zeinv_tb_hd~uuidstatus <> @zeinv_if_constants=>status_del_draf`.
        DATA(lv_query) = `( ( zeinv_tb_hd~uuidstatus <> @zeinv_if_constants=>status_published `
                && ` and zeinv_tb_hd~uuidstatus <> @zeinv_if_constants=>status_drafted `
                && ` and zeinv_tb_hd~uuidstatus <> @zeinv_if_constants=>status_del_draf  )`
                && ` or zeinv_tb_hd~uuidstatus is null or zeinv_tb_hd~uuidstatus = @zeinv_if_constants=>status_init or zeinv_tb_hd~uuidstatus = @zeinv_if_constants=>status_drafted )`.

        SELECT FROM i_journalentry AS bkpf
        INNER JOIN i_journalentryitem AS bseg ON  bseg~companycode = bkpf~companycode
                                              AND bseg~fiscalyear = bkpf~fiscalyear
                                              AND bseg~accountingdocument = bkpf~accountingdocument
                                              AND substring( bseg~glaccount, 1 , 3 ) = '331'
                                              AND bseg~purchasingdocument IS NOT INITIAL
        LEFT JOIN i_suplrinvcitempurordrefapi01 AS resg
                                                ON resg~purchaseorder     = bseg~purchasingdocument
                                               AND resg~purchaseorderitem = bseg~purchasingdocumentitem
        LEFT JOIN i_supplierinvoiceapi01 AS rbkp
                                         ON rbkp~supplierinvoice = resg~supplierinvoice
                                        AND rbkp~fiscalyear      = resg~fiscalyear
         LEFT JOIN zeinv_i_posumquan ON zeinv_i_posumquan~fiscalyear      = resg~fiscalyear
                                    AND zeinv_i_posumquan~supplierinvoice = resg~supplierinvoice
        LEFT JOIN zeinv_tb_hd ON zeinv_tb_hd~accountingdocument = bkpf~accountingdocument
                             AND zeinv_tb_hd~fiscalyear = bkpf~fiscalyear
                             AND zeinv_tb_hd~companycode = bkpf~companycode
                             AND (lv_join)
        LEFT JOIN zeinv_i_config ON zeinv_i_config~type = '1'
                                        AND zeinv_i_config~companycode = bkpf~companycode
                                        AND zeinv_i_config~sourcetype = 'PO'
                                        AND zeinv_i_config~validfrom <= @sy-datum
                                        AND zeinv_i_config~validto >= @sy-datum
                                        AND bseg~plant = zeinv_i_config~plant
        LEFT JOIN zeinv_tb_taxcode ON zeinv_tb_taxcode~taxcode = bseg~taxcode
        LEFT JOIN zeinv_i_loaithue ON zeinv_tb_taxcode~einvoicetax = zeinv_i_loaithue~einvoicetax
        LEFT JOIN zeinv_i_status AS zeinv_status ON zeinv_status~uuidstatus = zeinv_tb_hd~uuidstatus

       FIELDS DISTINCT
            'PO' AS sourcetype,
            @p_allbillingdetail AS allbillingdetail,
            @p_formatnumber     AS formatnumber,
            zeinv_i_config~zpattern,
            zeinv_i_config~zserial,
            zeinv_i_config~zserialcert,
*            BKPF~POSTINGDATE AS INVOICEDATE,
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
            bseg~referencedocument AS documentnumber,
            abs( zeinv_i_posumquan~quantity ) AS totalquantity,

            bkpf~absoluteexchangerate AS accountingexchangerate,
            "Value
            CASE zeinv_tb_taxcode~einvoicetax
              WHEN @zeinv_if_constants=>gc_tax_rate_id-_0pc THEN 0
              WHEN @zeinv_if_constants=>gc_tax_rate_id-_5pc THEN 5
              WHEN @zeinv_if_constants=>gc_tax_rate_id-_8pc THEN 8
              WHEN @zeinv_if_constants=>gc_tax_rate_id-_10pc THEN 10
            END AS vatrate,
            zeinv_i_loaithue~einvoicetaxtext AS desvatrate,
            resg~documentcurrency AS amountintransactioncurrency,
             zeinv_tb_hd~uuid,
            zeinv_tb_hd~uuidstatus,
            zeinv_tb_hd~einvoiceno,
            zeinv_status~uuidstatustext AS uuidstatusname,
            "Ngày đăng ký phát hành
            zeinv_tb_hd~ngayphathanhhoadon
*            fisum~amountintransactioncurrency,
*            fisumtax~amountintransactioncurrency AS amountintransactioncurrencytax,
*            abs( fisum~amountintransactioncurrency )                      AS amountbeforetax,
*            abs( fisumtax~amountintransactioncurrency )                    AS taxamount,
*            ( abs( fisum~amountintransactioncurrency ) + abs( fisumtax~amountintransactioncurrency ) ) AS amountaftertax

        WHERE   bkpf~accountingdocumenttype = 'RE' AND
                bkpf~companycode            IN @gr_companycode AND
                bkpf~accountingdocument     IN @gr_belnr AND
                bkpf~documentdate           IN @gr_bldat AND
                bkpf~postingdate            IN @gr_budat AND
                bkpf~documentreferenceid    IN @gr_reference AND
                bkpf~accountingdoccreatedbyuser IN @gr_usnam AND
                bkpf~isreversed IS INITIAL AND
                bkpf~isreversal IS INITIAL AND
                rbkp~isinvoice               = ' '  AND
                resg~issubsequentdebitcredit = ' '  AND
                zeinv_tb_hd~uuidstatus     IN @gr_uuidstatus AND
                (lv_query)
        INTO TABLE @DATA(lt_data).

        IF   lt_data IS NOT INITIAL.
          SELECT DISTINCT
             zeinv_tb_taxcode~taxcode,
             zeinv_tb_taxcode~einvoicetax  AS value
          FROM zeinv_tb_taxcode
          ORDER BY  zeinv_tb_taxcode~taxcode
          INTO TABLE @DATA(lt_taxcode).

          SELECT resg~supplierinvoice,
                 resg~fiscalyear,
                 resg~documentcurrency,
                SUM( resg~supplierinvoiceitemamount ) AS amount
          FROM  i_suplrinvcitempurordrefapi01 AS resg
          INNER JOIN @lt_data AS lt_data
                              ON lt_data~documentnumber  = resg~supplierinvoice
                             AND lt_data~fiscalyear      = resg~fiscalyear
          GROUP BY resg~supplierinvoice, resg~fiscalyear, resg~documentcurrency
          ORDER BY resg~supplierinvoice, resg~fiscalyear, resg~documentcurrency
          INTO TABLE @DATA(lt_amount).

          SELECT DISTINCT od~referencesddocument,
                          od~deliverydocument
          FROM i_deliverydocumentitem AS od
          FOR ALL ENTRIES IN @lt_data
          WHERE od~referencesddocumentitem = '000010'
            AND od~referencesddocument     = @lt_data-purchaseorder
          INTO TABLE @DATA(lt_od).
          IF sy-subrc = 0.
            SORT lt_od BY referencesddocument.
          ENDIF.


          SELECT DISTINCT i_operationalacctgdocitem~companycode,
                 i_operationalacctgdocitem~accountingdocument,
                 i_operationalacctgdocitem~fiscalyear,
                 i_operationalacctgdocitem~accountingdocumentitem,
                 CASE WHEN i_operationalacctgdocitem~paymentmethod <> ' '
                      THEN i_operationalacctgdocitem~paymentmethod
                      ELSE 'C'
                 END AS paymentmethod,
                 CASE WHEN i_operationalacctgdocitem~paymentmethod <> ' '
                      THEN i_payment~paymentmethodname
                      ELSE 'TM/CK'
                 END AS paymentmethodname
         FROM i_operationalacctgdocitem
         INNER JOIN i_paymentmethod AS i_payment
                                    ON i_payment~paymentmethod = i_operationalacctgdocitem~paymentmethod
         INNER JOIN @lt_data AS lt_data
                             ON  i_operationalacctgdocitem~companycode        = lt_data~companycode
                             AND i_operationalacctgdocitem~accountingdocument = lt_data~accountingdocument
                             AND i_operationalacctgdocitem~fiscalyear         = lt_data~fiscalyear
        WHERE i_operationalacctgdocitem~paymentmethod IS NOT INITIAL
        INTO TABLE @DATA(lt_payment).
          IF sy-subrc = 0.
            SORT lt_payment BY companycode accountingdocument fiscalyear.
          ENDIF.

          SELECT
              profile~accountingdocument,
              profile~fiscalyear,
              profile~companycode,
              profile~account,
              profile~financialaccounttype,
              profile~accountnname,
              profile~accountaddress,
              profile~accountbusinesspartnergroup,
              profile~accounttaxnumber,
              profile~paymentmethod,
              i_paymentmethod~paymentmethodname,
               CASE WHEN but000~organizationbpname2 IS  INITIAL
                    AND but000~organizationbpname3 IS  INITIAL
                    AND but000~organizationbpname4 IS  INITIAL
                   THEN but000~organizationbpname1
                     ELSE concat_with_space( but000~organizationbpname2,
                          concat_with_space( but000~organizationbpname3, but000~organizationbpname4 , 1 ) , 1 ) END  AS tdv
          FROM zcore_i_profile_fidoc AS profile
          INNER JOIN @lt_data AS data ON data~accountingdocument = profile~accountingdocument
                                     AND data~fiscalyear = profile~fiscalyear
                                     AND data~companycode = profile~companycode
          LEFT JOIN i_paymentmethod ON i_paymentmethod~paymentmethod = profile~paymentmethod
           LEFT JOIN i_businesspartner AS but000 ON but000~businesspartner = profile~account
          ORDER BY  profile~accountingdocument,
                    profile~fiscalyear,
                    profile~companycode
          INTO TABLE @DATA(lt_account).

          DATA: ls_data   TYPE zeinv_i_hoadon,
                lw_tt     TYPE zde_fis_wsl,
                lw_cvtext TYPE zde_fis_wsl.


          LOOP AT lt_data REFERENCE INTO DATA(ls_temp).

            ls_data = CORRESPONDING #( ls_temp->* ).
            ls_data-loaihoadon = p_loaihoadon.
            ls_data-sothamkhao = |{ ls_temp->accountingdocument }{ ls_temp->fiscalyear }{ ls_temp->companycode }|.

            READ TABLE lt_amount INTO DATA(ls_amount) WITH KEY supplierinvoice = ls_temp->documentnumber BINARY SEARCH.
            IF sy-subrc = 0.
              ls_data-amountbeforetax = ls_amount-amount.
            ENDIF.

            READ TABLE lt_taxcode REFERENCE INTO DATA(ls_taxcode)
            WITH KEY taxcode = ls_temp->taxcode .
            IF sy-subrc = 0.
              "TaxCode
              IF ls_temp->taxcode = 'IK'  OR ls_temp->taxcode = 'NA'
               OR ls_temp->taxcode = 'NK' OR ls_temp->taxcode = 'NO' OR ls_temp->taxcode = 'NX'.
                lw_tax = 0.
              ELSE.
                lw_tax  =  ls_taxcode->value.
              ENDIF.
              IF  ls_temp->transactioncurrency = 'VND'.

                ls_data-taxamount      = ls_data-amountbeforetax * ( lw_tax / 100 ).
                ls_data-amountaftertax = ls_data-amountbeforetax + ls_data-taxamount.
                lw_cvtext              = ls_data-amountaftertax * 100.
                ls_data-amountinwords  =  zcore_cl_amount_in_words=>read_amount( i_amount = lw_cvtext  i_waers = ls_temp->transactioncurrency i_lang = 'VI'  ).
              ELSEIF ls_temp->transactioncurrency = 'USD'.
                ls_data-taxamount      = ls_data-amountbeforetax * ( lw_tax / 100 ) .
                ls_data-amountaftertax = ls_data-amountbeforetax + ls_data-taxamount.
                lw_cvtext              = ls_data-amountaftertax.
                ls_data-amountinwords  =  zcore_cl_amount_in_words=>read_amount( i_amount = lw_cvtext  i_waers = ls_temp->transactioncurrency i_lang = 'VI'  ).
              ENDIF.
            ENDIF.

            ls_data-invoicedate = cl_abap_context_info=>get_system_date(  ).

            "tên đơn vị - người mua hàng

            READ TABLE lt_account REFERENCE INTO DATA(ls_account)
            WITH KEY accountingdocument = ls_temp->accountingdocument
                     fiscalyear         = ls_temp->fiscalyear
                     companycode        = ls_temp->companycode        BINARY SEARCH.
            IF sy-subrc = 0.
              ls_data-tendonvi     = ls_account->tdv.
              ls_data-vendor       = ls_account->account.
              ls_data-buyeraddress = ls_account->accountaddress.
              ls_data-buyervatnumber = ls_account->accounttaxnumber.
              ls_data-paymentmethod = ls_account->paymentmethod.
              ls_data-paymentmethodname = ls_account->paymentmethodname.
              IF ls_account->financialaccounttype = 'D'.
                ls_data-shippingaddress = ls_data-buyeraddress.
              ENDIF.
            ENDIF.

            IF ls_data-buyervatnumber IS NOT INITIAL.
              SPLIT ls_data-buyervatnumber AT '/' INTO FINAL(lv_text1) FINAL(lv_text2).
              ls_data-buyervatnumber = lv_text1.
            ENDIF.

*            ///////////////////OD////////////////
            DATA(lv_index) = 0.
            LOOP AT lt_od INTO DATA(ls_od) WHERE referencesddocument = ls_temp->purchaseorder.
              lv_index += 1.
              IF lv_index = 1.
                ls_data-referencesddocument = |{ ls_od-deliverydocument ALPHA = OUT }|.
              ELSE.
                DATA(lw_od) = |{ ls_od-deliverydocument ALPHA = OUT }|.
                CONCATENATE ls_data-referencesddocument lw_od INTO ls_data-referencesddocument SEPARATED BY ','.
              ENDIF.
            ENDLOOP.

            "Payment Method
            READ TABLE lt_payment INTO DATA(ls_payment) WITH KEY companycode = ls_data-companycode
                                                                 accountingdocument = ls_data-accountingdocument
                                                                 fiscalyear         = ls_data-fiscalyear BINARY SEARCH.
            IF sy-subrc = 0.
              ls_data-paymentmethod     = ls_payment-paymentmethod.
              ls_data-paymentmethodname = ls_payment-paymentmethodname.
            ELSE.
              ls_data-paymentmethod     = 'C'.
              ls_data-paymentmethodname = 'TM/CK'.
            ENDIF.
            APPEND ls_data TO gt_data.

          ENDLOOP.
          DELETE ADJACENT DUPLICATES FROM gt_data COMPARING documentnumber.
        ENDIF.

        """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        "Get data drafted
        DATA: lt_drafted LIKE gt_data.
        lt_drafted = get_data_drafed( ).
        APPEND LINES OF lt_drafted TO gt_data.
    ENDCASE.
  ENDMETHOD.


  METHOD if_rap_query_provider~select.
    IF io_request->is_data_requested( ).

      DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
      DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
      DATA(lv_max_rows) = COND #( WHEN lv_top = if_rap_query_paging=>page_size_unlimited THEN 0 ELSE lv_top ).
      TRY.
          DATA(lt_clause)        = io_request->get_filter( )->get_as_ranges( ).
        CATCH cx_rap_query_filter_no_range.
          "handle exception
      ENDTRY.
      DATA(lt_parameter)     = io_request->get_parameters( ).
      DATA(lt_fields)        = io_request->get_requested_elements( ).
      DATA(lt_sort)          = io_request->get_sort_elements( ).
      DATA(lt_aggregation) = io_request->get_aggregation(  ).
      DATA(lt_aggregation_element) = io_request->get_aggregation( )->get_aggregated_elements( ).
      DATA(lt_aggregation_group) = io_request->get_aggregation( )->get_grouped_elements( ).
      TRY.
          DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
        CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
      ENDTRY.
*--->Filter
      LOOP AT lt_filter_cond REFERENCE INTO DATA(ls_filter_cond).
        CASE ls_filter_cond->name.
          WHEN 'COMPANYCODE'.
            gr_companycode = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'FISCALYEAR'.
            gr_fiscalyear = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'SOURCETYPE'.
            READ TABLE ls_filter_cond->range[] INDEX 1 INTO DATA(ls_range).
            IF sy-subrc = 0.
              p_sourcetype = ls_range-low.
            ENDIF.
          WHEN 'ACCOUNTINGDOCUMENT'.
            gr_belnr = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'DOCUMENTDATE'.
            gr_bldat = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'POSTINGDATE'.
            gr_budat = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'CREATEDBY'.
            gr_usnam = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'BILLINGDOCUMENT'.
            gr_vbeln = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'BILLINGDOCUMENTTYPE'.
            gr_fkart = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'CUSTOMER'.
            gr_kunnr = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'SALESOFFICE'.
            gr_vkbur = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'SALESGROUP'.
            gr_vkgrp = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'PURCHASEORDER'.
            gr_ebeln = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'ENTRYDATE'.
            gr_aedat = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'SUPPLIER'.
            gr_lifnr      = CORRESPONDING #( ls_filter_cond->range[] ).
          WHEN 'BILLINGALTUNIT'.
            READ TABLE ls_filter_cond->range[] INDEX 1 INTO ls_range.
            IF sy-subrc = 0.
              p_billingaltunit = ls_range-low.
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
              p_loaihoadon =  ls_range-low.
            ENDIF.
          WHEN 'DISPNSX'.
            p_dispnsx = ls_filter_cond->range[ 1 ]-low.
          WHEN 'DISPVALUEDV'.
            p_dispvaluedv = ls_filter_cond->range[ 1 ]-low.
          WHEN 'NUMBERFORMATTYPE'.
            p_numformattype = ls_filter_cond->range[ 1 ]-low.
          WHEN 'ZPATTERN'.
            p_pattern = ls_filter_cond->range[ 1 ]-low.
          WHEN 'ZSERIAL'.
            p_serial = ls_filter_cond->range[ 1 ]-low.
          WHEN 'XUATHOADONHEADOFFICE'.
            p_headoffice = ls_filter_cond->range[ 1 ]-low.
          WHEN 'LOAINGHIEPVUDIEUCHINH'.
            p_loainvdc = ls_filter_cond->range[ 1 ]-low.
          WHEN 'FORMATNUMBER'.
            p_formatnumber = ls_filter_cond->range[ 1 ]-low.
          WHEN 'UUIDSTATUS'.
            gr_uuidstatus = CORRESPONDING #( ls_filter_cond->range[] ).
        ENDCASE.
      ENDLOOP.

*---->Sort
      DATA: lv_sort TYPE string.
      LOOP AT lt_sort REFERENCE INTO DATA(ls_sort).
        IF   lv_sort IS INITIAL.
          lv_sort = |{ ls_sort->element_name } { COND #( WHEN ls_sort->descending = 'X' THEN 'descending' ELSE 'ascending' ) } |.
        ELSE.
          lv_sort = |{ ls_sort->element_name } { COND #( WHEN ls_sort->descending = 'X' THEN 'descending' ELSE 'ascending' ) } |.
        ENDIF.
      ENDLOOP.

*----->Process
      CASE p_sourcetype.
        WHEN 'BILL'.
          get_billing(  ).
        WHEN 'PO'.
          get_po(  ).
        WHEN 'FI'.
          get_fi(  ).
      ENDCASE.

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
        IF p_loaihoadon <> zeinv_if_constants=>view AND p_loaihoadon <>  zeinv_if_constants=>canc.
          ls_data->uuid = |{ ls_data->sourcetype }@{ ls_data->sothamkhao }@{ sy-sysid }|.
        ENDIF.

        IF ls_data->billingmove IS NOT INITIAL.
          ls_data->billingmove = |{ ls_data->billingmove ALPHA = IN  }|.
          ls_data->uuid = |{ ls_data->sourcetype }@{ ls_data->billingmove }@{ sy-sysid }|.
        ENDIF.
        ls_data->invoicedatetext = ls_data->invoicedate.
        IF ls_data->billingdocument = '0090000119'.
          ls_data->uuid = |269421001C24TTN486111345|.
        ELSEIF ls_data->billingdocument = '0090000187'.
          ls_data->uuid = '269421001C24TTN516392617'.
        ELSEIF ls_data->billingdocument = '0090000206'.
          ls_data->uuid = '269421001C25TTN4742100'.
        ELSEIF ls_data->billingdocument = '0090000207'.
          ls_data->uuid = '269421001C25TTN3165025'.
        ELSEIF ls_data->billingdocument = '0090000371'.
          ls_data->uuid = '269421001C25TTN81805218'.
        ENDIF.

        CASE p_loaihoadon.
          WHEN zeinv_if_constants=>norm OR zeinv_if_constants=>rep OR zeinv_if_constants=>adj.
            ls_data->visibilitypublishaction = abap_true.
          WHEN zeinv_if_constants=>canc.
            ls_data->visibilitycancelaction = abap_true.
          WHEN zeinv_if_constants=>view.
            ls_data->visibilityviewaction = abap_true.
        ENDCASE.

        CASE ls_data->uuidstatus.
          WHEN zeinv_if_constants=>status_published.
            ls_data->uuidstatuscritical = zeinv_if_constants=>icon_published.
          WHEN zeinv_if_constants=>status_cancelled.
            ls_data->uuidstatuscritical = zeinv_if_constants=>icon_cancelled.
          WHEN zeinv_if_constants=>status_drafted.
            ls_data->uuidstatuscritical = zeinv_if_constants=>icon_not_processed.
          WHEN OTHERS.
            ls_data->uuidstatuscritical = zeinv_if_constants=>icon_not_processed.
            ls_data->uuidstatusname = 'Chưa phát hành'.
        ENDCASE.
        IF ls_data->check_thaythe_dieuchinh EQ '1'.
          ls_data->uuidstatuscritical  = zeinv_if_constants=>icon_cancelled.
          ls_data->uuidstatusname      = 'Đã điều chỉnh'.
        ELSEIF ls_data->check_thaythe_dieuchinh EQ '2'.
          ls_data->uuidstatuscritical  = zeinv_if_constants=>icon_cancelled.
          ls_data->uuidstatusname      = 'Đã thay thế'.
        ENDIF.

        ls_data->numberformattype = p_numformattype.
        ls_data->dispnsx = p_dispnsx.
        ls_data->dispvaluedv = p_dispvaluedv.
        APPEND ls_data->* TO lt_responseout.
      ENDLOOP.
      DATA(lt_sort_2) = CORRESPONDING abap_sortorder_tab( lt_sort MAPPING name = element_name ).
      SORT lt_responseout BY (lt_sort_2).
      io_response->set_total_number_of_records( lines( gt_data ) ).
      io_response->set_data( lt_responseout ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
