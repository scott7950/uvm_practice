`ifndef __TEST_SV__
`define __TEST_SV__

`include "simple_env.sv"
`include "simple_sequence.sv"

class base_test extends uvm_test;

simple_env tb_env;
bit test_pass = 1;
uvm_table_printer printer;

`uvm_component_utils(base_test)

function new(string name="base_test", uvm_component parent=null);
    super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    tb_env = simple_env::type_id::create("tb_env", this);
    printer = new();
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);

    `uvm_info(get_type_name(),$sformatf("Printing the test topology :\n%s", this.sprint(printer)), UVM_LOW)

    //`uvm_info("TEST",$psprintf(" TOPOLOGY..............................."),UVM_HIGH);
    //uvm_top.print_topology();
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
endtask

function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
endfunction

function void report_phase(uvm_phase phase);
    super.report_phase(phase);

    if(test_pass) begin
        `uvm_info(get_type_name(), "** UVM TEST PASSED **", UVM_NONE)
    end
    else begin
        `uvm_error(get_type_name(), "** UVM TEST FAIL **")
    end
endfunction

endclass

class test extends base_test;

`uvm_component_utils(test)

function new(string name="test", uvm_component parent=null);
    super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_db#(uvm_sequence_base)::set(this, "tb_env.smp_agt.smp_sqr.main_phase", "default_sequence", send_smp_seq_extension::type_id::create());
endfunction

endclass

`endif

