CLASS zeinv_cl_vnpt_service_soap DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF msg_text,
             attr1 TYPE c LENGTH 40,
             attr2 TYPE c LENGTH 40,
             attr3 TYPE c LENGTH 40,
             attr4 TYPE c LENGTH 40,
           END OF msg_text.
    TYPES:
        result_code TYPE c LENGTH 10.
    DATA:
      g_auth                 TYPE zeinv_vnpt_auth,
      gv_type                TYPE zeinv_type,
      g_destination_publish  TYPE REF TO if_soap_destination,
      g_destination_portal   TYPE REF TO if_soap_destination,
      g_destination_business TYPE REF TO if_soap_destination.
    METHODS constructor IMPORTING i_auth TYPE zeinv_vnpt_auth
                                  i_type TYPE zeinv_type
                        RAISING   cx_http_dest_provider_error.

    METHODS import_inv_by_pattern IMPORTING input TYPE zeinv_import_inv_by_pattern_s1
                                            fkey  TYPE zeinv_fkey
                                  EXPORTING code  TYPE result_code
                                  RAISING   zeinv_cx_vnpt_service.
    METHODS delete_invoice_by_fkey IMPORTING input TYPE zeinv_delete_invoice_by_fkey_1
                                             fkey  TYPE zeinv_fkey
                                   EXPORTING code  TYPE result_code
                                   RAISING   zeinv_cx_vnpt_service.
    METHODS download_new_inv_pdffkey IMPORTING input             TYPE zeinv_download_new_inv_pdffke1
                                               fkey              TYPE zeinv_fkey
                                     EXPORTING code              TYPE result_code
                                     RETURNING VALUE(pdf_string) TYPE string
                                     RAISING   zeinv_cx_vnpt_service.

    METHODS download_inv_pdffkey_no_pay IMPORTING input             TYPE zeinv_download_inv_pdffkey_no1
                                                  fkey              TYPE zeinv_fkey
                                        EXPORTING code              TYPE result_code
                                        RETURNING VALUE(pdf_string) TYPE string
                                        RAISING   zeinv_cx_vnpt_service.

    METHODS publish_inv_fkey IMPORTING input      TYPE zeinv_publish_inv_fkey_soap_in
                                       fkey       TYPE zeinv_fkey
                             EXPORTING code       TYPE result_code
                                       einvoiceno TYPE zeinv_einvoiceno
                             RAISING   zeinv_cx_vnpt_service.

    METHODS gethash_inv_token IMPORTING input           TYPE zeinv_get_hash_inv_with_token1
                                        fkey            TYPE zeinv_fkey
                              EXPORTING code            TYPE result_code
                                        idinv           TYPE zeinv_idinv
                                        hasvalueinvoice TYPE zeinv_hasvalue
                              RAISING   zeinv_cx_vnpt_service.
    METHODS publish_inv_with_token IMPORTING input      TYPE zeinv_publish_cttwith_token_s1
                                             fkey       TYPE zeinv_fkey
                                             zpattern   TYPE zeinv_pattern
                                             zserial    TYPE zeinv_serial
                                   EXPORTING code       TYPE result_code
                                             einvoiceno TYPE zeinv_einvoiceno
                                   RAISING   zeinv_cx_vnpt_service.
    METHODS cancel_inv IMPORTING input TYPE zeinv_cancel_inv_soap_in
                                 fkey  TYPE zeinv_fkey
                       EXPORTING code  TYPE result_code
                       RAISING   zeinv_cx_vnpt_service.
    METHODS import_and_publish_inv IMPORTING input      TYPE zeinv_import_and_publish_inv_6
                                             fkey       TYPE zeinv_fkey
                                   EXPORTING code       TYPE result_code
                                             einvoiceno TYPE zeinv_einvoiceno
                                   RAISING   zeinv_cx_vnpt_service.
    METHODS replace_inv IMPORTING input      TYPE zeinv_replace_invoice_action_1
                                  fkey       TYPE zeinv_fkey
                        EXPORTING code       TYPE result_code
                                  einvoiceno TYPE zeinv_einvoiceno
                        RAISING   zeinv_cx_vnpt_service.
    METHODS adjust_invoice_no_publish IMPORTING input              TYPE zeinv_adjust_invoice_no_publi1
                                                fkey               TYPE zeinv_fkey
                                      EXPORTING code               TYPE result_code
                                      RETURNING VALUE(html_string) TYPE string
                                      RAISING   zeinv_cx_vnpt_service.

    METHODS adjust_invoice_no_publish_2 IMPORTING !input      TYPE zeinv_adjust_invoice_no_publi1
                                                  fkey        TYPE zeinv_fkey
                                        EXPORTING !code       TYPE result_code
                                                  html_string TYPE string
                                        RAISING   zeinv_cx_vnpt_service.

    METHODS replace_invoice_no_publish IMPORTING input              TYPE zeinv_replace_invoice_no_publ1
                                                 fkey               TYPE zeinv_fkey
                                       EXPORTING code               TYPE result_code
                                       RETURNING VALUE(html_string) TYPE string
                                       RAISING   zeinv_cx_vnpt_service.
    METHODS replace_invoice_no_publish_2 IMPORTING input       TYPE zeinv_replace_invoice_no_publ1
                                                   fkey        TYPE zeinv_fkey
                                         EXPORTING code        TYPE result_code
                                                   html_string TYPE string
                                         RAISING   zeinv_cx_vnpt_service.
    METHODS adjust_invoice_action IMPORTING input      TYPE zeinv_adjust_invoice_action_s1
                                            fkey       TYPE zeinv_fkey
                                  EXPORTING code       TYPE result_code
                                            einvoiceno TYPE zeinv_einvoiceno
                                  RAISING   zeinv_cx_vnpt_service.
    METHODS find_invoice_fkey  IMPORTING input      TYPE zeinv_list_inv_by_cus_fkey_so1
                                         fkey       TYPE zeinv_fkey
                               EXPORTING code       TYPE result_code
                                         einvoiceno TYPE zeinv_einvoiceno
                                         pulishdate TYPE cl_abap_context_info=>ty_system_date
                                         status     TYPE zeinv_status
                               RAISING   zeinv_cx_vnpt_service.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS parsing_xml IMPORTING string        TYPE string
                                  tagname       TYPE string
                        RETURNING VALUE(result) TYPE string.
    METHODS get_msg_number IMPORTING i_code          TYPE result_code
                           RETURNING VALUE(o_number) TYPE sy-msgno.
    METHODS save_log IMPORTING i_function TYPE string
                               i_fkey     TYPE zeinv_fkey
                               i_body     TYPE any
                               i_message  TYPE string.
    CONSTANTS:
      gv_top_xml    TYPE string  VALUE '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:tem="http://tempuri.org/"><soap:Header/><soap:Body>',
      gv_bottom_xml TYPE string VALUE '</soap:Body></soap:Envelope>'.
