CLASS LHC_RAP_TDAT_CTS DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS:
      GET
        RETURNING
          VALUE(RESULT) TYPE REF TO IF_MBC_CP_RAP_TDAT_CTS.

ENDCLASS.

CLASS LHC_RAP_TDAT_CTS IMPLEMENTATION.
  METHOD GET.
    result = mbc_cp_api=>rap_tdat_cts( tdat_name = 'ZEINV_DEBCRE'
                                       table_entity_relations = VALUE #(
                                         ( entity = 'MappingDebitCredit' table = 'ZEINV_TB_DEBCRE' )
                                       ) ) ##NO_TEXT.
  ENDMETHOD.
ENDCLASS.
CLASS LHC_ZEINV_I_DEBCRE_S DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR MapDebCre
        RESULT result,
      SELECTCUSTOMIZINGTRANSPTREQ FOR MODIFY
        IMPORTING
          KEYS FOR ACTION MapDebCre~SelectCustomizingTransptReq
        RESULT result,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR MapDebCre
        RESULT result.
ENDCLASS.

CLASS LHC_ZEINV_I_DEBCRE_S IMPLEMENTATION.
  METHOD GET_INSTANCE_FEATURES.
    DATA: selecttransport_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled,
          edit_flag            TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.

    IF lhc_rap_tdat_cts=>get( )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    IF lhc_rap_tdat_cts=>get( )->is_transport_allowed( ) = abap_false.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    READ ENTITIES OF ZEINV_I_DEBCRE_S IN LOCAL MODE
    ENTITY MapDebCre
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(all).
    IF all[ 1 ]-%IS_DRAFT = if_abap_behv=>mk-off.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result = VALUE #( (
               %TKY = all[ 1 ]-%TKY
               %ACTION-edit = edit_flag
               %ASSOC-_MappingDebitCredit = edit_flag
               %ACTION-SelectCustomizingTransptReq = selecttransport_flag ) ).
  ENDMETHOD.
  METHOD SELECTCUSTOMIZINGTRANSPTREQ.
    MODIFY ENTITIES OF ZEINV_I_DEBCRE_S IN LOCAL MODE
      ENTITY MapDebCre
        UPDATE FIELDS ( TransportRequestID HideTransport )
        WITH VALUE #( FOR key IN keys
                        ( %TKY               = key-%TKY
                          TransportRequestID = key-%PARAM-transportrequestid
                          HideTransport      = abap_false ) ).

    READ ENTITIES OF ZEINV_I_DEBCRE_S IN LOCAL MODE
      ENTITY MapDebCre
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(entities).
    result = VALUE #( FOR entity IN entities
                        ( %TKY   = entity-%TKY
                          %PARAM = entity ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZEINV_I_DEBCRE' ID 'ACTVT' FIELD '02'.
    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                                  ELSE if_abap_behv=>auth-unauthorized ).
    result-%UPDATE      = is_authorized.
    result-%ACTION-Edit = is_authorized.
    result-%ACTION-SelectCustomizingTransptReq = is_authorized.
  ENDMETHOD.
ENDCLASS.
CLASS LSC_ZEINV_I_DEBCRE_S DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_SAVER.
  PROTECTED SECTION.
    METHODS:
      SAVE_MODIFIED REDEFINITION,
      CLEANUP_FINALIZE REDEFINITION.
ENDCLASS.

CLASS LSC_ZEINV_I_DEBCRE_S IMPLEMENTATION.
  METHOD SAVE_MODIFIED.
    READ TABLE update-MapDebCre INDEX 1 INTO DATA(all).
    IF all-TransportRequestID IS NOT INITIAL.
      lhc_rap_tdat_cts=>get( )->record_changes(
                                  transport_request = all-TransportRequestID
                                  create            = REF #( create )
                                  update            = REF #( update )
                                  delete            = REF #( delete ) )->update_last_changed_date_time( view_entity_name   = 'ZEINV_I_DEBCRE'
                                                                                                        maintenance_object = 'ZEINV_DEBCRE' ).
    ENDIF.
  ENDMETHOD.
  METHOD CLEANUP_FINALIZE ##NEEDED.
  ENDMETHOD.
ENDCLASS.
CLASS LHC_ZEINV_I_DEBCRE DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_FEATURES FOR GLOBAL FEATURES
        IMPORTING
          REQUEST REQUESTED_FEATURES FOR MappingDebitCredit
        RESULT result,
      COPYMAPPINGDEBITCREDIT FOR MODIFY
        IMPORTING
          KEYS FOR ACTION MappingDebitCredit~CopyMappingDebitCredit,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR MappingDebitCredit
        RESULT result,
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR MappingDebitCredit
        RESULT result,
      VALIDATETRANSPORTREQUEST FOR VALIDATE ON SAVE
        IMPORTING
          KEYS_MAPPINGDEBITCREDIT FOR MappingDebitCredit~ValidateTransportRequest.
ENDCLASS.

