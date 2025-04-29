CLASS zeinv_cl_pxkvcnb DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.

  PRIVATE SECTION.
    " general
    DATA p_sourcetype TYPE zeinv_sourcetype.
    DATA:
      gr_vstel          TYPE RANGE OF i_deliverydocument-shippingpoint,
      gr_lfart          TYPE RANGE OF i_deliverydocument-deliverydocumenttype,
      gr_vbeln_vl       TYPE RANGE OF i_deliverydocument-deliverydocument,
      gr_vbeln_va       TYPE RANGE OF i_deliverydocumentitem-referencesddocument,
      gr_mblnr          TYPE RANGE OF mblnr,
      gr_ebeln          TYPE RANGE OF ebeln,
      gr_werks          TYPE RANGE OF werks_d,
      gr_bldat          TYPE RANGE OF sy-datum,
      gr_crdat          TYPE RANGE OF sy-datum,
      gr_usname         TYPE RANGE OF usnam,
      p_loaihoadon      TYPE string,

      gr_od_it          TYPE RANGE OF i_deliverydocumentitem-deliverydocumentitem,
      gr_mblnr_it       TYPE RANGE OF i_materialdocumentitem_2-materialdocumentitem,

      p_allmatdocdetail TYPE abap_boolean,
      p_matdocgeneral   TYPE abap_boolean.

    DATA:
      gt_header TYPE TABLE OF zeinv_i_pxkvcnb,
      gt_item   TYPE TABLE OF zeinv_i_pxkvcnb_item.

    METHODS get_parameters IMPORTING io_request TYPE REF TO if_rap_query_request.
    METHODS get_data_header.
    METHODS get_data_item.
    METHODS get_matdoc.
    METHODS get_matdoc_item.
    METHODS get_data_header_z13.
ENDCLASS.



CLASS ZEINV_CL_PXKVCNB IMPLEMENTATION.


  METHOD get_data_header.
    DATA lv_query TYPE string.

    CASE p_loaihoadon.
      WHEN zeinv_if_constants=>canc.
        lv_query = '( zeinv_tb_pxk~uuidstatus = @zeinv_if_constants=>status_published )'.
      WHEN zeinv_if_constants=>norm.
        lv_query = '( zeinv_tb_pxk~uuidstatus <> @zeinv_if_constants=>status_published or zeinv_tb_pxk~uuidstatus is null )'.
      WHEN zeinv_if_constants=>view.
        lv_query = '( zeinv_tb_pxk~uuid is not null and ( zeinv_tb_pxk~uuidstatus = @zeinv_if_constants=>status_published or zeinv_tb_pxk~uuidstatus = @zeinv_if_constants=>status_cancelled ) )'.
    ENDCASE.

    SELECT DISTINCT @p_sourcetype                                                  AS sourcetype,
                    @p_allmatdocdetail                                             AS allmatdocdetail,
                    @p_matdocgeneral                                               AS matdocgeneral,
                    likp~deliverydocument                                          AS lenhdcnb,
                    likp~deliverydocument,
                    lips~plant,
                    lips~purchaseorder,
                    lips~referencesddocument,
                    likp~shippingpoint,
                    likp~actualgoodsmovementdate,
                    likp~deliverydocumenttype,
                    likp~creationdate,
                    likp~createdbyuser,
                    lips~plant                                                     AS issuingplant,
                    lips~transactioncurrency                                       AS currency,
                    lips~\_plant-plantname                                         AS issuingplantname,
                    likp~actualgoodsmovementdate                                   AS purchaseorderdate,
                    lips~\_referencesddocument-purchaseorderbycustomer             AS hopdongso,
*                    i_purchaseorderapi01~supplyingplant AS receivingplant,
*                    i_purchaseorderapi01~purchaseorderdate,
*                    receivingplant~plantname AS receivingplantname,
                    zeinv_i_config~zserial,
                    zeinv_i_config~zpattern,
                    zeinv_tb_pxk~uuidstatus,
                    zeinv_status~uuidstatustext                                    AS uuidstatusname,
                    zeinv_tb_pxk~materialdocument                                  AS originmatdoc,
                    zeinv_tb_pxk~materialdocumentyear                              AS originmatdocyear,
                    zeinv_tb_pxk~einvoiceno,
                    zeinv_tb_pxk~einvoiceno_long,
                    likp~\_shippingpoint\_text[ language = 'E' ]-shippingpointname,
                    ztb_ttvc~deliveryname                                          AS shippingagent,
*                    ztb_ttvc~deliverytransport AS shippingvehicle,
                    concat(
                    concat_with_space( 'Cont/Seal:', ztb_ttvc~contno, 1 ),
                    concat( '/' ,ztb_ttvc~sealno ) )                               AS shippingvehicle,
                    likp~soldtoparty                                               AS customer,

