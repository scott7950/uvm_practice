`ifndef __ETH_ENV_SV__
`define __ETH_ENV_SV__

`include "eth_agent.sv"

class eth_env extends uvm_env;

eth_agent      eth_agt;

virtual eth_interface eth_vif;

`uvm_component_utils(eth_env)

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    eth_agt = eth_agent::type_id::create("eth_agt", this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
endtask

endclass

`endif

