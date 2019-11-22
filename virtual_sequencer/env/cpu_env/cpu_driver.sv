`ifndef __CPU_DRIVER_SV__
`define __CPU_DRIVER_SV__

`include "cpu_transaction.sv"

class cpu_driver extends uvm_driver #(cpu_transaction);

`uvm_component_utils(cpu_driver)

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

function cpu_driver::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void cpu_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction

task cpu_driver::main_phase(uvm_phase phase);
    super.main_phase(phase);

    `uvm_info(get_full_name(),$sformatf(" CPU Driver"), UVM_MEDIUM)

    fork
        get_and_drive();
    join
endtask

`endif