*                    _shiptoparty~fulladdress   AS receivingplantname,
                    likp~yy1_port2_dlh                                             AS receivingplant,
                    _receivingplant~description                                    AS receivingplantname,
                    _diachikhonhan~port_address                                    AS receivingaddress
      FROM i_deliverydocument                  AS likp
           INNER JOIN i_deliverydocumentitem   AS lips
             ON likp~deliverydocument = lips~deliverydocument
           INNER JOIN i_materialdocumentitem_2 AS matdoc
             ON matdoc~deliverydocument = likp~deliverydocument
           LEFT JOIN zeinv_tb_pxk             ON zeinv_tb_pxk~deliverydocument = likp~deliverydocument
           LEFT JOIN zeinv_i_config             ON  zeinv_i_config~type        = '2'
                                                AND zeinv_i_config~sourcetype  = 'BILL'
                                                AND zeinv_i_config~validfrom  <= @sy-datum
                                                AND zeinv_i_config~validto    >= @sy-datum
                                                AND lips~plant                 = zeinv_i_config~plant
           LEFT JOIN zeinv_i_status            AS zeinv_status
             ON zeinv_status~uuidstatus = zeinv_tb_pxk~uuidstatus
           LEFT JOIN zcore_i_profile_customer  AS _shiptoparty
             ON _shiptoparty~customer = likp~shiptoparty
           LEFT JOIN i_customfieldcodelisttext AS _receivingplant
             ON  _receivingplant~customfieldid = 'YY1_PORT2'
             AND _receivingplant~code          = likp~yy1_port2_dlh
           LEFT JOIN ztb_einv_pxkk_cf          AS _diachikhonhan
             ON _diachikhonhan~port = likp~yy1_port2_dlh
           LEFT JOIN ztb_lxh_ttvc              AS ztb_ttvc
             ON  ztb_ttvc~mjahr = matdoc~materialdocumentyear
             AND ztb_ttvc~mblnr = matdoc~materialdocument
      WHERE lips~distributionchannel IN ( '10', '11' )
        AND likp~shippingpoint       IN @gr_vstel
        AND likp~deliverydocument    IN @gr_vbeln_vl
        AND lips~referencesddocument IN @gr_vbeln_va
        AND likp~documentdate        IN @gr_bldat
        AND likp~creationdate        IN @gr_crdat
        AND likp~createdbyuser       IN @gr_usname
        AND likp~deliverydocumenttype IN @gr_lfart
        AND matdoc~goodsmovementtype  IN ( '687', 'Z12', 'Z02' )
        AND ztb_ttvc~nopxkkvcnb IS INITIAL
        AND (lv_query)
      INTO TABLE @DATA(lt_likp).

    SELECT DISTINCT @p_sourcetype                                                  AS sourcetype,
              @p_allmatdocdetail                                             AS allmatdocdetail,
              @p_matdocgeneral                                               AS matdocgeneral,
              likp~deliverydocument                                          AS lenhdcnb,
              likp~deliverydocument,
              lips~plant,
              lips~purchaseorder,
              lips~referencesddocument,
              likp~shippingpoint,
              likp~actualgoodsmovementdate,
              likp~deliverydocumenttype,
              likp~creationdate,
              likp~createdbyuser,
              lips~plant                                                     AS issuingplant,
              lips~transactioncurrency                                       AS currency,
              lips~\_plant-plantname                                         AS issuingplantname,
              likp~actualgoodsmovementdate                                   AS purchaseorderdate,
              lips~\_referencesddocument-purchaseorderbycustomer             AS hopdongso,
              zeinv_i_config~zserial,
              zeinv_i_config~zpattern,
              zeinv_tb_pxk~uuidstatus,
              zeinv_status~uuidstatustext                                    AS uuidstatusname,
              zeinv_tb_pxk~materialdocument                                  AS originmatdoc,
              zeinv_tb_pxk~materialdocumentyear                              AS originmatdocyear,
              zeinv_tb_pxk~einvoiceno,
              zeinv_tb_pxk~einvoiceno_long,
              likp~\_shippingpoint\_text[ language = 'E' ]-shippingpointname,
              ztb_ttvc~deliveryname                                          AS shippingagent,
              concat(
              concat_with_space( 'Cont/Seal:', ztb_ttvc~contno, 1 ),
              concat( '/' ,ztb_ttvc~sealno ) )                               AS shippingvehicle,
              likp~soldtoparty                                               AS customer,
              likp~yy1_port2_dlh                                             AS receivingplant,
              _receivingplant~description                                    AS receivingplantname,
              _diachikhonhan~port_address                                    AS receivingaddress
FROM i_deliverydocument                  AS likp
     INNER JOIN i_deliverydocumentitem   AS lips
       ON likp~deliverydocument = lips~deliverydocument
     INNER JOIN i_materialdocumentitem_2 AS matdoc
       ON matdoc~deliverydocument = likp~deliverydocument
     LEFT JOIN zeinv_tb_pxk             ON zeinv_tb_pxk~deliverydocument = likp~deliverydocument
     LEFT JOIN zeinv_i_config             ON  zeinv_i_config~type        = '2'
                                          AND zeinv_i_config~sourcetype  = 'BILL'
                                          AND zeinv_i_config~validfrom  <= @sy-datum
                                          AND zeinv_i_config~validto    >= @sy-datum
                                          AND lips~plant                 = zeinv_i_config~plant
     LEFT JOIN zeinv_i_status            AS zeinv_status
       ON zeinv_status~uuidstatus = zeinv_tb_pxk~uuidstatus
     LEFT JOIN zcore_i_profile_customer  AS _shiptoparty
       ON _shiptoparty~customer = likp~shiptoparty
     LEFT JOIN i_customfieldcodelisttext AS _receivingplant
       ON  _receivingplant~customfieldid = 'YY1_PORT2'
       AND _receivingplant~code          = likp~yy1_port2_dlh
     LEFT JOIN ztb_einv_pxkk_cf          AS _diachikhonhan
       ON _diachikhonhan~port = likp~yy1_port2_dlh
     LEFT JOIN ztb_lxh_ttvc              AS ztb_ttvc
       ON  ztb_ttvc~mjahr = matdoc~materialdocumentyear
       AND ztb_ttvc~mblnr = matdoc~materialdocument
WHERE likp~shippingpoint       IN @gr_vstel
  AND likp~deliverydocument    IN @gr_vbeln_vl
  AND lips~referencesddocument IN @gr_vbeln_va
  AND likp~documentdate        IN @gr_bldat
  AND likp~creationdate        IN @gr_crdat
  AND likp~createdbyuser       IN @gr_usname
  AND likp~deliverydocumenttype IN @gr_lfart
  AND likp~yy1_inpxkkvcnb_dlh IS NOT INITIAL
  AND matdoc~goodsmovementtype  IN ( '601' )
  AND ztb_ttvc~nopxkkvcnb IS INITIAL
  AND (lv_query)
