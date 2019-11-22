`ifndef __SIMPLE_ENV_SV__
`define __SIMPLE_ENV_SV__

`include "simple_agent.sv"

class simple_env extends uvm_env;

simple_agent      smp_agt;

virtual simple_interface smp_vif;

`uvm_component_utils(simple_env)

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    smp_agt = simple_agent::type_id::create("smp_agt", this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
endtask

endclass

`endif

