class zeinv_cl_vnpt_service definition
  public
  final
  create public .

  public section.
    types: begin of msg_text,
             attr1 type c length 40,
             attr2 type c length 40,
             attr3 type c length 40,
             attr4 type c length 40,
           end of msg_text.
    types:
        result_code type c length 10.
    data:
      g_auth                 type zeinv_vnpt_auth,
      gv_type                type zeinv_type,
      g_destination_publish  type ref to if_http_destination,
      g_destination_portal   type ref to if_http_destination,
      g_destination_business type ref to if_http_destination.
    methods constructor importing i_auth type zeinv_vnpt_auth
                                  i_type type zeinv_type
                        raising   cx_http_dest_provider_error.

    methods import_inv_by_pattern importing input type zeinv_import_inv_by_pattern_s1
                                            fkey  type zeinv_fkey
                                  exporting code  type result_code
                                  raising   zeinv_cx_vnpt_service.
    methods delete_invoice_by_fkey importing input type zeinv_delete_invoice_by_fkey_1
                                             fkey  type zeinv_fkey
                                   exporting code  type result_code
                                   raising   zeinv_cx_vnpt_service.
    methods download_new_inv_pdffkey importing input             type zeinv_download_new_inv_pdffke1
                                               fkey              type zeinv_fkey
                                     exporting code              type result_code
                                     returning value(pdf_string) type string
                                     raising   zeinv_cx_vnpt_service.

    methods download_inv_pdffkey_no_pay importing input             type zeinv_download_inv_pdffkey_no1
                                                  fkey              type zeinv_fkey
                                        exporting code              type result_code
                                        returning value(pdf_string) type string
                                        raising   zeinv_cx_vnpt_service.

    methods publish_inv_fkey importing input      type zeinv_publish_inv_fkey_soap_in
                                       fkey       type zeinv_fkey
                             exporting code       type result_code
                                       einvoiceno type zeinv_einvoiceno
                             raising   zeinv_cx_vnpt_service.
    methods cancel_inv importing input type zeinv_cancel_inv_soap_in
                                 fkey  type zeinv_fkey
                       exporting code  type result_code
                       raising   zeinv_cx_vnpt_service.
    methods import_and_publish_inv importing input      type zeinv_import_and_publish_inv_2
                                             fkey       type zeinv_fkey
                                   exporting code       type result_code
                                             einvoiceno type zeinv_einvoiceno
                                   raising   zeinv_cx_vnpt_service.
    methods replace_inv importing input      type zeinv_replace_invoice_action_1
                                  fkey       type zeinv_fkey
                        exporting code       type result_code
                                  einvoiceno type zeinv_einvoiceno
                        raising   zeinv_cx_vnpt_service.
    methods adjust_invoice_no_publish importing input              type zeinv_adjust_invoice_no_publi1
                                                fkey               type zeinv_fkey
                                      exporting code               type result_code
                                      returning value(html_string) type string
                                      raising   zeinv_cx_vnpt_service.
    methods replace_invoice_no_publish importing input              type zeinv_replace_invoice_no_publ1
                                                 fkey               type zeinv_fkey
                                       exporting code               type result_code
                                       returning value(html_string) type string
                                       raising   zeinv_cx_vnpt_service.
    methods adjust_invoice_action importing input      type zeinv_adjust_invoice_action_s1
                                            fkey       type zeinv_fkey
                                  exporting code       type result_code
                                            einvoiceno type zeinv_einvoiceno
                                  raising   zeinv_cx_vnpt_service.
  protected section.
  private section.
    methods parsing_xml importing string        type string
                                  tagname       type string
                        returning value(result) type string.
    methods get_msg_number importing i_code          type result_code
                           returning value(o_number) type sy-msgno.
    methods save_log importing i_function type string
                               i_fkey     type zeinv_fkey
                               i_body     type string
                               i_message  type string.
    constants:
      gv_top_xml    type string  value '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:tem="http://tempuri.org/"><soap:Header/><soap:Body>',
      gv_bottom_xml type string value '</soap:Body></soap:Envelope>'.
ENDCLASS.