APPENDING CORRESPONDING FIELDS OF TABLE @lt_likp.

    CASE p_loaihoadon.
      WHEN zeinv_if_constants=>norm.
        " Lay OD co matdoc PGI chua reverse
        SELECT DISTINCT likp~deliverydocument,
                        mkpf~materialdocument,
                        mkpf~materialdocumentyear,
                        mseg~companycodecurrency
          FROM i_materialdocumentheader_2          AS mkpf
               INNER JOIN i_materialdocumentitem_2 AS mseg
                 ON  mseg~materialdocument     = mkpf~materialdocument
                 AND mseg~materialdocumentyear = mkpf~materialdocumentyear
               INNER JOIN @lt_likp                 AS likp
                 ON likp~deliverydocument = mkpf~deliverydocument
          WHERE mseg~goodsmovementiscancelled = @abap_false
          ORDER BY likp~deliverydocument
          INTO TABLE @DATA(lt_matdoc).
      WHEN zeinv_if_constants=>canc.
        " Lay OD co matdoc PGI da reverse
        SELECT DISTINCT likp~deliverydocument,
                        likp~originmatdoc        AS materialdocument,
                        likp~originmatdocyear    AS materialdocumentyear,
                        mseg~companycodecurrency
          FROM @lt_likp                            AS likp
               INNER JOIN i_materialdocumentitem_2 AS mseg
                 ON  mseg~materialdocument     = likp~originmatdoc
                 AND mseg~materialdocumentyear = likp~originmatdocyear
          WHERE mseg~goodsmovementiscancelled = @abap_true
          ORDER BY likp~deliverydocument
          INTO TABLE @lt_matdoc.

      WHEN zeinv_if_constants=>view.
        SELECT DISTINCT likp~deliverydocument,
                        likp~originmatdoc     AS materialdocument,
                        likp~originmatdocyear AS materialdocumentyear
          FROM @lt_likp AS likp
          ORDER BY likp~deliverydocument
          INTO TABLE @lt_matdoc.
    ENDCASE.

    DATA(lt_od) = CORRESPONDING zcore_cl_get_long_text=>ty_outbound( lt_likp DISCARDING DUPLICATES ).
    " TODO: variable is assigned but never used (ABAP cleaner)
    FINAL(lt_od_text) = zcore_cl_get_long_text=>get_mul_ob_header_text( it_outbound = lt_od ).
    FREE lt_od.

    LOOP AT lt_likp REFERENCE INTO DATA(ls_likp).

      READ TABLE lt_matdoc REFERENCE INTO DATA(ls_matdoc)
           WITH KEY deliverydocument = ls_likp->deliverydocument BINARY SEARCH.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO gt_header REFERENCE INTO DATA(ls_header).

      ls_header->*                    = CORRESPONDING #( ls_likp->* ).

      ls_header->materialdocument     = ls_matdoc->materialdocument.
      ls_header->loaihoadon           = p_loaihoadon.
      ls_header->materialdocumentyear = ls_matdoc->materialdocumentyear.

      ls_header->uuid                 = |{ ls_header->sourcetype }@{ sy-sysid }@{ ls_likp->deliverydocument }@{ ls_header->materialdocument }|.
      IF ls_header->deliverydocument = '0080000000'.
        ls_header->uuid = '269426001C24NTN138818585'.
      ENDIF.
      ls_header->currency = ls_matdoc->companycodecurrency.

      CASE p_loaihoadon.
        WHEN zeinv_if_constants=>norm.
          ls_header->visibilitypublishaction = abap_true.
        WHEN zeinv_if_constants=>canc.
          ls_header->visibilitycancelaction = abap_true.
      ENDCASE.

      CASE ls_header->uuidstatus.
        WHEN zeinv_if_constants=>status_published.
          ls_header->uuidstatuscritical = zeinv_if_constants=>icon_published.
        WHEN zeinv_if_constants=>status_cancelled.
          ls_header->uuidstatuscritical = zeinv_if_constants=>icon_cancelled.
        WHEN zeinv_if_constants=>status_drafted.
          ls_header->uuidstatuscritical = zeinv_if_constants=>icon_not_processed.
        WHEN OTHERS.
          ls_header->uuidstatuscritical = zeinv_if_constants=>icon_not_processed.
          ls_header->uuidstatusname     = 'Chưa phát hành'.
      ENDCASE.

    ENDLOOP.
  ENDMETHOD.


  METHOD get_data_header_z13.
    DATA lv_query TYPE string.

    CASE p_loaihoadon.
      WHEN zeinv_if_constants=>canc.
        lv_query = '( zeinv_tb_pxk~uuidstatus = @zeinv_if_constants=>status_published )'.
      WHEN zeinv_if_constants=>norm.
        lv_query = '( zeinv_tb_pxk~uuidstatus <> @zeinv_if_constants=>status_published or zeinv_tb_pxk~uuidstatus is null )'.
      WHEN zeinv_if_constants=>view.
        lv_query = '( zeinv_tb_pxk~uuid is not null and ( zeinv_tb_pxk~uuidstatus = @zeinv_if_constants=>status_published or zeinv_tb_pxk~uuidstatus = @zeinv_if_constants=>status_cancelled ) )'.
    ENDCASE.

    SELECT DISTINCT @p_sourcetype                                                  AS sourcetype,
                    @p_allmatdocdetail                                             AS allmatdocdetail,
                    @p_matdocgeneral                                               AS matdocgeneral,
                    matdoc~materialdocument,
                    matdoc~plant,
                    likp~deliverydocument                                          AS lenhdcnb,
                    matdoc~documentdate                                            AS documentdate,
                    likp~deliverydocument,
                    lips~purchaseorder,
                    likp~shippingpoint,
                    likp~actualgoodsmovementdate,
                    likp~deliverydocumenttype,
                    likp~creationdate,
                    likp~createdbyuser,
                    lips~plant                                                     AS issuingplant,
                    lips~transactioncurrency                                       AS currency,
                    lips~\_plant-plantname                                         AS issuingplantname,
                    likp~actualgoodsmovementdate                                   AS purchaseorderdate,
                    zeinv_i_config~zserial,
                    zeinv_i_config~zpattern,
                    zeinv_tb_pxk~uuidstatus,
                    zeinv_status~uuidstatustext                                    AS uuidstatusname,
                    zeinv_tb_pxk~materialdocument                                  AS originmatdoc,
                    zeinv_tb_pxk~materialdocumentyear                              AS originmatdocyear,
                    zeinv_tb_pxk~einvoiceno,
                    zeinv_tb_pxk~einvoiceno_long,
                    likp~\_shippingpoint\_text[ language = 'E' ]-shippingpointname,

                    likp~soldtoparty                                               AS customer,

                    ztb_ttvc~deliveryname                                          AS shippingagent,
                    concat(
                    concat_with_space( 'Cont/Seal:', ztb_ttvc~contno, 1 ),
                    concat( '/' ,ztb_ttvc~sealno ) )                               AS shippingvehicle,
                    ztb_ttvc~deliverycontractno       AS referencesddocument,
                    ztb_ttvc~deliverycontractno       AS hopdongso,
                    likp~yy1_port2_dlh                                             AS receivingplant,
                    _receivingplant~description                                    AS receivingplantname,
                    _diachikhonhan~port_address                                    AS receivingaddress
      FROM i_deliverydocument                  AS likp
           INNER JOIN i_deliverydocumentitem   AS lips
             ON likp~deliverydocument = lips~deliverydocument
           INNER JOIN i_materialdocumentitem_2 AS matdoc
             ON matdoc~deliverydocument = likp~deliverydocument
           LEFT JOIN zeinv_tb_pxk             ON zeinv_tb_pxk~deliverydocument = likp~deliverydocument
           LEFT JOIN zeinv_i_config             ON  zeinv_i_config~type        = '2'
                                                AND zeinv_i_config~sourcetype  = 'BILL'
                                                AND zeinv_i_config~validfrom  <= @sy-datum
                                                AND zeinv_i_config~validto    >= @sy-datum
                                                AND lips~plant                 = zeinv_i_config~plant
           LEFT JOIN zeinv_i_status            AS zeinv_status
             ON zeinv_status~uuidstatus = zeinv_tb_pxk~uuidstatus
           LEFT JOIN zcore_i_profile_customer  AS _shiptoparty
             ON _shiptoparty~customer = likp~shiptoparty
           LEFT JOIN i_customfieldcodelisttext AS _receivingplant
             ON  _receivingplant~customfieldid = 'YY1_PORT2'
             AND _receivingplant~code          = likp~yy1_port2_dlh
           LEFT JOIN ztb_lxh_ttvc              AS ztb_ttvc
             ON  ztb_ttvc~mjahr = matdoc~materialdocumentyear
             AND ztb_ttvc~mblnr = matdoc~materialdocument
           LEFT JOIN ztb_einv_pxkk_cf          AS _diachikhonhan
             ON _diachikhonhan~port = likp~yy1_port2_dlh
      WHERE likp~shippingpoint       IN @gr_vstel
        AND likp~deliverydocument    IN @gr_vbeln_vl
        AND lips~referencesddocument IN @gr_vbeln_va
        AND likp~documentdate        IN @gr_bldat
        AND likp~creationdate        IN @gr_crdat
        AND likp~createdbyuser       IN @gr_usname
        AND likp~deliverydocumenttype IN @gr_lfart
        AND matdoc~goodsmovementtype  IN ( 'Z13' )
        AND ztb_ttvc~nopxkkvcnb IS INITIAL
        AND (lv_query)
      INTO TABLE @DATA(lt_likp).

    CASE p_loaihoadon.
      WHEN zeinv_if_constants=>norm.
        " Lay OD co matdoc PGI chua reverse
        SELECT DISTINCT likp~deliverydocument,
                        mkpf~materialdocument,
                        mkpf~materialdocumentyear,
                        mseg~companycodecurrency
          FROM i_materialdocumentheader_2          AS mkpf
               INNER JOIN i_materialdocumentitem_2 AS mseg
                 ON  mseg~materialdocument     = mkpf~materialdocument
                 AND mseg~materialdocumentyear = mkpf~materialdocumentyear
               INNER JOIN @lt_likp                 AS likp
                 ON likp~deliverydocument = mkpf~deliverydocument
          WHERE mseg~goodsmovementiscancelled = @abap_false
          ORDER BY likp~deliverydocument
          INTO TABLE @DATA(lt_matdoc).
      WHEN zeinv_if_constants=>canc.
        " Lay OD co matdoc PGI da reverse
        SELECT DISTINCT likp~deliverydocument,
                        likp~originmatdoc        AS materialdocument,
                        likp~originmatdocyear    AS materialdocumentyear,
                        mseg~companycodecurrency
          FROM @lt_likp                            AS likp
               INNER JOIN i_materialdocumentitem_2 AS mseg
                 ON  mseg~materialdocument     = likp~originmatdoc
                 AND mseg~materialdocumentyear = likp~originmatdocyear
          WHERE mseg~goodsmovementiscancelled = @abap_true
          ORDER BY likp~deliverydocument
          INTO TABLE @lt_matdoc.

      WHEN zeinv_if_constants=>view.
        SELECT DISTINCT likp~deliverydocument,
                        likp~originmatdoc     AS materialdocument,
                        likp~originmatdocyear AS materialdocumentyear
          FROM @lt_likp AS likp
          ORDER BY likp~deliverydocument
          INTO TABLE @lt_matdoc.
    ENDCASE.

    LOOP AT lt_likp REFERENCE INTO DATA(ls_likp).

      READ TABLE lt_matdoc REFERENCE INTO DATA(ls_matdoc)
           WITH KEY deliverydocument = ls_likp->deliverydocument BINARY SEARCH.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO gt_header REFERENCE INTO DATA(ls_header).

      ls_header->*                    = CORRESPONDING #( ls_likp->* ).

      ls_header->materialdocument     = ls_matdoc->materialdocument.
      ls_header->loaihoadon           = p_loaihoadon.
      ls_header->materialdocumentyear = ls_matdoc->materialdocumentyear.

      ls_header->uuid   = |{ ls_header->sourcetype }@{ sy-sysid }@{ ls_likp->deliverydocument }@{ ls_header->materialdocument }|.
      ls_header->currency = ls_matdoc->companycodecurrency.
      ls_header->veviec = |Xuất kiểm tra sản phẩm|.

      CASE p_loaihoadon.
        WHEN zeinv_if_constants=>norm.
          ls_header->visibilitypublishaction = abap_true.
        WHEN zeinv_if_constants=>canc.
          ls_header->visibilitycancelaction = abap_true.
      ENDCASE.

      CASE ls_header->uuidstatus.
        WHEN zeinv_if_constants=>status_published.
          ls_header->uuidstatuscritical = zeinv_if_constants=>icon_published.
        WHEN zeinv_if_constants=>status_cancelled.
          ls_header->uuidstatuscritical = zeinv_if_constants=>icon_cancelled.
        WHEN zeinv_if_constants=>status_drafted.
          ls_header->uuidstatuscritical = zeinv_if_constants=>icon_not_processed.
        WHEN OTHERS.
          ls_header->uuidstatuscritical = zeinv_if_constants=>icon_not_processed.
          ls_header->uuidstatusname     = 'Chưa phát hành'.
      ENDCASE.

    ENDLOOP.
  ENDMETHOD.


  METHOD get_data_item.
    DATA ls_item       LIKE LINE OF gt_item.
    DATA lt_item_chung TYPE HASHED TABLE OF zeinv_i_pxkvcnb_item WITH UNIQUE KEY deliverydocument product.

    "&-Batch Split
    SELECT @p_sourcetype                                      AS sourcetype,
           @p_allmatdocdetail                                 AS allmatdocdetail,
           @p_matdocgeneral                                   AS matdocgeneral,
           matdoc~materialdocument,
           matdoc~materialdocumentyear,
           matdoc~materialdocumentitem,
           matdoc~deliverydocument,
           CASE WHEN lips~higherlvlitmofbatspltitm = '000000'
                THEN matdoc~deliverydocumentitem
                ELSE lips~higherlvlitmofbatspltitm
           END                                                AS deliverydocumentitem,
           CASE WHEN lips~higherlvlitmofbatspltitm = '000000'
                THEN matdoc~deliverydocumentitem
                ELSE lips~higherlvlitmofbatspltitm
           END                                                AS itemforeinvoice,
           matdoc~material                                    AS product,
           matdoc~plant,
           lips~inventoryvaluationtype,
           lips~deliveryquantityunit,
           lips~purchaseorder,
           lips~baseunit,
           lips~deliverydocumentitemtext,
           lips~higherlvlitmofbatspltitm,
           lips~actualdeliveryquantity,
           lips~actualdeliveredqtyinbaseunit,
