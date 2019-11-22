`ifndef __CPU_ENV_SV__
`define __CPU_ENV_SV__

`include "cpu_agent.sv"

class cpu_env extends uvm_env;

cpu_agent      cpu_agt;

virtual cpu_interface cpu_vif;

`uvm_component_utils(cpu_env)

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    cpu_agt = cpu_agent::type_id::create("cpu_agt", this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
endtask

endclass

`endif

