`ifndef __SIMPLE_DRIVER_SV__
`define __SIMPLE_DRIVER_SV__

`include "simple_transaction.sv"
`include "simple_interface.svi"

class simple_driver extends uvm_driver #(simple_transaction);

protected virtual simple_interface smp_vif;

`uvm_component_utils(simple_driver)

extern function new(string name, uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task main_phase(uvm_phase phase);

virtual task reset_phase(uvm_phase phase);
    super.reset_phase(phase);

    phase.raise_objection(this);

    smp_vif.cb.addr   <= 'h0;
    smp_vif.cb.rw     <= 1'b0;
    smp_vif.cb.din    <= 'h0;
    @(posedge smp_vif.rst_n);
    repeat(10) @(smp_vif.cb);

    phase.drop_objection(this);
endtask;

virtual protected task get_and_drive();

    forever begin
        //as there is an uvm_event sync between monitor and sequencer
        //if put the waiting for the event in get_next_item of the seuqencer, it will block the first transaction
        //if using a variable to skip the first one, the last interrupt will not captured as there is no more sequence
        //so put the waiting in the get_next_item, but use peek to get the transcation

        //seq_item_port.get_next_item(req);
        seq_item_port.peek(req);
        req.print();

        @smp_vif.cb;
        smp_vif.cb.addr <= 'h4;
        smp_vif.cb.din <= req.cnt;
        smp_vif.cb.rw <= 1'b1;

        @smp_vif.cb;
        smp_vif.cb.addr <= 'h0;
        smp_vif.cb.din <= 8'h1;
        smp_vif.cb.rw <= 1'b1;

        @smp_vif.cb;
        smp_vif.cb.rw <= 1'b0;

        `uvm_info(get_full_name(), $sformatf(" timer counter is configured"), UVM_MEDIUM)

        seq_item_port.get_next_item(req);
        seq_item_port.item_done();
    end
endtask

endclass

function simple_driver::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void simple_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(virtual simple_interface)::get(this, "", "smp_vif", smp_vif)) begin
        `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".smp_vif"});
    end
endfunction

task simple_driver::main_phase(uvm_phase phase);
    super.main_phase(phase);

    `uvm_info(get_full_name(),$sformatf(" simple Driver"), UVM_MEDIUM)

    fork
        get_and_drive();
    join
endtask

`endif