*           i_unitofmeasuretext~unitofmeasurename AS deliveryquantityunitname,
           i_unitofmeasuretext~unitofmeasure_e                AS deliveryquantityunitname,
           lips~deliverydocumentitemtext                      AS itemtext,
           mbew~currency
      FROM i_materialdocumentitem_2          AS matdoc
           INNER JOIN i_deliverydocument     AS likp
             ON likp~deliverydocument = matdoc~deliverydocument
           LEFT JOIN i_deliverydocumentitem  AS lips
             ON  lips~deliverydocument     = matdoc~deliverydocument
             AND lips~deliverydocumentitem = matdoc~deliverydocumentitem
           LEFT JOIN i_productvaluationbasic AS mbew
             ON  mbew~product       = lips~product
             AND mbew~valuationarea = lips~plant
             AND mbew~valuationtype = lips~inventoryvaluationtype
           LEFT JOIN i_unitofmeasuretext             ON  i_unitofmeasuretext~unitofmeasure = lips~deliveryquantityunit
                                                     AND i_unitofmeasuretext~language      = @sy-langu
      WHERE matdoc~materialdocumentparentline  = '000000'
        AND lips~deliverydocument             IN @gr_vbeln_vl
        AND lips~referencesddocument          IN @gr_vbeln_va
        AND matdoc~isautomaticallycreated     <> 'X'
        AND matdoc~goodsmovementtype          IN ( '687','601' )
        AND likp~shippingpoint                IN @gr_vstel
        AND likp~deliverydocument             IN @gr_vbeln_vl
        AND likp~documentdate                 IN @gr_bldat
        AND likp~creationdate                 IN @gr_crdat
        AND likp~createdbyuser                IN @gr_usname
        AND likp~deliverydocumenttype         IN @gr_lfart
        AND lips~plant IN @gr_werks
        AND lips~deliverydocumentitem         IN @gr_od_it
        AND matdoc~isautomaticallycreated     <> 'X'
      INTO TABLE @DATA(lt_lips).
    "&-Batch Split
    IF sy-subrc = 0.
      SELECT gt_matdoc~deliverydocument,
             gt_matdoc~higherlvlitmofbatspltitm,
             SUM( gt_matdoc~actualdeliveryquantity ) AS actualdeliveryquantity
        FROM @lt_lips AS gt_matdoc
        WHERE gt_matdoc~higherlvlitmofbatspltitm <> 0
        GROUP BY gt_matdoc~deliverydocument,
                 gt_matdoc~higherlvlitmofbatspltitm
        ORDER BY gt_matdoc~deliverydocument,
                 gt_matdoc~higherlvlitmofbatspltitm
        INTO TABLE @DATA(lt_sum).

      FINAL(lt_product) = CORRESPONDING zcore_cl_get_long_text=>ty_product( lt_lips DISCARDING DUPLICATES ).
      FINAL(lt_productsalestext) = zcore_cl_get_long_text=>get_multi_product_text( it_material = lt_product
                                                                                   what_get    = 'sales' ).

      SORT lt_lips BY deliverydocument
                      deliverydocumentitem.
      DELETE ADJACENT DUPLICATES FROM lt_lips COMPARING deliverydocument deliverydocumentitem.

      LOOP AT lt_lips REFERENCE INTO DATA(ls_lips).

