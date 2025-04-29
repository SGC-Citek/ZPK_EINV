CLASS lhc_rap_tdat_cts DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS:
      get
        RETURNING
          VALUE(result) TYPE REF TO if_mbc_cp_rap_table_cts.

ENDCLASS.

CLASS lhc_rap_tdat_cts IMPLEMENTATION.
  METHOD get.
    result = mbc_cp_api=>rap_table_cts(
                                        table_entity_relations = VALUE #(
                                          ( entity = 'TableZeiv02CANG' table = 'ZTB_EINV_PXKK_CF' )
                                        ) ) ##NO_TEXT.
  ENDMETHOD.
ENDCLASS.
CLASS lhc_zi_zeiv02_cang_s DEFINITION FINAL INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_instance_features FOR INSTANCE FEATURES
        IMPORTING
                  keys   REQUEST requested_features FOR tablezeiv02cangall
        RESULT    result,
      selectcustomizingtransptreq FOR MODIFY
        IMPORTING
                  keys   FOR ACTION tablezeiv02cangall~selectcustomizingtransptreq
        RESULT    result,
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR tablezeiv02cangall
        RESULT result.
ENDCLASS.

CLASS lhc_zi_zeiv02_cang_s IMPLEMENTATION.
  METHOD get_instance_features.
    DATA: edit_flag            TYPE abp_behv_op_ctrl    VALUE if_abap_behv=>fc-o-enabled
         ,transport_feature    TYPE abp_behv_field_ctrl VALUE if_abap_behv=>fc-f-mandatory
         ,selecttransport_flag TYPE abp_behv_op_ctrl    VALUE if_abap_behv=>fc-o-disabled.

    IF keys[ 1 ]-%is_draft = if_abap_behv=>mk-off.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
     iv_objectname = 'ZTB_EINV_PXKK_CF'
     iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    DATA(transport_service) = cl_bcfg_cd_reuse_api_factory=>get_transport_service_instance(
                                iv_objectname = 'ZTB_EINV_PXKK_CF'
                                iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table ).
    IF transport_service->is_transport_allowed( ) = abap_false.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    READ ENTITIES OF zi_zeiv02_cang_s IN LOCAL MODE
    ENTITY tablezeiv02cangall
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(all).
    IF all[ 1 ]-%is_draft = if_abap_behv=>mk-off.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result = VALUE #( (
               %tky = keys[ 1 ]-%tky
               %action-edit = edit_flag
               %assoc-_tablezeiv02cang = edit_flag
               %field-transportrequestid = transport_feature
               %action-selectcustomizingtransptreq = selecttransport_flag ) ).
  ENDMETHOD.
  METHOD selectcustomizingtransptreq.
    MODIFY ENTITIES OF zi_zeiv02_cang_s IN LOCAL MODE
      ENTITY tablezeiv02cangall
        UPDATE FIELDS ( transportrequestid )
        WITH VALUE #( FOR key IN keys
                        ( %tky               = key-%tky
                          transportrequestid = key-%param-transportrequestid
                         ) ).

    READ ENTITIES OF zi_zeiv02_cang_s IN LOCAL MODE
      ENTITY tablezeiv02cangall
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(entities).
    result = VALUE #( FOR entity IN entities
                        ( %tky   = entity-%tky
                          %param = entity ) ).
  ENDMETHOD.
  METHOD get_global_authorizations.
    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZI_ZEIV02_CANG' ID 'ACTVT' FIELD '02'.
    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                                  ELSE if_abap_behv=>auth-unauthorized ).
    result-%update      = is_authorized.
    result-%action-edit = is_authorized.
    result-%action-selectcustomizingtransptreq = is_authorized.
  ENDMETHOD.
*  METHOD edit.
*    CHECK lhc_rap_tdat_cts=>get( )->is_transport_mandatory( ).
*    DATA(transport_request) = lhc_rap_tdat_cts=>get( )->get_transport_request( ).
*    IF transport_request IS NOT INITIAL.
*      MODIFY ENTITY IN LOCAL MODE zi_zeiv02_cang_s
*        EXECUTE selectcustomizingtransptreq FROM VALUE #( ( %is_draft = if_abap_behv=>mk-on
*                                                            singletonid = 1
*                                                            %param-transportrequestid = transport_request ) ).
*      reported-tablezeiv02cangall = VALUE #( ( %is_draft = if_abap_behv=>mk-on
*                                     singletonid = 1
*                                     %msg = mbc_cp_api=>message( )->get_transport_selected( transport_request ) ) ).
*    ENDIF.
*  ENDMETHOD.
ENDCLASS.
CLASS lsc_zi_zeiv02_cang_s DEFINITION FINAL INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS:
      save_modified REDEFINITION,
      cleanup_finalize REDEFINITION.
ENDCLASS.

CLASS lsc_zi_zeiv02_cang_s IMPLEMENTATION.
  METHOD save_modified.
    READ TABLE update-tablezeiv02cangall INDEX 1 INTO DATA(all).
    IF all-transportrequestid IS NOT INITIAL.
      lhc_rap_tdat_cts=>get( )->record_changes(
                                  transport_request = all-transportrequestid
                                  create            = REF #( create )
                                  update            = REF #( update )
                                  delete            = REF #( delete ) )->update_last_changed_date_time( view_entity_name   = 'ZI_ZEIV02_CANG'
                                                                                                        maintenance_object = 'ZBCMO_ZEIV02_CANG' ).
    ENDIF.
  ENDMETHOD.
  METHOD cleanup_finalize ##NEEDED.
  ENDMETHOD.
ENDCLASS.
CLASS lhc_zi_zeiv02_cang DEFINITION FINAL INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_features FOR GLOBAL FEATURES
        IMPORTING
        REQUEST requested_features FOR tablezeiv02cang
        RESULT result,
      validatetransportrequest FOR VALIDATE ON SAVE
        IMPORTING
          keys_tablezeiv02cang FOR tablezeiv02cang~validatetransportrequest.
ENDCLASS.

CLASS lhc_zi_zeiv02_cang IMPLEMENTATION.
  METHOD get_global_features.
    DATA edit_flag TYPE abp_behv_op_ctrl VALUE if_abap_behv=>fc-o-enabled.
    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
        iv_objectname = 'ZTB_EINV_PXKK_CF'
        iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result-%update = edit_flag.
    result-%delete = edit_flag.
  ENDMETHOD.
  METHOD validatetransportrequest.
*    DATA change TYPE REQUEST FOR CHANGE zi_zeiv02_cang_s.
*    IF keys_tablezeiv02cang IS NOT INITIAL.
*      DATA(is_draft) = keys_tablezeiv02cang[ 1 ]-%is_draft.
*    ELSE.
*      RETURN.
*    ENDIF.
*    READ ENTITY IN LOCAL MODE zi_zeiv02_cang_s
*    FROM VALUE #( ( %is_draft = is_draft
*                    singletonid = 1
*                    %control-transportrequestid = if_abap_behv=>mk-on ) )
*    RESULT FINAL(transport_from_singleton).
*    lhc_rap_tdat_cts=>get( )->validate_all_changes(
*                                transport_request     = VALUE #( transport_from_singleton[ 1 ]-transportrequestid OPTIONAL )
*                                table_validation_keys = VALUE #(
*                                                          ( table = 'ZTB_EINV_PXKK_CF' keys = REF #( keys_tablezeiv02cang ) )
*                                                               )
*                                reported              = REF #( reported )
*                                failed                = REF #( failed )
*                                change                = REF #( change ) ).
  ENDMETHOD.
ENDCLASS.