ENDCLASS.



CLASS ZEINV_CL_VNPT_SERVICE_SOAP IMPLEMENTATION.


  METHOD adjust_invoice_action.
    DATA:
      ls_exception LIKE if_t100_message=>t100key.

    g_destination_business->set_soap_action( EXPORTING
       i_operation = 'AdjustInvoiceAction'
       i_action    = 'http://tempuri.org/AdjustInvoiceAction'
   ).
    DATA(proxy) = NEW zeinv_co_business_service_soap( destination = g_destination_business ).
    proxy->adjust_invoice_action(
      EXPORTING
        input = input
      IMPORTING
        output = DATA(response)
    ).
    save_log( i_body = input
              i_fkey = fkey
              i_function = 'AdjustInvoiceAction'
              i_message = response-adjust_invoice_action_result ).
    IF response-adjust_invoice_action_result(2) = 'OK'.
      code = 'OK'.
      DATA(lv_einvoiceno) = segment( val = response-adjust_invoice_action_result index = 2 sep = fkey ).
      einvoiceno = |{ lv_einvoiceno ALPHA =  IN }|.
      CLEAR ls_exception.
    ELSE.
      code = response-adjust_invoice_action_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      IF ls_exception-msgno IS INITIAL.
        DATA:
            ls_temp_text TYPE msg_text.
        ls_temp_text = response-adjust_invoice_action_result.
        ls_exception = CORRESPONDING #( ls_temp_text ).
        ls_exception-msgno = '000'.
      ENDIF.
      RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
    ENDIF.

  ENDMETHOD.


  METHOD adjust_invoice_no_publish.
    DATA:
      ls_temp_text TYPE msg_text,
      ls_exception LIKE if_t100_message=>t100key.

    TRY.
        g_destination_business->set_soap_action( EXPORTING
            i_operation = 'AdjustInvoiceNoPublish'
            i_action    = 'http://tempuri.org/AdjustInvoiceNoPublish'
        ).
        DATA(proxy) = NEW zeinv_co_business_service_soap( destination = g_destination_business ).
        proxy->adjust_invoice_no_publish(
          EXPORTING
            input = input
          IMPORTING
            output = DATA(response)
        ).
        save_log( i_body = input
                  i_fkey = fkey
                  i_function = 'AdjustInvoiceNoPublish'
                  i_message = response-adjust_invoice_no_publish_resu ).
        TRY.
            IF response-adjust_invoice_no_publish_resu(5) = '<html'.
              html_string = response-adjust_invoice_no_publish_resu.
              code = 'OK'.
            ELSE.
              code = response-adjust_invoice_no_publish_resu.
              ls_exception-msgid = 'ZEINV_VNPT'.
              ls_exception-msgno = get_msg_number( i_code = code ).
              IF ls_exception-msgno IS INITIAL.
                ls_temp_text = response-adjust_invoice_no_publish_resu.
                ls_exception = CORRESPONDING #( ls_temp_text ).
                ls_exception-msgno = '000'.
              ENDIF.
              RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
            ENDIF.
          CATCH cx_sy_range_out_of_bounds INTO DATA(lx_sy_range_out_of_bounds).
            code = response-adjust_invoice_no_publish_resu.
            ls_exception-msgid = 'ZEINV_VNPT'.
            ls_exception-msgno = get_msg_number( i_code = code ).
            IF ls_exception-msgno IS INITIAL.
              ls_temp_text = response-adjust_invoice_no_publish_resu.
              ls_exception = CORRESPONDING #( ls_temp_text ).
              ls_exception-msgno = '000'.
            ENDIF.
            RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
        ENDTRY.
      CATCH  cx_soap_destination_error INTO DATA(lx_soap_destination_error).
    ENDTRY.
  ENDMETHOD.


  METHOD adjust_invoice_no_publish_2.
    DATA:
      ls_temp_text TYPE msg_text,
      ls_exception LIKE if_t100_message=>t100key.

    TRY.
        g_destination_business->set_soap_action( EXPORTING
            i_operation = 'AdjustInvoiceNoPublish'
            i_action    = 'http://tempuri.org/AdjustInvoiceNoPublish'
        ).
        DATA(proxy) = NEW zeinv_co_business_service_soap( destination = g_destination_business ).
        proxy->adjust_invoice_no_publish(
          EXPORTING
            input = input
          IMPORTING
            output = DATA(response)
        ).
        save_log( i_body = input
                  i_fkey = fkey
                  i_function = 'AdjustInvoiceNoPublish'
                  i_message = response-adjust_invoice_no_publish_resu ).
        TRY.
            IF response-adjust_invoice_no_publish_resu(5) = '<html'.
              html_string = response-adjust_invoice_no_publish_resu.
              code = 'OK'.
            ELSE.
              code = response-adjust_invoice_no_publish_resu.
              ls_exception-msgid = 'ZEINV_VNPT'.
              ls_exception-msgno = get_msg_number( i_code = code ).
              IF ls_exception-msgno IS INITIAL.
                ls_temp_text = response-adjust_invoice_no_publish_resu.
                ls_exception = CORRESPONDING #( ls_temp_text ).
                ls_exception-msgno = '000'.
              ENDIF.
              RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
            ENDIF.
          CATCH cx_sy_range_out_of_bounds INTO DATA(lx_sy_range_out_of_bounds).
            code = response-adjust_invoice_no_publish_resu.
            ls_exception-msgid = 'ZEINV_VNPT'.
            ls_exception-msgno = get_msg_number( i_code = code ).
            IF ls_exception-msgno IS INITIAL.
              ls_temp_text = response-adjust_invoice_no_publish_resu.
              ls_exception = CORRESPONDING #( ls_temp_text ).
              ls_exception-msgno = '000'.
            ENDIF.
            RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
        ENDTRY.
      CATCH  cx_soap_destination_error INTO DATA(lx_soap_destination_error).
    ENDTRY.
  ENDMETHOD.


  METHOD cancel_inv.
    DATA:
      ls_exception LIKE if_t100_message=>t100key.
    g_destination_business->set_soap_action( EXPORTING
        i_operation = 'cancelInv'
        i_action    = 'http://tempuri.org/cancelInv'
    ).
    DATA(proxy) = NEW zeinv_co_business_service_soap( destination = g_destination_business ).
    proxy->cancel_inv(
      EXPORTING
        input = input
      IMPORTING
        output = DATA(response)
    ).
    save_log( i_body = input
              i_fkey = fkey
              i_function = 'cancelInv'
              i_message = response-cancel_inv_result ).
    IF response-cancel_inv_result(2) = 'OK'.
      code = 'OK'.
      CLEAR ls_exception.
    ELSE.
      code = response-cancel_inv_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      IF ls_exception-msgno IS INITIAL.
        DATA:
            ls_temp_text TYPE msg_text.
        ls_temp_text = response-cancel_inv_result.
        ls_exception = CORRESPONDING #( ls_temp_text ).
        ls_exception-msgno = '000'.
      ENDIF.
      RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
    ENDIF.
  ENDMETHOD.


  METHOD constructor.
    g_auth =  i_auth.
    gv_type = i_type.
    TRY.
        g_destination_publish = cl_soap_destination_provider=>create_by_url( i_url = |{ g_auth-serviceurl }/PublishService.asmx| ).
        g_destination_portal = cl_soap_destination_provider=>create_by_url( i_url = |{ g_auth-serviceurl }/PortalService.asmx| ).
        g_destination_business = cl_soap_destination_provider=>create_by_url( i_url = |{ g_auth-serviceurl }/BusinessService.asmx| ).
      CATCH cx_soap_destination_error.
    ENDTRY.
  ENDMETHOD.


  METHOD delete_invoice_by_fkey.
    DATA:
      ls_exception LIKE if_t100_message=>t100key.

    g_destination_publish->set_soap_action(
    EXPORTING
      i_operation = 'deleteInvoiceByFkey'
      i_action    = 'http://tempuri.org/deleteInvoiceByFkey'
    ).
    DATA(proxy) = NEW zeinv_co_publish_service_soap( destination = g_destination_publish ).
    proxy->delete_invoice_by_fkey(
      EXPORTING
        input = input
      IMPORTING
        output = DATA(response)
    ).
    save_log( i_body = input
              i_fkey = fkey
              i_function = 'deleteInvoiceByFkey'
              i_message = response-delete_invoice_by_fkey_result ).

    IF response-delete_invoice_by_fkey_result(2) = 'OK' OR response-delete_invoice_by_fkey_result = 'ERR:5'.
      code  = 'OK'.
    ELSE.
      code = response-delete_invoice_by_fkey_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      IF ls_exception-msgno IS INITIAL.
        DATA:
            ls_temp_text TYPE msg_text.
        ls_temp_text = response-delete_invoice_by_fkey_result.
        ls_exception = CORRESPONDING #( ls_temp_text ).
        ls_exception-msgno = '000'.
      ENDIF.
      RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
    ENDIF.

  ENDMETHOD.


  METHOD download_inv_pdffkey_no_pay.
    DATA: ls_exception LIKE if_t100_message=>t100key.

    g_destination_portal->set_soap_action( EXPORTING
        i_operation = 'downloadInvPDFFkeyNoPay'
        i_action    = 'http://tempuri.org/downloadInvPDFFkeyNoPay'
    ).
    DATA(proxy) = NEW zeinv_co_portal_service_soap( destination = g_destination_portal ).
    proxy->download_inv_pdffkey_no_pay(
      EXPORTING
        input = input
      IMPORTING
        output = DATA(response)
    ).
    save_log( i_body = input
              i_fkey = fkey
              i_function = 'downloadInvPDFFkeyNoPay'
              i_message = response-download_inv_pdffkey_no_pay_re ).
    code = response-download_inv_pdffkey_no_pay_re.
    ls_exception-msgid = 'ZEINV_VNPT'.
    ls_exception-msgno = get_msg_number( i_code = code ).
    IF ls_exception-msgno IS INITIAL.
      code = 'OK'.
      pdf_string = response-download_inv_pdffkey_no_pay_re.
    ELSE.
      RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
    ENDIF.

  ENDMETHOD.


  METHOD download_new_inv_pdffkey.
    DATA:
      ls_exception LIKE if_t100_message=>t100key.

    TRY.
        g_destination_portal->set_soap_action( EXPORTING
            i_operation = 'downloadNewInvPDFFkey'
            i_action    = 'http://tempuri.org/downloadNewInvPDFFkey'
        ).
        DATA(proxy) = NEW zeinv_co_portal_service_soap( destination = g_destination_portal ).
        proxy->download_new_inv_pdffkey(
          EXPORTING
            input = input
          IMPORTING
            output = DATA(response)
        ).
        save_log( i_body = input
                  i_fkey = fkey
                  i_function = 'downloadNewInvPDFFkey'
                  i_message = response-download_new_inv_pdffkey_resul ).
        code = response-download_new_inv_pdffkey_resul.
        ls_exception-msgid = 'ZEINV_VNPT'.
        ls_exception-msgno = get_msg_number( i_code = code ).
        IF ls_exception-msgno IS INITIAL.
          code = 'OK'.
          pdf_string = response-download_new_inv_pdffkey_resul.
        ELSE.
          RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
        ENDIF.
      CATCH cx_soap_destination_error cx_ai_system_fault.
    ENDTRY.
  ENDMETHOD.


  METHOD  find_invoice_fkey.
    DATA:
      ls_exception          LIKE if_t100_message=>t100key,
      lv_position           TYPE int4,
      lv_position_stt       TYPE int4,
      lv_position_pld       TYPE int4,
      lv_publishdate        TYPE cl_abap_context_info=>ty_system_date,
      lv_publishdate_string TYPE string,
      BEGIN OF ls_publishdate,
        lv_date(2)     TYPE c,
        lv_month(2)    TYPE c,
        lv_tmp_year(6) TYPE c,
        lv_year(4)     TYPE c,
      END OF ls_publishdate.

    TRY.
        g_destination_portal->set_soap_action( EXPORTING
            i_operation = 'listInvByCusFkey'
            i_action    = 'http://tempuri.org/listInvByCusFkey'
        ).
        DATA(proxy) = NEW zeinv_co_portal_service_soap( destination = g_destination_portal ).
        proxy->list_inv_by_cus_fkey(
          EXPORTING
            input = input
          IMPORTING
            output = DATA(response)
        ).
        save_log( i_body = input
                  i_fkey = fkey
                  i_function = 'listInvByCusFkey'
                  i_message = response-list_inv_by_cus_fkey_result ).
        FIND FIRST OCCURRENCE OF |<invNum>| IN response-list_inv_by_cus_fkey_result MATCH OFFSET lv_position.
        FIND FIRST OCCURRENCE OF |<status>| IN response-list_inv_by_cus_fkey_result MATCH OFFSET lv_position_stt.
        FIND FIRST OCCURRENCE OF |<publishDate>| IN response-list_inv_by_cus_fkey_result MATCH OFFSET lv_position_pld.
        lv_position     = lv_position + 8.
        lv_position_stt = lv_position_stt + 8.
        lv_position_pld = lv_position_pld + 13.
        lv_publishdate_string = response-list_inv_by_cus_fkey_result+lv_position_pld(10).
        status = response-list_inv_by_cus_fkey_result+lv_position_stt(1).
        CASE status.
          WHEN '0'.
            code       = 'ERROR'.
          WHEN OTHERS.
            SPLIT lv_publishdate_string AT '/' INTO ls_publishdate-lv_month ls_publishdate-lv_date  ls_publishdate-lv_tmp_year.
            SPLIT ls_publishdate-lv_tmp_year AT ' ' INTO ls_publishdate-lv_year ls_publishdate-lv_tmp_year.
            pulishdate = |{ ls_publishdate-lv_year }{ COND #( WHEN ls_publishdate-lv_month < 10 THEN |0{ ls_publishdate-lv_month }|
                                                                     ELSE ls_publishdate-lv_month ) }{ COND #( WHEN ls_publishdate-lv_date < 10 THEN |0{ ls_publishdate-lv_date }|
                                                                     ELSE ls_publishdate-lv_date ) }|.
            code       = 'OK'.
            einvoiceno = response-list_inv_by_cus_fkey_result+lv_position(8).
        ENDCASE.
      CATCH cx_soap_destination_error cx_ai_system_fault.
    ENDTRY.
  ENDMETHOD.


  METHOD gethash_inv_token.
    DATA: ls_exception      LIKE if_t100_message=>t100key,
          lv_position       TYPE int4,
          lv_position_idinv TYPE int4.
    TRY.
        g_destination_publish->set_soap_action( EXPORTING
              i_operation = 'getHashInvWithToken'
              i_action    = 'http://tempuri.org/getHashInvWithToken'
          ).
        DATA(proxy) = NEW zeinv_co_publish_service_soap( destination = g_destination_publish ).
        proxy->get_hash_inv_with_token(
          EXPORTING
            input = input
          IMPORTING
            output = DATA(response)
        ).
        save_log( i_body = input
                  i_fkey = fkey
                  i_function = 'getHashInvWithToken'
                  i_message = response-get_hash_inv_with_token_result ).
        FIND FIRST OCCURRENCE OF |<hashValue>|  IN response-get_hash_inv_with_token_result MATCH OFFSET lv_position.
        CASE lv_position.
          WHEN 0.
            ls_exception-msgid = 'ZEINV_VNPT'.
            ls_exception-msgno = segment( val = response-get_hash_inv_with_token_result index = 2 sep = `ERR:`  )..
            code               = response-get_hash_inv_with_token_result.
            RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
          WHEN OTHERS.
            code = 'OK'.
            DATA(lv_hasvalue_first)  = segment( val = response-get_hash_inv_with_token_result index = 1 sep = `</hashValue>`  ).
            hasvalueinvoice          = segment( val = lv_hasvalue_first index = 2 sep = `<hashValue>`  ).

            DATA(lv_idinvoice_first) = segment( val = response-get_hash_inv_with_token_result index = 1 sep = `</hashValue>`  ).
            idinv                    = segment( val = lv_idinvoice_first index = 2 sep = `<idInv>`  ).
        ENDCASE.

      CATCH cx_ai_system_fault INTO DATA(lx_ai_system_fault).
        DATA(lv_ai_system_fault) = lx_ai_system_fault->get_longtext(  ).
      CATCH cx_soap_destination_error.
    ENDTRY.
  ENDMETHOD.


  METHOD get_msg_number.
    CLEAR o_number.
    CHECK i_code IS NOT INITIAL.
    DATA: lv_3_c TYPE c LENGTH 3.
    TRY.
        lv_3_c = segment( val = i_code sep = `:` index = 2 ).
        o_number = lv_3_c.
      CATCH cx_sy_strg_par_val.
        EXIT.
    ENDTRY.
  ENDMETHOD.


  METHOD import_and_publish_inv.
    DATA:
      ls_exception LIKE if_t100_message=>t100key.
    g_destination_publish->set_soap_action( EXPORTING
        i_operation = 'ImportAndPublishInv'
        i_action    = 'http://tempuri.org/ImportAndPublishInv'
    ).
    DATA(proxy) = NEW zeinv_co_publish_service_soap( destination = g_destination_publish ).
    proxy->import_and_publish_inv(
      EXPORTING
        input = input
      IMPORTING
        output = DATA(response)
    ).
    save_log( i_body = input
              i_fkey = fkey
              i_function = 'ImportAndPublishInv'
              i_message = response-import_and_publish_inv_result ).
    IF response-import_and_publish_inv_result(2) = 'OK'.
      code = 'OK'.
      DATA(lv_einvoiceno) = segment( val = response-import_and_publish_inv_result index = 2 sep = fkey ).
      einvoiceno = |{ lv_einvoiceno ALPHA =  IN }|.
      CLEAR ls_exception.
    ELSE.
      code = response-import_and_publish_inv_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      IF ls_exception-msgno IS INITIAL.
        DATA:
            ls_temp_text TYPE msg_text.
        ls_temp_text = response-import_and_publish_inv_result.
        ls_exception = CORRESPONDING #( ls_temp_text ).
        ls_exception-msgno = '000'.
      ENDIF.
      RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
    ENDIF.

  ENDMETHOD.


  METHOD import_inv_by_pattern.
    DATA:
      ls_exception LIKE if_t100_message=>t100key.

    TRY.

        g_destination_publish->set_soap_action(
          EXPORTING
            i_operation = 'ImportInvByPattern'
            i_action    = 'http://tempuri.org/ImportInvByPattern'
        ).
        DATA(proxy) = NEW zeinv_co_publish_service_soap( destination = g_destination_publish ).
        proxy->import_inv_by_pattern(
          EXPORTING
            input = input
          IMPORTING
            output = DATA(response)
        ).
        save_log( i_body = input
                  i_fkey = fkey
                  i_function = 'ImportInvByPattern'
                  i_message = response-import_inv_by_pattern_result ).

        IF response-import_inv_by_pattern_result IS NOT INITIAL AND response-import_inv_by_pattern_result(2) = 'OK'.
          code  = 'OK'.
        ELSE.
          code = response-import_inv_by_pattern_result.
          ls_exception-msgid = 'ZEINV_VNPT'.
          ls_exception-msgno = get_msg_number( i_code = code ).
          IF ls_exception-msgno IS INITIAL.
            DATA:
                ls_temp_text TYPE msg_text.
            ls_temp_text = response-import_inv_by_pattern_result.
            ls_exception = CORRESPONDING #( ls_temp_text ).
            ls_exception-msgno = '000'.
          ENDIF.
          RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
        ENDIF.

      CATCH cx_ai_system_fault INTO DATA(lx_ai_system_fault).
        DATA(lv_ai_system_fault) = lx_ai_system_fault->get_longtext(  ).
    ENDTRY.

  ENDMETHOD.


  METHOD parsing_xml.
    DATA: lv_string TYPE string,
          lv_result TYPE string.

    lv_string = string.
    CHECK lv_string IS NOT INITIAL.
    REPLACE |</{ tagname }>| IN lv_string WITH |<{ tagname }>|.
    lv_result = segment( val = lv_string index = 2 sep = |<{ tagname }>| ).
    result = lv_result.

  ENDMETHOD.


  METHOD publish_inv_fkey.
    DATA: ls_exception LIKE if_t100_message=>t100key.

    TRY.
        g_destination_publish->set_soap_action( EXPORTING
            i_operation = 'PublishInvFkey'
            i_action    = 'http://tempuri.org/PublishInvFkey'
        ).
        DATA(proxy) = NEW zeinv_co_publish_service_soap( destination = g_destination_publish ).
        proxy->publish_inv_fkey(
          EXPORTING
            input = input
          IMPORTING
            output = DATA(response)
        ).
        save_log( i_body = input
                  i_fkey = fkey
                  i_function = 'PublishInvFkey'
                  i_message = response-publish_inv_fkey_result ).
        FIND FIRST OCCURRENCE OF |{ input-ls_fkey }| IN response-publish_inv_fkey_result MATCH OFFSET DATA(lv_offset).
        CASE lv_offset.
          WHEN 6 OR 15.
            ls_exception-msgno = lv_offset.
            code = |ERR:{ lv_offset }|.
            RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
          WHEN 21.
            code = 'OK'.
            DATA(lv_einvoiceno) = segment( val = response-publish_inv_fkey_result index = 2 sep = input-ls_fkey ).
            einvoiceno = |{ lv_einvoiceno ALPHA =  IN }|.
          WHEN OTHERS.
            ls_exception-msgid = 'ZEINV_VNPT'.
            ls_exception-msgno = get_msg_number( i_code = code ).
            IF ls_exception-msgno IS INITIAL.
              DATA:
                  ls_temp_text TYPE msg_text.
              ls_temp_text = response-publish_inv_fkey_result.
              ls_exception = CORRESPONDING #( ls_temp_text ).
              ls_exception-msgno = '000'.
            ENDIF.
        ENDCASE.

      CATCH cx_ai_system_fault INTO DATA(lx_ai_system_fault).
        DATA(lv_ai_system_fault) = lx_ai_system_fault->get_longtext(  ).
      CATCH cx_soap_destination_error.
    ENDTRY.
  ENDMETHOD.


  METHOD publish_inv_with_token.
    DATA: ls_exception      LIKE if_t100_message=>t100key,
          lv_position       TYPE int4,
          lv_position_idinv TYPE int4.
    TRY.
        g_destination_publish->set_soap_action( EXPORTING
              i_operation = 'publishInvWithToken'
              i_action    = 'http://tempuri.org/publishInvWithToken'
          ).
        DATA(proxy) = NEW zeinv_co_publish_service_soap( destination = g_destination_publish ).
        proxy->publish_inv_with_token(
          EXPORTING
            input = input
          IMPORTING
            output = DATA(response)
        ).
        save_log( i_body     = input
                  i_fkey     = fkey
                  i_function = 'publishInvWithToken'
                  i_message  = response-publish_inv_with_token_result ).
        FIND FIRST OCCURRENCE OF zserial IN response-publish_inv_with_token_result MATCH OFFSET DATA(lv_offset).
        CASE lv_offset.
          WHEN 0.
            ls_exception-msgno = segment( val = response-publish_inv_with_token_result index = 2 sep = `ERR:` ).
            code               = response-publish_inv_with_token_result.
            RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
          WHEN OTHERS.
            code = 'OK'.
            DATA(lv_einvoiceno) = segment( val = response-publish_inv_with_token_result index = 2 sep = zserial ).
            einvoiceno          = |{ lv_einvoiceno ALPHA =  IN }|.
        ENDCASE.

      CATCH cx_ai_system_fault INTO DATA(lx_ai_system_fault).
        DATA(lv_ai_system_fault) = lx_ai_system_fault->get_longtext(  ).
      CATCH cx_soap_destination_error.
    ENDTRY.
  ENDMETHOD.


  METHOD replace_inv.
    DATA:
      ls_exception LIKE if_t100_message=>t100key.

    g_destination_business->set_soap_action( EXPORTING
        i_operation = 'ReplaceInvoiceAction'
        i_action    = 'http://tempuri.org/ReplaceInvoiceAction'
    ).
    DATA(proxy) = NEW zeinv_co_business_service_soap( destination = g_destination_business ).
    proxy->replace_invoice_action(
      EXPORTING
        input = input
      IMPORTING
        output = DATA(response)
    ).
    save_log( i_body = input
              i_fkey = fkey
              i_function = 'ReplaceInvoiceAction'
              i_message = response-replace_invoice_action_result ).
    IF response-replace_invoice_action_result(2) = 'OK'.
      code = 'OK'.
      DATA(lv_einvoiceno) = segment( val = response-replace_invoice_action_result index = 2 sep = fkey ).
      einvoiceno = |{ lv_einvoiceno ALPHA =  IN }|.
      CLEAR ls_exception.
    ELSE.
      code = response-replace_invoice_action_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      IF ls_exception-msgno IS INITIAL.
        DATA:
            ls_temp_text TYPE msg_text.
        ls_temp_text = response-replace_invoice_action_result.
        ls_exception = CORRESPONDING #( ls_temp_text ).
        ls_exception-msgno = '000'.
      ENDIF.
      RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
    ENDIF.

  ENDMETHOD.


  METHOD replace_invoice_no_publish.
    DATA:
      ls_exception LIKE if_t100_message=>t100key.

    g_destination_business->set_soap_action( EXPORTING
        i_operation = 'ReplaceInvoiceNoPublish'
        i_action    = 'http://tempuri.org/ReplaceInvoiceNoPublish'
    ).
    DATA(proxy) = NEW zeinv_co_business_service_soap( destination = g_destination_business ).
    proxy->replace_invoice_no_publish(
      EXPORTING
        input = input
      IMPORTING
        output = DATA(response)
    ).
    save_log( i_body = input
              i_fkey = fkey
              i_function = 'ReplaceInvoiceNoPublish'
              i_message = response-replace_invoice_no_publish_res ).

    IF  response-replace_invoice_no_publish_res CS 'html'.
      html_string = response-replace_invoice_no_publish_res.
      code = 'OK'.
    ELSE.
      code = response-replace_invoice_no_publish_res.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      IF ls_exception-msgno IS INITIAL.
        DATA:
            ls_temp_text TYPE msg_text.
        ls_temp_text = response-replace_invoice_no_publish_res.
        ls_exception = CORRESPONDING #( ls_temp_text ).
        ls_exception-msgno = '000'.
      ENDIF.
      RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
    ENDIF.
  ENDMETHOD.


  METHOD replace_invoice_no_publish_2.
    DATA:
      ls_exception LIKE if_t100_message=>t100key.

    g_destination_business->set_soap_action( EXPORTING
        i_operation = 'ReplaceInvoiceNoPublish'
        i_action    = 'http://tempuri.org/ReplaceInvoiceNoPublish'
    ).
    DATA(proxy) = NEW zeinv_co_business_service_soap( destination = g_destination_business ).
    proxy->replace_invoice_no_publish(
      EXPORTING
        input = input
      IMPORTING
        output = DATA(response)
    ).
    save_log( i_body = input
              i_fkey = fkey
              i_function = 'ReplaceInvoiceNoPublish'
              i_message = response-replace_invoice_no_publish_res ).

    IF  response-replace_invoice_no_publish_res CS 'html'.
      html_string = response-replace_invoice_no_publish_res.
      code = 'OK'.
    ELSE.
      code = response-replace_invoice_no_publish_res.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      IF ls_exception-msgno IS INITIAL.
        DATA:
            ls_temp_text TYPE msg_text.
        ls_temp_text = response-replace_invoice_no_publish_res.
        ls_exception = CORRESPONDING #( ls_temp_text ).
        ls_exception-msgno = '000'.
      ENDIF.
      RAISE EXCEPTION NEW zeinv_cx_vnpt_service( textid = ls_exception ).
    ENDIF.
  ENDMETHOD.


  METHOD save_log.
    DATA(lv_body_string) = xco_cp_json=>data->from_abap( i_body )->to_string( ).
    DATA ls_zeinv_tb_log TYPE zeinv_tb_log.
    ls_zeinv_tb_log-log_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c22( ).
    ls_zeinv_tb_log-uuid = i_fkey.
    ls_zeinv_tb_log-type = gv_type.
    ls_zeinv_tb_log-function = i_function.
    ls_zeinv_tb_log-body = lv_body_string.
    ls_zeinv_tb_log-message = i_message.
    ls_zeinv_tb_log-logtime = sy-timlo.
    ls_zeinv_tb_log-logdate = sy-datum.
    ls_zeinv_tb_log-loguser = sy-uname.
    MODIFY zeinv_tb_log FROM @ls_zeinv_tb_log.
    COMMIT WORK AND WAIT.
  ENDMETHOD.
ENDCLASS.