*        APPEND INITIAL LINE TO gt_item REFERENCE INTO DATA(ls_item).
        ls_item = CORRESPONDING #( ls_lips->* ).

        READ TABLE lt_sum REFERENCE INTO DATA(lr_sum) WITH KEY deliverydocument         = ls_item-deliverydocument
                                                               higherlvlitmofbatspltitm = ls_item-deliverydocumentitem BINARY SEARCH.
        IF sy-subrc = 0.
          ls_item-actualdeliveryquantity = lr_sum->actualdeliveryquantity.
        ENDIF.
        ls_item-loaihoadon         = p_loaihoadon.
        ls_item-itemforeinvoice    = sy-tabix.
        ls_item-goodtypeineinvoice = zeinv_if_constants=>line_good_service_78.
        ls_item-movingaverageprice = ls_item-amount / ls_item-actualdeliveryquantity.

        READ TABLE lt_productsalestext INTO FINAL(ls_productsalestext)
             WITH KEY product = ls_item-product.
        IF sy-subrc = 0 AND ls_productsalestext-long_text IS NOT INITIAL.
          ls_item-itemtext = ls_productsalestext-long_text.
        ENDIF.

        IF p_matdocgeneral = abap_true.
          READ TABLE lt_item_chung REFERENCE INTO DATA(ls_item_chung)
               WITH KEY deliverydocument = ls_item-deliverydocument
                        product          = ls_item-product.
          IF sy-subrc = 0.
            ls_item_chung->actualdeliveryquantity += ls_item-actualdeliveryquantity.
            ls_item_chung->amount                 += ls_item-amount.
          ELSE.
            INSERT ls_item INTO TABLE lt_item_chung.
          ENDIF.
        ELSE.
          APPEND ls_item TO gt_item.
          CLEAR ls_item.
        ENDIF.

      ENDLOOP.

      APPEND LINES OF lt_item_chung TO gt_item.
      CLEAR: lt_lips,
             lt_item_chung.
    ENDIF.
  ENDMETHOD.


  METHOD get_matdoc.
    DATA lv_query TYPE string.

    CASE p_loaihoadon.
      WHEN zeinv_if_constants=>canc.
        lv_query = `( zeinv_tb_pxk~uuidstatus = @zeinv_if_constants=>status_published and matdoc_it~GoodsMovementIsCancelled = 'X' )`.
      WHEN zeinv_if_constants=>norm.
        lv_query = '( zeinv_tb_pxk~uuidstatus <> @zeinv_if_constants=>status_published or zeinv_tb_pxk~uuidstatus is null )'.
      WHEN zeinv_if_constants=>view.
        lv_query = `( zeinv_tb_pxk~uuid is not null and ( zeinv_tb_pxk~uuidstatus = @zeinv_if_constants=>status_published or zeinv_tb_pxk~uuidstatus = @zeinv_if_constants=>status_cancelled ) AND matdoc_it~GoodsMovementIsCancelled <> 'X' )`.
    ENDCASE.

    SELECT DISTINCT @p_allmatdocdetail                AS allmatdocdetail,
                    @p_matdocgeneral                  AS matdocgeneral,
                    matdoc~materialdocument,
                    matdoc~plant,
                    matdoc~documentdate               AS documentdate,
                    matdoc~postingdate                AS actualgoodsmovementdate,
                    matdoc~createdbyuser              AS createdbyuser,
                    matdoc~postingdate                AS creationdate,
                    matdoc~materialdocumentyear,
                    matdoc_it~companycodecurrency     AS currency,
                    matdoc~postingdate                AS purchaseorderdate,
