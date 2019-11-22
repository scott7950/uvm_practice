`ifndef __SIMPLE_DRIVER_SV__
`define __SIMPLE_DRIVER_SV__

`include "simple_transaction.sv"

class simple_driver extends uvm_driver #(simple_transaction);

`uvm_component_utils(simple_driver)

extern function new(string name, uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task main_phase(uvm_phase phase);

virtual protected task get_and_drive();

    forever begin
        seq_item_port.get_next_item(req);
        req.print();

        seq_item_port.item_done();
    end
endtask

endclass

function simple_driver::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void simple_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction

task simple_driver::main_phase(uvm_phase phase);
    super.main_phase(phase);

    `uvm_info(get_full_name(),$sformatf(" simple Driver"), UVM_MEDIUM)

    fork
        get_and_drive();
    join
endtask

`endif