CLASS ZEINV_CL_VNPT_SERVICE IMPLEMENTATION.


  method adjust_invoice_action.
    data:
      lv_response  type string,
      ls_exception like if_t100_message=>t100key.
    data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = g_destination_business ).
    data(lo_request) = lo_http_client->get_http_request(  ).

    data(lv_body) = |{ gv_top_xml }|
                 && |<tem:AdjustInvoiceAction>|
                     && |<tem:xmlInvData><![CDATA[{ input-xml_inv_data }]]></tem:xmlInvData>|
                     && |<tem:username>{ input-username }</tem:username>|
                     && |<tem:pass><![CDATA[{ input-pass }]]></tem:pass>|
                     && |<tem:Account>{ input-account }</tem:Account>|
                     && |<tem:ACpass><![CDATA[{ input-acpass }]]></tem:ACpass>|
                     && |<tem:pattern>{ input-pattern }</tem:pattern>|
                     && |<tem:serial>{ input-serial }</tem:serial>|
                     && |<tem:convert>0</tem:convert>|
                     && |<tem:fkey><![CDATA[{ input-fkey }]]></tem:fkey>|
                 && |</tem:AdjustInvoiceAction>|
                 && |{ gv_bottom_xml }|.

    lo_request->set_text( i_text = lv_body ).
    lo_request->set_content_type( content_type = 'text/xml;charset=utf-8' ).
    data(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
    lv_response  = lo_response->get_text( ).

* get response
    data(lv_result) = parsing_xml( string = lv_response tagname = 'AdjustInvoiceActionResult' ).
    save_log( i_body = lv_body i_fkey = fkey i_function = 'AdjustInvoiceAction' i_message = lv_result ).
    if lv_result(2) = 'OK'.
      code = 'OK'.
      data(lv_einvoiceno) = segment( val = lv_result index = 2 sep = fkey ).
      einvoiceno = |{ lv_einvoiceno alpha =  in }|.
      clear ls_exception.
    else.
      code = lv_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      if ls_exception-msgno is initial.
        data:
            ls_temp_text type msg_text.
        ls_temp_text = lv_result.
        ls_exception = corresponding #( ls_temp_text ).
        ls_exception-msgno = '000'.
      endif.
      raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
    endif.

  endmethod.


  method adjust_invoice_no_publish.
    data:
      lv_response  type string,
      ls_exception like if_t100_message=>t100key.
    data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = g_destination_business ).
    data(lo_request) = lo_http_client->get_http_request(  ).

    data(lv_body) = |{ gv_top_xml }|
                 && |<tem:AdjustInvoiceNoPublish>|
                 && |<tem:Account>{ input-account }</tem:Account>|
                 && |<tem:ACpass>{ input-acpass }</tem:ACpass>|
                 && |<tem:username>{ input-username }</tem:username>|
                 && |<tem:pass>{ input-pass }</tem:pass>|
                 && |<tem:fkey>{ input-fkey }</tem:fkey>|
                 && |<tem:convert>0</tem:convert>|
                 && |<tem:pattern>{ input-pattern }</tem:pattern>|
                 && |<tem:serial>{ input-serial }</tem:serial>|
                 && |<tem:xmlInvData><![CDATA[{ input-xml_inv_data }]]></tem:xmlInvData>|
                 && |</tem:AdjustInvoiceNoPublish>|
                 && |{ gv_bottom_xml }|.

    lo_request->set_text( i_text = lv_body ).
    lo_request->set_content_type( content_type = 'text/xml' ).
    data(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
    lv_response  = lo_response->get_text( ).
    data(lv_result) = parsing_xml( string = lv_response tagname = 'AdjustInvoiceNoPublishResult' ).
    if  lv_result(8) = '&lt;html'.
      html_string = lv_result.
      code = 'OK'.
    else.
      code = lv_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      if ls_exception-msgno is initial.
        data:
            ls_temp_text type msg_text.
        ls_temp_text = lv_result.
        ls_exception = corresponding #( ls_temp_text ).
        ls_exception-msgno = '000'.
      endif.
      raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
    endif.
  endmethod.


  method cancel_inv.
    data:
      lv_response  type string,
      ls_exception like if_t100_message=>t100key.
    try.
        data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = g_destination_business ).
      catch cx_web_http_client_error into data(lx_web_http_client_error).
        ls_exception-msgno = '000'.
        ls_exception-attr1 = lx_web_http_client_error->get_longtext(  ).
        raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
    endtry.
    data(lo_request) = lo_http_client->get_http_request(  ).

    data(lv_body) = |{ gv_top_xml }|
                 && |<tem:cancelInv>|
                     && |<tem:fkey><![CDATA[{ input-fkey }]]></tem:fkey>|
                     && |<tem:userName>{ input-user_name }</tem:userName>|
                     && |<tem:userPass><![CDATA[{ input-user_pass }]]></tem:userPass>|
                     && |<tem:Account>{ input-account }</tem:Account>|
                     && |<tem:ACpass><![CDATA[{ input-acpass }]]></tem:ACpass>|
                 && |</tem:cancelInv>|
                 && |{ gv_bottom_xml }|.

    lo_request->set_text( i_text = lv_body ).
    lo_request->set_content_type( content_type = 'text/xml' ).
    data(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
    lv_response  = lo_response->get_text( ).

    data(lv_result) = parsing_xml( string = lv_response tagname = 'cancelInvResult' ).
    save_log( i_body = lv_body i_fkey = fkey i_function = 'cancelInv' i_message = lv_result ).
    if lv_result(2) = 'OK'.
      code = 'OK'.
      clear ls_exception.
    else.
      code = lv_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      if ls_exception-msgno is initial.
        data:
            ls_temp_text type msg_text.
        ls_temp_text = lv_result.
        ls_exception = corresponding #( ls_temp_text ).
        ls_exception-msgno = '000'.
      endif.
      raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
    endif.
  endmethod.


  method constructor.
    g_auth =  i_auth.
    gv_type = i_type.
    try.
        g_destination_publish = cl_http_destination_provider=>create_by_url( i_url = |{ g_auth-serviceurl }/PublishService.asmx| ).
        g_destination_portal = cl_http_destination_provider=>create_by_url( i_url = |{ g_auth-serviceurl }/PortalService.asmx| ).
        g_destination_business = cl_http_destination_provider=>create_by_url( i_url = |{ g_auth-serviceurl }/BusinessService.asmx| ).
      catch cx_http_dest_provider_error.
    endtry.
  endmethod.


  method delete_invoice_by_fkey.
    data:
      lv_response  type string,
      ls_exception like if_t100_message=>t100key.
    data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = g_destination_publish ).
    data(lo_request) = lo_http_client->get_http_request(  ).

    data(lv_body) = |{ gv_top_xml }|
                 && |<tem:deleteInvoiceByFkey>|
                     && |<tem:lstFkey>{ input-lst_fkey }</tem:lstFkey>|
                     && |<tem:username>{ input-username }</tem:username>|
                     && |<tem:password><![CDATA[{ input-password }]]></tem:password>|
                     && |<tem:Account>{ input-account }</tem:Account>|
                     && |<tem:ACpass><![CDATA[{ input-acpass }]]></tem:ACpass>|
                 && |</tem:deleteInvoiceByFkey>|
                 && |{ gv_bottom_xml }|.

    lo_request->set_text( i_text = lv_body ).
    lo_request->set_content_type( content_type = 'text/xml' ).
    data(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
    lv_response  = lo_response->get_text( ).

**********************************************************************
* get response
    data(lv_result) = parsing_xml( string = lv_response tagname = 'deleteInvoiceByFkeyResult' ).
    if lv_result(2) = 'OK' or lv_result = 'ERR:5'.
      code  = 'OK'.
    else.
      code = lv_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      if ls_exception-msgno is initial.
        data:
            ls_temp_text type msg_text.
        ls_temp_text = lv_result.
        ls_exception = corresponding #( ls_temp_text ).
        ls_exception-msgno = '000'.
      endif.
      raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
    endif.
  endmethod.


  method download_inv_pdffkey_no_pay.
    data:
      lv_response  type string,
      ls_exception like if_t100_message=>t100key.
    data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = g_destination_portal ).
    data(lo_request) = lo_http_client->get_http_request(  ).

    data(lv_body) = |{ gv_top_xml }|
                 && |<tem:downloadInvPDFFkeyNoPay>|
                 && |<tem:fkey><![CDATA[{ input-fkey }]]></tem:fkey>|
                 && |<tem:userName>{ input-user_name }</tem:userName>|
                 && |<tem:userPass><![CDATA[{ input-user_pass }]]></tem:userPass>|
                 && |</tem:downloadInvPDFFkeyNoPay>|
                 && |{ gv_bottom_xml }|.

    lo_request->set_text( i_text = lv_body ).
    lo_request->set_content_type( content_type = 'text/xml' ).
    data(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
    lv_response  = lo_response->get_text( ).
**********************************************************************
* get response
    data(lv_result) = parsing_xml( string = lv_response tagname = 'downloadInvPDFFkeyNoPayResult' ).
    save_log( i_body = lv_body i_fkey = fkey i_function = 'DownloadInvPDFFkeyNoPay' i_message = lv_result ).
    code = lv_result.
    ls_exception-msgid = 'ZEINV_VNPT'.
    ls_exception-msgno = get_msg_number( i_code = code ).
    if ls_exception-msgno is initial.
      code = 'OK'.
      pdf_string = lv_result.
    else.
      raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
    endif.

  endmethod.


  method download_new_inv_pdffkey.
    data:
      lv_response  type string,
      ls_exception like if_t100_message=>t100key.
    data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = g_destination_portal ).
    data(lo_request) = lo_http_client->get_http_request(  ).

    data(lv_body) = |{ gv_top_xml }|
                 && |<tem:downloadNewInvPDFFkey>|
                 && |<tem:fkey><![CDATA[{ input-fkey }]]></tem:fkey>|
                 && |<tem:userName>{ input-user_name }</tem:userName>|
                 && |<tem:userPass><![CDATA[{ input-user_pass }]]></tem:userPass>|
                 && |</tem:downloadNewInvPDFFkey>|
                 && |{ gv_bottom_xml }|.

    lo_request->set_text( i_text = lv_body ).
    lo_request->set_content_type( content_type = 'text/xml' ).
    data(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
    lv_response  = lo_response->get_text( ).
**********************************************************************
* get response
    data(lv_result) = parsing_xml( string = lv_response tagname = 'downloadNewInvPDFFkeyResult' ).
    save_log( i_body = lv_body i_fkey = fkey i_function = 'DownloadNewInvPDFFkey' i_message = lv_result ).
    code = lv_result.
    ls_exception-msgid = 'ZEINV_VNPT'.
    ls_exception-msgno = get_msg_number( i_code = code ).
    if ls_exception-msgno is initial.
      code = 'OK'.
      pdf_string = lv_result.
    else.
      raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
    endif.

  endmethod.


  method get_msg_number.
    clear o_number.
    data: lv_3_c type c length 3.
    try.
        lv_3_c = segment( val = i_code sep = `:` index = 2 ).
        o_number = lv_3_c.
      catch cx_sy_strg_par_val.
        exit.
    endtry.
  endmethod.


  method import_and_publish_inv.
    data:
      lv_response  type string,
      ls_exception like if_t100_message=>t100key.
    data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = g_destination_publish ).
    data(lo_request) = lo_http_client->get_http_request(  ).

    data(lv_body) = |{ gv_top_xml }|
                 && |<tem:ImportAndPublishInv>|
                     && |<tem:xmlInvData><![CDATA[{ input-xml_inv_data }]]></tem:xmlInvData>|
                     && |<tem:username>{ input-username }</tem:username>|
                     && |<tem:password><![CDATA[{ input-password }]]></tem:password>|
                     && |<tem:Account>{ input-account }</tem:Account>|
                     && |<tem:ACpass><![CDATA[{ input-acpass }]]></tem:ACpass>|
                     && |<tem:pattern>{ input-pattern }</tem:pattern>|
                     && |<tem:serial>{ input-serial }</tem:serial>|
                     && |<tem:convert>0</tem:convert>|
                 && |</tem:ImportAndPublishInv>|
                 && |{ gv_bottom_xml }|.

    lo_request->set_text( i_text = lv_body ).
    lo_request->set_content_type( content_type = 'text/xml' ).
    data(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
    lv_response  = lo_response->get_text( ).

* get response
    data(lv_result) = parsing_xml( string = lv_response tagname = 'ImportAndPublishInvResult' ).
    save_log( i_body = lv_body i_fkey = fkey i_function = 'ImportAndPublishInv' i_message = lv_result ).
    if lv_result(2) = 'OK'.
      code = 'OK'.
      data(lv_einvoiceno) = segment( val = lv_result index = 2 sep = fkey ).
      einvoiceno = |{ lv_einvoiceno alpha =  in }|.
      clear ls_exception.
    else.
      code = lv_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      if ls_exception-msgno is initial.
        data:
            ls_temp_text type msg_text.
        ls_temp_text = lv_result.
        ls_exception = corresponding #( ls_temp_text ).
        ls_exception-msgno = '000'.
      endif.
      raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
    endif.

  endmethod.


  method import_inv_by_pattern.
    data:
      lv_response  type string,
      ls_exception like if_t100_message=>t100key.
    data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = g_destination_publish ).
    data(lo_request) = lo_http_client->get_http_request(  ).

    data(lv_body) = |{ gv_top_xml }|
                 && |<tem:ImportInvByPattern>|
                 && |<tem:Account>{ input-account }</tem:Account>|
                 && |<tem:ACpass><![CDATA[{ input-acpass }]]></tem:ACpass>|
                 && |<tem:xmlInvData><![CDATA[{ input-xml_inv_data }]]></tem:xmlInvData>|
                 && |<tem:username>{ input-username }</tem:username>|
                 && |<tem:password><![CDATA[{ input-password }]]></tem:password>|
                 && |<tem:pattern>{ input-pattern }</tem:pattern>|
                 && |<tem:serial>{ input-serial }</tem:serial>|
                 && |<tem:convert>0</tem:convert>|
                 && |</tem:ImportInvByPattern>|
                 && |{ gv_bottom_xml }|.

    lo_request->set_text( i_text = lv_body ).
    lo_request->set_content_type( content_type = 'text/xml' ).
    data(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
    lv_response  = lo_response->get_text( ).
* get response
    data(lv_result) = parsing_xml( string = lv_response tagname = `ImportInvByPatternResult` ).
    save_log( i_body = lv_body i_fkey = fkey i_function = 'ImportInvByPattern' i_message = lv_result ).
    if lv_result is not initial and lv_result(2) = 'OK'.
      code  = 'OK'.
    else.
      code = lv_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      if ls_exception-msgno is initial.
        data:
            ls_temp_text type msg_text.
        ls_temp_text = lv_result.
        ls_exception = corresponding #( ls_temp_text ).
        ls_exception-msgno = '000'.
      endif.
      raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
    endif.
  endmethod.


  method parsing_xml.
    data: lv_string type string,
          lv_result type string.

    lv_string = string.
    check lv_string is not initial.
    replace |</{ tagname }>| in lv_string with |<{ tagname }>|.
    lv_result = segment( val = lv_string index = 2 sep = |<{ tagname }>| ).
    result = lv_result.

  endmethod.


  method publish_inv_fkey.
    data:
      lv_response  type string,
      ls_exception like if_t100_message=>t100key.
    data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = g_destination_publish ).
    data(lo_request) = lo_http_client->get_http_request(  ).

    data(lv_body) = |{ gv_top_xml }|
                 && |<tem:PublishInvFkey>|
                     && |<tem:lsFkey>{ input-ls_fkey }</tem:lsFkey>|
                     && |<tem:pattern>{ input-pattern }</tem:pattern>|
                     && |<tem:serial>{ input-serial }</tem:serial>|
                     && |<tem:username>{ input-username }</tem:username>|
                     && |<tem:password><![CDATA[{ input-password }]]></tem:password>|
                     && |<tem:Account>{ input-account }</tem:Account>|
                     && |<tem:ACpass><![CDATA[{ input-acpass }]]></tem:ACpass>|
                 && |</tem:PublishInvFkey>|
                 && |{ gv_bottom_xml }|.

    lo_request->set_text( i_text = lv_body ).
    lo_request->set_content_type( content_type = 'text/xml' ).
    data(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
    lv_response  = lo_response->get_text( ).

**********************************************************************
* get response
    data(lv_result) = parsing_xml( string = lv_response tagname = 'PublishInvFkeyResult' ).
    save_log( i_body = lv_body i_fkey = fkey i_function = 'PublishInvFkey' i_message = lv_result ).
    find first occurrence of |{ input-ls_fkey }| in lv_result match offset data(lv_offset).
    case lv_offset.
      when 6 or 15.
        ls_exception-msgno = lv_offset.
        code = |ERR:{ lv_offset }|.
        raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
      when 21.
        code = 'OK'.
        data(lv_einvoiceno) = segment( val = lv_result index = 2 sep = input-ls_fkey ).
        einvoiceno = |{ lv_einvoiceno alpha =  in }|.
      when others.
        ls_exception-msgid = 'ZEINV_VNPT'.
        ls_exception-msgno = get_msg_number( i_code = code ).
        if ls_exception-msgno is initial.
          data:
              ls_temp_text type msg_text.
          ls_temp_text = lv_result.
          ls_exception = corresponding #( ls_temp_text ).
          ls_exception-msgno = '000'.
        endif.
    endcase.

  endmethod.


  method replace_inv.
    data:
      lv_response  type string,
      ls_exception like if_t100_message=>t100key.
    data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = g_destination_business ).
    data(lo_request) = lo_http_client->get_http_request(  ).

    data(lv_body) = |{ gv_top_xml }|
                 && |<tem:ReplaceInvoiceAction>|
                     && |<tem:xmlInvData><![CDATA[{ input-xml_inv_data }]]></tem:xmlInvData>|
                     && |<tem:username>{ input-username }</tem:username>|
                     && |<tem:pass><![CDATA[{ input-pass }]]></tem:pass>|
                     && |<tem:Account>{ input-account }</tem:Account>|
                     && |<tem:ACpass><![CDATA[{ input-acpass }]]></tem:ACpass>|
                     && |<tem:fkey>{ input-fkey }</tem:fkey>|
                     && |<tem:Attachfile></tem:Attachfile>|
                     && |<tem:pattern>{ input-pattern }</tem:pattern>|
                     && |<tem:serial>{ input-serial }</tem:serial>|
                     && |<tem:convert>0</tem:convert>|
                 && |</tem:ReplaceInvoiceAction>|
                 && |{ gv_bottom_xml }|.

    lo_request->set_text( i_text = lv_body ).
    lo_request->set_content_type( content_type = 'text/xml' ).
    data(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
    lv_response  = lo_response->get_text( ).

* get response
    data(lv_result) = parsing_xml( string = lv_response tagname = 'ReplaceInvoiceActionResult' ).
    save_log( i_body = lv_body i_fkey = fkey i_function = 'ReplaceInvoiceAction' i_message = lv_result ).
    if lv_result(2) = 'OK'.
      code = 'OK'.
      data(lv_einvoiceno) = segment( val = lv_result index = 2 sep = fkey ).
      einvoiceno = |{ lv_einvoiceno alpha =  in }|.
      clear ls_exception.
    else.
      code = lv_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      if ls_exception-msgno is initial.
        data:
            ls_temp_text type msg_text.
        ls_temp_text = lv_result.
        ls_exception = corresponding #( ls_temp_text ).
        ls_exception-msgno = '000'.
      endif.
      raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
    endif.

  endmethod.


  method replace_invoice_no_publish.
    data:
      lv_response  type string,
      ls_exception like if_t100_message=>t100key.
    data(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = g_destination_business ).
    data(lo_request) = lo_http_client->get_http_request(  ).

    data(lv_body) = |{ gv_top_xml }|
                 && |<tem:ReplaceInvoiceNoPublish>|
                 && |<tem:Account>{ input-account }</tem:Account>|
                 && |<tem:ACpass>{ input-acpass }</tem:ACpass>|
                 && |<tem:username>{ input-username }</tem:username>|
                 && |<tem:pass>{ input-pass }</tem:pass>|
                 && |<tem:fkey>{ input-fkey }</tem:fkey>|
                 && |<tem:pattern>{ input-pattern }</tem:pattern>|
                 && |<tem:serial>{ input-serial }</tem:serial>|
                 && |<tem:xmlInvData><![CDATA[{ input-xml_inv_data }]]></tem:xmlInvData>|
                 && |</tem:ReplaceInvoiceNoPublish>|
                 && |{ gv_bottom_xml }|.

    lo_request->set_text( i_text = lv_body ).
    lo_request->set_content_type( content_type = 'text/xml' ).
    data(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
    lv_response  = lo_response->get_text( ).
    data(lv_result) = parsing_xml( string = lv_response tagname = 'ReplaceInvoiceNoPublishResult' ).
    replace all occurrences of ']]>' in html_string with ''.
    replace all occurrences of '<![CDATA[' in html_string with ''.
    if  lv_result cs 'html'.
      html_string = lv_result.
      code = 'OK'.
    else.
      code = lv_result.
      ls_exception-msgid = 'ZEINV_VNPT'.
      ls_exception-msgno = get_msg_number( i_code = code ).
      if ls_exception-msgno is initial.
        data:
            ls_temp_text type msg_text.
        ls_temp_text = lv_result.
        ls_exception = corresponding #( ls_temp_text ).
        ls_exception-msgno = '000'.
      endif.
      raise exception new zeinv_cx_vnpt_service( textid = ls_exception ).
    endif.
  endmethod.


  method save_log.
    data ls_zeinv_tb_log type zeinv_tb_log.
    ls_zeinv_tb_log-log_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c22( ).
    ls_zeinv_tb_log-uuid = i_fkey.
    ls_zeinv_tb_log-type = gv_type.
    ls_zeinv_tb_log-function = i_function.
    ls_zeinv_tb_log-body = i_body.
    ls_zeinv_tb_log-message = i_message.
    ls_zeinv_tb_log-logtime = sy-timlo.
    ls_zeinv_tb_log-logdate = sy-datum.
    ls_zeinv_tb_log-loguser = sy-uname.
    modify zeinv_tb_log from @ls_zeinv_tb_log.
    commit work and wait.
  endmethod.
ENDCLASS.