*                    matdoc_it~storagelocation AS issuingplant,
*                    matdoc_it~\_storagelocation-storagelocationname AS issuingplantname,
*                    matdoc_it~issuingorreceivingstorageloc AS receivingplant,
*                    matdoc_it~\_issuingorreceivingstorageloc-storagelocationname AS receivingplantname,
*                    matdoc_it~materialdocumentyear,
                    matdoc~materialdocument           AS lenhdcnb,
                    zeinv_i_config~zserial,
                    zeinv_i_config~zpattern,
                    zeinv_tb_pxk~uuidstatus,
                    zeinv_status~uuidstatustext       AS uuidstatusname,
                    zeinv_tb_pxk~materialdocument     AS originmatdoc,
                    zeinv_tb_pxk~materialdocumentyear AS originmatdocyear,
                    zeinv_tb_pxk~einvoiceno,
                    zeinv_tb_pxk~einvoiceno_long,
                    ztb_ttvc~deliveryname             AS shippingagent,
                    ztb_ttvc~transportno              AS shippingvehicle,
                    ztb_ttvc~deliverycontractno       AS referencesddocument,
                    ztb_ttvc~deliverycontractno       AS hopdongso
      FROM i_materialdocumentheader_2          AS matdoc
           INNER JOIN i_materialdocumentitem_2 AS matdoc_it
             ON matdoc_it~materialdocument = matdoc~materialdocument
           LEFT JOIN zeinv_tb_pxk             ON zeinv_tb_pxk~materialdocument = matdoc~materialdocument
           LEFT JOIN zeinv_i_config             ON  zeinv_i_config~type        = '2'
                                                AND zeinv_i_config~sourcetype  = 'MTD'
                                                AND zeinv_i_config~validfrom  <= @sy-datum
                                                AND zeinv_i_config~validto    >= @sy-datum
                                                AND matdoc~plant               = zeinv_i_config~plant
           LEFT JOIN zeinv_i_status            AS zeinv_status
             ON zeinv_status~uuidstatus = zeinv_tb_pxk~uuidstatus
           LEFT JOIN ztb_lxh_ttvc              AS ztb_ttvc
             ON  ztb_ttvc~mjahr = matdoc~materialdocumentyear
             AND ztb_ttvc~mblnr = matdoc~materialdocument
      WHERE matdoc_it~goodsmovementtype IN ( '541', '311', '313', 'Z99' )
        AND matdoc~materialdocument IN @gr_mblnr
        AND matdoc~documentdate     IN @gr_bldat
        AND matdoc~postingdate      IN @gr_crdat
        AND matdoc~createdbyuser    IN @gr_usname
        AND ztb_ttvc~nopxkkvcnb IS INITIAL
        AND (lv_query)
      INTO TABLE @DATA(lt_matdoc).
    IF sy-subrc = 0.

      SELECT DISTINCT matdoc~materialdocumentyear,
                      matdoc~materialdocument,
                      _supplier~fulladdress       AS receivingplantname
        FROM i_materialdocumentitem_2           AS matdoc
             INNER JOIN @lt_matdoc              AS lt_matdoc
               ON  lt_matdoc~materialdocument     = matdoc~materialdocument
               AND lt_matdoc~materialdocumentyear = matdoc~materialdocumentyear
             LEFT JOIN zcore_i_profile_supplier AS _supplier
               ON _supplier~supplier = matdoc~supplier
        WHERE matdoc~storagelocation IS NOT INITIAL
        INTO TABLE @DATA(lt_khonhan).
      IF sy-subrc = 0.
        SORT lt_khonhan BY materialdocument
                           materialdocumentyear.
      ENDIF.
      SELECT DISTINCT matdoc~materialdocumentyear,
                      matdoc~materialdocument,
                      matdoc~storagelocation                       AS issuingplant,
                      matdoc~\_storagelocation-storagelocationname AS issuingplantname
        FROM i_materialdocumentitem_2 AS matdoc
             INNER JOIN @lt_matdoc    AS lt_matdoc
               ON  lt_matdoc~materialdocument     = matdoc~materialdocument
               AND lt_matdoc~materialdocumentyear = matdoc~materialdocumentyear
        WHERE matdoc~isautomaticallycreated IS INITIAL
        INTO TABLE @DATA(lt_khoxuat).
      IF sy-subrc = 0.
        SORT lt_khoxuat BY materialdocument
                           materialdocumentyear.
      ENDIF.
      LOOP AT lt_matdoc REFERENCE INTO DATA(ls_matdoc).
        APPEND INITIAL LINE TO gt_header REFERENCE INTO DATA(ls_header).

        ls_header->* = CORRESPONDING #( ls_matdoc->* ).

        DATA(lv_index1) = 0.
        LOOP AT lt_khoxuat INTO FINAL(ls_khoxuat) WHERE     materialdocumentyear = ls_header->materialdocumentyear
                                                        AND materialdocument     = ls_header->materialdocument.
          lv_index1 += 1.
          IF lv_index1 = 1.
            ls_header->shippingpoint     = |{ ls_khoxuat-issuingplant }|.
            ls_header->shippingpointname = |{ ls_khoxuat-issuingplantname }|.
            ls_header->issuingplant      = |{ ls_khoxuat-issuingplant }|.
            ls_header->issuingplantname  = |{ ls_khoxuat-issuingplantname }|.
          ELSE.
            FINAL(lw_issuingplant)     = |{ ls_khoxuat-issuingplant }|.
            FINAL(lw_issuingplantname) = |{ ls_khoxuat-issuingplantname }|.
            CONCATENATE ls_header->shippingpoint     lw_issuingplant     INTO ls_header->shippingpoint     SEPARATED BY ','.
            CONCATENATE ls_header->shippingpointname lw_issuingplantname INTO ls_header->shippingpointname SEPARATED BY ','.

            CONCATENATE ls_header->issuingplant      lw_issuingplant     INTO ls_header->issuingplant      SEPARATED BY ','.
            CONCATENATE ls_header->issuingplantname  lw_issuingplantname INTO ls_header->issuingplantname  SEPARATED BY ','.

          ENDIF.
        ENDLOOP.

        lv_index1 = 0.
        LOOP AT lt_khonhan INTO FINAL(ls_khonhan) WHERE     materialdocumentyear = ls_header->materialdocumentyear
                                                        AND materialdocument     = ls_header->materialdocument.
          lv_index1 += 1.
          IF lv_index1 = 1.
            ls_header->receivingplantname = |{ ls_khonhan-receivingplantname }|.
            ls_header->receivingaddress   = |{ ls_khonhan-receivingplantname }|.
          ELSE.
            FINAL(lw_receivingplantname) = |{ ls_khonhan-receivingplantname }|.
            CONCATENATE ls_header->receivingplantname lw_receivingplantname INTO ls_header->receivingplantname SEPARATED BY ','.
          ENDIF.
        ENDLOOP.
        ls_header->loaihoadon           = p_loaihoadon.
        ls_header->uuid = |{ ls_header->sourcetype }@{ sy-sysid }@{ ls_header->materialdocument }|.
        CASE p_loaihoadon.
          WHEN zeinv_if_constants=>norm.
            ls_header->visibilitypublishaction = abap_true.
          WHEN zeinv_if_constants=>canc.
            ls_header->visibilitycancelaction = abap_true.
        ENDCASE.
        CASE ls_header->uuidstatus.
          WHEN zeinv_if_constants=>status_published.
            ls_header->uuidstatuscritical = zeinv_if_constants=>icon_published.
          WHEN zeinv_if_constants=>status_cancelled.
            ls_header->uuidstatuscritical = zeinv_if_constants=>icon_cancelled.
          WHEN zeinv_if_constants=>status_drafted.
            ls_header->uuidstatuscritical = zeinv_if_constants=>icon_not_processed.
          WHEN OTHERS.
            ls_header->uuidstatuscritical = zeinv_if_constants=>icon_not_processed.
            ls_header->uuidstatusname     = 'Chưa phát hành'.
        ENDCASE.
      ENDLOOP.
    ENDIF.

    get_data_header_z13( ).
  ENDMETHOD.


  METHOD get_matdoc_item.
    DATA ls_data       TYPE zeinv_i_pxkvcnb_item.
    DATA lt_item_chung TYPE HASHED TABLE OF zeinv_i_pxkvcnb_item WITH UNIQUE KEY materialdocument product.

    "&-Batch Split
    SELECT @p_sourcetype                                                AS sourcetype,
           @p_allmatdocdetail                                           AS allmatdocdetail,
           @p_matdocgeneral                                             AS matdocgeneral,
           matdoc~materialdocument,
           matdoc~materialdocumentyear,
           matdoc~materialdocumentitem,
           matdoc~deliverydocument,
           matdoc~plant,
           CASE WHEN matdoc~deliverydocument IS INITIAL
                THEN matdoc~materialdocumentitem
                ELSE CASE WHEN lips~higherlvlitmofbatspltitm = '000000'
                     THEN matdoc~deliverydocumentitem
                      ELSE lips~higherlvlitmofbatspltitm
                 END END                                                AS itemforeinvoice,
           CASE WHEN matdoc~deliverydocument IS INITIAL
                THEN ' '
                ELSE CASE WHEN lips~higherlvlitmofbatspltitm = '000000'
                     THEN matdoc~deliverydocumentitem
                     ELSE lips~higherlvlitmofbatspltitm
                END END                                                 AS deliverydocumentitem,
           matdoc~material                                              AS product,
           matdoc~documentdate                                          AS documentdate,
           matdoc~postingdate                                           AS actualgoodsmovementdate,
           matdoc_header~createdbyuser                                  AS createdbyuser,
           matdoc~postingdate                                           AS creationdate,
           matdoc~storagelocation                                       AS issuingplant,
           matdoc~\_storagelocation-storagelocationname                 AS issuingplantname,
           matdoc~issuingorreceivingstorageloc                          AS receivingplant,
           matdoc~\_issuingorreceivingstorageloc-storagelocationname    AS receivingplantname,
           matdoc~quantityinentryunit                                   AS actualdeliveryquantity,
           matdoc~entryunit                                             AS deliveryquantityunit,
           i_unitofmeasuretext~unitofmeasure_e                          AS deliveryquantityunitname,
           matdoc~totalgoodsmvtamtincccrcy                              AS amount,
           matdoc~companycodecurrency                                   AS currency,
           lips~higherlvlitmofbatspltitm

      FROM i_materialdocumentitem_2              AS matdoc
           INNER JOIN i_materialdocumentheader_2 AS matdoc_header
             ON matdoc_header~materialdocument = matdoc~materialdocument
           LEFT JOIN i_deliverydocument          AS likp
             ON likp~deliverydocument = matdoc~deliverydocument
           LEFT JOIN i_deliverydocumentitem      AS lips
             ON  lips~deliverydocument     = matdoc~deliverydocument
             AND lips~deliverydocumentitem = matdoc~deliverydocumentitem
           LEFT JOIN i_unitofmeasuretext             ON  i_unitofmeasuretext~unitofmeasure = matdoc~entryunit
                                                     AND i_unitofmeasuretext~language      = @sy-langu
           LEFT JOIN i_producttext               AS makt
             ON  makt~product  = matdoc~material
             AND makt~language = @sy-langu
      WHERE matdoc~materialdocumentparentline  = '000000'
        AND matdoc~materialdocument           IN @gr_mblnr
        AND matdoc~documentdate               IN @gr_bldat
        AND matdoc~postingdate                IN @gr_crdat
        AND matdoc_header~createdbyuser       IN @gr_usname
        AND matdoc~isautomaticallycreated     <> 'X'
        AND matdoc~materialdocumentitem       IN @gr_mblnr_it
      INTO TABLE @DATA(lt_matdoc).
    IF sy-subrc = 0.

      SELECT gt_matdoc~materialdocument,
             gt_matdoc~itemforeinvoice,
             SUM( gt_matdoc~actualdeliveryquantity ) AS actualdeliveryquantity
        FROM @lt_matdoc AS gt_matdoc
        WHERE gt_matdoc~higherlvlitmofbatspltitm <> 0
        GROUP BY gt_matdoc~materialdocument,
                 gt_matdoc~itemforeinvoice
        ORDER BY gt_matdoc~materialdocument,
                 gt_matdoc~itemforeinvoice
        INTO TABLE @DATA(lt_sum).

      FINAL(lt_matnr)           = CORRESPONDING zcore_cl_get_long_text=>ty_product( lt_matdoc DISCARDING DUPLICATES MAPPING product = product ).
      FINAL(lt_productsaletext) = zcore_cl_get_long_text=>get_multi_product_text( it_material = lt_matnr
                                                                                  what_get    = 'SALES'  ).

      SORT lt_matdoc BY materialdocument
                        itemforeinvoice.
      DELETE ADJACENT DUPLICATES FROM lt_matdoc COMPARING materialdocument itemforeinvoice.
      LOOP AT lt_matdoc REFERENCE INTO DATA(ls_temp).
        ls_data = CORRESPONDING #( ls_temp->* ).

        READ TABLE lt_sum REFERENCE INTO DATA(lr_sum) WITH KEY materialdocument = ls_temp->materialdocument
                                                               itemforeinvoice  = ls_temp->itemforeinvoice BINARY SEARCH.
        IF sy-subrc = 0.
          ls_data-actualdeliveryquantity = lr_sum->actualdeliveryquantity.
        ENDIF.

        READ TABLE lt_productsaletext INTO FINAL(ls_productsaletext)
             WITH KEY product = ls_data-product.
        IF sy-subrc = 0 AND ls_productsaletext-long_text IS NOT INITIAL.
          ls_data-itemtext = ls_productsaletext-long_text.
        ENDIF.
        ls_data-goodtypeineinvoice = '1'.

        IF p_matdocgeneral = abap_true.
          READ TABLE lt_item_chung REFERENCE INTO DATA(ls_item_chung)
               WITH KEY materialdocument = ls_data-materialdocument
                        product          = ls_data-product.
          IF sy-subrc = 0.
            ls_item_chung->actualdeliveryquantity += ls_data-actualdeliveryquantity.
            ls_item_chung->amount                 += ls_data-amount.
          ELSE.
            INSERT ls_data INTO TABLE lt_item_chung.
          ENDIF.
        ELSE.
          APPEND ls_data TO gt_item.
          CLEAR ls_data.
        ENDIF.
      ENDLOOP.

      APPEND LINES OF lt_item_chung TO gt_item.
      CLEAR: lt_matdoc,
             lt_item_chung.
    ENDIF.
  ENDMETHOD.


  METHOD get_parameters.
    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range.
    ENDTRY.
    LOOP AT lt_filter_cond REFERENCE INTO DATA(ls_filter_cond).
      CASE ls_filter_cond->name.
        WHEN 'SOURCETYPE'.
          READ TABLE ls_filter_cond->range[] INDEX 1 INTO DATA(ls_range).
          IF sy-subrc = 0.
            p_sourcetype = ls_range-low.
          ENDIF.
        WHEN 'DELIVERYDOCUMENT'.
          gr_vbeln_vl = CORRESPONDING #( ls_filter_cond->range[] ).
        WHEN 'REFERENCESDDOCUMENT'.
          gr_vbeln_va = CORRESPONDING #( ls_filter_cond->range[] ).
        WHEN 'SHIPPINGPOINT'.
          gr_vstel = CORRESPONDING #( ls_filter_cond->range[] ).
        WHEN 'DELIVERYDOCUMENTTYPE'.
          gr_lfart = CORRESPONDING #( ls_filter_cond->range[] ).
        WHEN 'CREATIONDATE'.
          gr_crdat = CORRESPONDING #( ls_filter_cond->range[] ).
        WHEN 'DOCUMENTDATE'.
          gr_bldat = CORRESPONDING #( ls_filter_cond->range[] ).
        WHEN 'CREATEDBYUSER'.
          gr_usname = CORRESPONDING #( ls_filter_cond->range[] ).
        WHEN 'PURCHASEORDER'.
          gr_ebeln =  CORRESPONDING #( ls_filter_cond->range[] ).
        WHEN 'PLANT'.
          gr_werks =  CORRESPONDING #( ls_filter_cond->range[] ).
        WHEN 'LOAIHOADON'.
          p_loaihoadon = ls_filter_cond->range[ 1 ]-low.
        WHEN 'MATERIALDOCUMENT'.
          gr_mblnr = CORRESPONDING #( ls_filter_cond->range[] ).

        WHEN 'ALLMATDOCDETAIL'.
          READ TABLE ls_filter_cond->range[] INDEX 1 INTO ls_range.
          IF sy-subrc = 0.
            p_allmatdocdetail = ls_range-low.
          ENDIF.
        WHEN 'MATDOCGENERAL'.
          READ TABLE ls_filter_cond->range[] INDEX 1 INTO ls_range.
          IF sy-subrc = 0.
            p_matdocgeneral = ls_range-low.
          ENDIF.

        WHEN 'DELIVERYDOCUMENTITEM'.
          gr_od_it = CORRESPONDING #( ls_filter_cond->range[] ).
        WHEN 'MATERIALDOCUMENTITEM'.
          gr_mblnr_it = CORRESPONDING #( ls_filter_cond->range[] ).

      ENDCASE.
    ENDLOOP.
  ENDMETHOD.


  METHOD if_rap_query_provider~select.
    " ---Fill data suitable for the params query

    DATA lv_defautl    TYPE string.
    DATA lt_header_out TYPE TABLE OF zeinv_i_pxkvcnb.
    DATA lt_item_out   TYPE TABLE OF zeinv_i_pxkvcnb_item.

    FINAL(lv_entity) = io_request->get_entity_id( ).
    FINAL(lv_top)  = io_request->get_paging( )->get_page_size( ).
    FINAL(lv_skip) = io_request->get_paging( )->get_offset( ).
    DATA(lv_max_rows) = COND #( WHEN lv_top = if_rap_query_paging=>page_size_unlimited
                                THEN 0
                                ELSE lv_top ).
    IF lv_max_rows = -1.
      lv_max_rows = 1.
    ENDIF.

    FINAL(lt_sort)          = io_request->get_sort_elements( ).
    FINAL(lt_sort_criteria) = VALUE string_table(
                                        FOR sort_element IN lt_sort
                                        ( sort_element-element_name && COND #( WHEN sort_element-descending = abap_true
                                                                               THEN ` descending`
                                                                               ELSE ` ascending` ) ) ).
    IF lv_entity = 'ZEINV_I_PXKVCNB'.
      lv_defautl = 'DeliveryDocument, Plant,MaterialDocument,MaterialDocumentYear, PurchaseOrder'.
    ELSE.
      lv_defautl = 'DeliveryDocument,DeliveryDocumentItem,MaterialDocument,MaterialDocumentItem,PurchaseOrder'.
    ENDIF.
    FINAL(lv_sort_string) = COND #( WHEN lt_sort_criteria IS INITIAL
                                    THEN lv_defautl
                                    ELSE concat_lines_of( table = lt_sort_criteria
                                                          sep   = `, ` ) ).

    DATA(lt_req_elements) = io_request->get_requested_elements( ).

    FINAL(lt_aggr_element) = io_request->get_aggregation( )->get_aggregated_elements( ).
    IF lt_aggr_element IS NOT INITIAL.
      LOOP AT lt_aggr_element ASSIGNING FIELD-SYMBOL(<fs_aggr_element>).
        DELETE lt_req_elements WHERE table_line = <fs_aggr_element>-result_element.
        FINAL(lv_aggregation) = |{ <fs_aggr_element>-aggregation_method }( { <fs_aggr_element>-input_element } ) as { <fs_aggr_element>-result_element }|.
        APPEND lv_aggregation TO lt_req_elements.
      ENDLOOP.
    ENDIF.

    FINAL(lv_req_elements) = concat_lines_of( table = lt_req_elements
                                              sep   = `, ` ).

    FINAL(lt_grouped_element) = io_request->get_aggregation( )->get_grouped_elements( ).
    FINAL(lv_grouping) = concat_lines_of( table = lt_grouped_element
                                          sep   = `, ` ).

    " ---Get data

    get_parameters( io_request ).
    CASE lv_entity.
      WHEN 'ZEINV_I_PXKVCNB'.
        " -------=Get header
        IF p_sourcetype = 'XBAN'.
          get_data_header( ).
        ELSE.
          get_matdoc( ).
        ENDIF.
        SELECT (lv_req_elements) FROM @gt_header AS data
          GROUP BY (lv_grouping)
          ORDER BY (lv_sort_string)
          INTO CORRESPONDING FIELDS OF TABLE @lt_header_out
        OFFSET @lv_skip
          UP TO @lv_max_rows ROWS.
        io_response->set_total_number_of_records( lines( gt_header ) ).
        io_response->set_data( lt_header_out ).
      WHEN 'ZEINV_I_PXKVCNB_ITEM'.
        " -------=Get item
        IF p_sourcetype = 'XBAN'.
          get_data_item( ).
        ELSE.
          get_matdoc_item( ).
        ENDIF.
        SELECT (lv_req_elements) FROM @gt_item AS data
          GROUP BY (lv_grouping)
          ORDER BY (lv_sort_string)
          INTO CORRESPONDING FIELDS OF TABLE @lt_item_out
        OFFSET @lv_skip
          UP TO @lv_max_rows ROWS.
        io_response->set_total_number_of_records( lines( gt_item ) ).
        io_response->set_data( lt_item_out ).
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
