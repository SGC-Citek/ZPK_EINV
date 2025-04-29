class zeinv_cx_vnpt_service definition
  public
  inheriting from cx_static_check
  final
  create public .

  public section.

    interfaces if_t100_message .
    interfaces if_t100_dyn_msg .
    data g_textid  like if_t100_message=>t100key .
    data codecontext type string .
    data code type string .
    data errortext type string .
    data language type cl_abap_context_info=>ty_language_key .
    methods constructor
      importing
        !textid   like if_t100_message=>t100key optional
        !previous like previous optional .
    methods get_textid
      returning
        value(result) like if_t100_message=>t100key.
    methods if_message~get_text
        redefinition .
    methods if_message~get_longtext
        redefinition .
  protected section.
  private section.
ENDCLASS.



CLASS ZEINV_CX_VNPT_SERVICE IMPLEMENTATION.


  method constructor ##ADT_SUPPRESS_GENERATION.
    call method super->constructor
      exporting
        previous = previous.
    clear me->textid.
    if textid is initial.
      if_t100_message~t100key = if_t100_message=>default_textid.
    else.
      if_t100_message~t100key = textid.
    endif.
    me->g_textid = textid.
  endmethod.


  method get_textid.
    result =  me->g_textid.
  endmethod.


  method if_message~get_longtext.
*    if code is initial and errortext is initial and textid = cx_ai_system_fault and previous is bound.
*      result = previous->if_message~get_longtext( preserve_newlines = preserve_newlines ).
*    else.
      result = super->if_message~get_longtext( preserve_newlines = preserve_newlines ).
*    endif.
  endmethod.


  method if_message~get_text.
*    if not me->errortext is initial
*    or not me->code is initial.
*      concatenate me->code me->errortext into result separated by space.
*    elseif textid = cx_ai_system_fault and previous is bound.
*      result = previous->if_message~get_text( ).
*    else.
      result = super->if_message~get_text( ).
*    endif.
  endmethod.
ENDCLASS.
