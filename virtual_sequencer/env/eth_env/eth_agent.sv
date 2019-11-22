`ifndef __ETH_AGENT_SV__
`define __ETH_AGENT_SV__

`include "eth_sequencer.sv"
`include "eth_driver.sv"

class eth_agent extends uvm_agent;
eth_sequencer eth_sqr;
eth_driver    eth_drv;

`uvm_component_utils_begin(eth_agent)
    `uvm_field_object(eth_sqr, UVM_ALL_ON)
    `uvm_field_object(eth_drv, UVM_ALL_ON)
`uvm_component_utils_end

function new(string name, uvm_component parent = null);
    super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
    eth_sqr = eth_sequencer::type_id::create("eth_sqr", this);
    eth_drv = eth_driver::type_id::create("eth_drv", this);
endfunction

virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    eth_drv.seq_item_port.connect(eth_sqr.seq_item_export);
endfunction

endclass

`endif

