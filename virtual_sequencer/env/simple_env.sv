`ifndef __SIMPLE_ENV_SV__
`define __SIMPLE_ENV_SV__

`include "cpu_env.sv"
`include "eth_env.sv"
`include "simple_virtual_sequencer.sv"

class simple_env extends uvm_env;
cpu_env cpu0; 
eth_env eth0;
simple_virtual_sequencer v_sqr;

`uvm_component_utils(simple_env)

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

// Constructor and UVM automation macros
virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Build envs with subsequencers.
    cpu0 = cpu_env::type_id::create("cpu0", this);
    eth0 = eth_env::type_id::create("eth0", this);

    // Build the virtual sequencer.
    v_sqr = simple_virtual_sequencer::type_id::create("v_sqr", this);
endfunction : build_phase

// Connect virtual sequencer to subsequencers.
function void connect();
    v_sqr.cpu_sqr = cpu0.cpu_agt.cpu_sqr;
    v_sqr.eth_sqr = eth0.eth_agt.eth_sqr;
endfunction : connect

endclass: simple_env

`endif

