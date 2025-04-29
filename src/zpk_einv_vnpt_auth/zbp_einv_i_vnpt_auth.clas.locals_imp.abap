class lhc_zeinv_i_vnpt_auth definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_instance_authorizations for instance authorization
      importing keys request requested_authorizations for zeinv_i_vnpt_auth result result.

endclass.

class lhc_zeinv_i_vnpt_auth implementation.

  method get_instance_authorizations.
  endmethod.

endclass.
