`ifndef __SIMPLE_ENV_SV__
`define __SIMPLE_ENV_SV__

`include "simple_agent.sv"

class simple_env extends uvm_env;

simple_agent      smp_agt[];

virtual simple_interface smp_vif;

`uvm_component_utils(simple_env)

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    string inst_name;

    super.build_phase(phase);

    smp_agt = new[10];
    for(int i = 0; i < 10; i++) begin
        $sformat(inst_name, "smp_agt[%0d]", i);
        smp_agt[i] = simple_agent::type_id::create(inst_name, this);
    end

endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
endtask

endclass

`endif