CLASS LHC_ZEINV_I_DEBCRE IMPLEMENTATION.
  METHOD GET_GLOBAL_FEATURES.
    DATA edit_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.
    IF lhc_rap_tdat_cts=>get( )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result-%UPDATE = edit_flag.
    result-%DELETE = edit_flag.
  ENDMETHOD.
  METHOD COPYMAPPINGDEBITCREDIT.
    DATA new_MappingDebitCredit TYPE TABLE FOR CREATE ZEINV_I_DEBCRE_S\_MappingDebitCredit.

    IF lines( keys ) > 1.
      INSERT mbc_cp_api=>message( )->get_select_only_one_entry( ) INTO TABLE reported-%other.
      failed-MappingDebitCredit = VALUE #( FOR fkey IN keys ( %TKY = fkey-%TKY ) ).
      RETURN.
    ENDIF.

    READ ENTITIES OF ZEINV_I_DEBCRE_S IN LOCAL MODE
      ENTITY MappingDebitCredit
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(ref_MappingDebitCredit)
        FAILED DATA(read_failed).

    IF ref_MappingDebitCredit IS NOT INITIAL.
      ASSIGN ref_MappingDebitCredit[ 1 ] TO FIELD-SYMBOL(<ref_MappingDebitCredit>).
      DATA(key) = keys[ KEY draft %TKY = <ref_MappingDebitCredit>-%TKY ].
      DATA(key_cid) = key-%CID.
      APPEND VALUE #(
        %TKY-SingletonID = 1
        %IS_DRAFT = <ref_MappingDebitCredit>-%IS_DRAFT
        %TARGET = VALUE #( (
          %CID = key_cid
          %IS_DRAFT = <ref_MappingDebitCredit>-%IS_DRAFT
          %DATA = CORRESPONDING #( <ref_MappingDebitCredit> EXCEPT
          SingletonID
        ) ) )
      ) TO new_MappingDebitCredit ASSIGNING FIELD-SYMBOL(<new_MappingDebitCredit>).
      <new_MappingDebitCredit>-%TARGET[ 1 ]-Type = key-%PARAM-Type.

      MODIFY ENTITIES OF ZEINV_I_DEBCRE_S IN LOCAL MODE
        ENTITY MapDebCre CREATE BY \_MappingDebitCredit
        FIELDS (
                 Type
                 Description
                 Einvoicequanity
                 Netpricebeforediscount
                 Netpriceafterdiscount
                 Amountbeforetax
                 Taxamount
                 Amountaftertax
               ) WITH new_MappingDebitCredit
        MAPPED DATA(mapped_create)
        FAILED failed
        REPORTED reported.

      mapped-MappingDebitCredit = mapped_create-MappingDebitCredit.
    ENDIF.

    INSERT LINES OF read_failed-MappingDebitCredit INTO TABLE failed-MappingDebitCredit.

    IF failed-MappingDebitCredit IS INITIAL.
      reported-MappingDebitCredit = VALUE #( FOR created IN mapped-MappingDebitCredit (
                                                 %CID = created-%CID
                                                 %ACTION-CopyMappingDebitCredit = if_abap_behv=>mk-on
                                                 %MSG = mbc_cp_api=>message( )->get_item_copied( )
                                                 %PATH-MapDebCre-%IS_DRAFT = created-%IS_DRAFT
                                                 %PATH-MapDebCre-SingletonID = 1 ) ).
    ENDIF.
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZEINV_I_DEBCRE' ID 'ACTVT' FIELD '02'.
    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                                  ELSE if_abap_behv=>auth-unauthorized ).
    result-%ACTION-CopyMappingDebitCredit = is_authorized.
  ENDMETHOD.
  METHOD GET_INSTANCE_FEATURES.
    result = VALUE #( FOR row IN keys ( %TKY = row-%TKY
                                        %ACTION-CopyMappingDebitCredit = COND #( WHEN row-%IS_DRAFT = if_abap_behv=>mk-off THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled )
    ) ).
  ENDMETHOD.
  METHOD VALIDATETRANSPORTREQUEST.
    DATA change TYPE REQUEST FOR CHANGE ZEINV_I_DEBCRE_S.
    IF keys_MappingDebitCredit IS NOT INITIAL.
      DATA(is_draft) = keys_MappingDebitCredit[ 1 ]-%IS_DRAFT.
    ELSE.
      RETURN.
    ENDIF.
    READ ENTITY IN LOCAL MODE ZEINV_I_DEBCRE_S
    FROM VALUE #( ( %IS_DRAFT = is_draft
                    SingletonID = 1
                    %CONTROL-TransportRequestID = if_abap_behv=>mk-on ) )
    RESULT FINAL(transport_from_singleton).
    IF lines( transport_from_singleton ) = 1.
      DATA(transport_request) = transport_from_singleton[ 1 ]-TransportRequestID.
    ENDIF.
    lhc_rap_tdat_cts=>get( )->validate_all_changes(
                                transport_request     = transport_request
                                table_validation_keys = VALUE #(
                                                          ( table = 'ZEINV_TB_DEBCRE' keys = REF #( keys_MappingDebitCredit ) )
                                                               )
                                reported              = REF #( reported )
                                failed                = REF #( failed )
                                change                = REF #( change ) ).
  ENDMETHOD.
ENDCLASS.
