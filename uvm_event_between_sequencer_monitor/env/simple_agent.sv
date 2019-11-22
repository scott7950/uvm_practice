`ifndef __SIMPLE_AGENT_SV__
`define __SIMPLE_AGENT_SV__

`include "simple_sequencer.sv"
`include "simple_driver.sv"
`include "simple_monitor.sv"

class simple_agent extends uvm_agent;
simple_sequencer smp_sqr;
simple_driver    smp_drv;
simple_monitor   smp_mon;

uvm_event intr_triggered;

`uvm_component_utils_begin(simple_agent)
    `uvm_field_object(smp_sqr, UVM_ALL_ON)
    `uvm_field_object(smp_drv, UVM_ALL_ON)
    `uvm_field_object(smp_mon, UVM_ALL_ON)
`uvm_component_utils_end

function new(string name, uvm_component parent = null);
    super.new(name, parent);

    intr_triggered = new();
    uvm_config_db#(uvm_event)::set(this, "*", "intr_triggered", intr_triggered);
endfunction

virtual function void build_phase(uvm_phase phase);
    smp_sqr = simple_sequencer::type_id::create("smp_sqr", this);
    smp_drv = simple_driver::type_id::create("smp_drv", this);
    smp_mon = simple_monitor::type_id::create("smp_mon", this);
endfunction

virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    smp_drv.seq_item_port.connect(smp_sqr.seq_item_export);
endfunction

endclass

`endif

