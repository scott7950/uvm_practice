`ifndef __SIMPLE_DRIVER_EXTENSION_SV__
`define __SIMPLE_DRIVER_EXTENSION_SV__

`include "simple_transaction.sv"

class simple_driver_extension extends simple_driver;

`uvm_component_utils(simple_driver_extension)

extern function new(string name, uvm_component parent);

virtual protected task get_and_drive();

    forever begin
        seq_item_port.get_next_item(req);
        req.print();

        `uvm_info(get_type_name(), "** In the Driver Extension **", UVM_NONE)

        seq_item_port.item_done();
        //seq_item_port.put_response(rsp);
        //rsp_port.write(rsp);

    end
endtask

endclass

function simple_driver_extension::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

`endif

