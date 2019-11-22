import uvm_pkg::*;
`include "uvm_macros.svh"

class simple_trans extends uvm_sequence_item;
  rand int data;

  `uvm_object_utils_begin(simple_trans)
    `uvm_field_int(data, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "");
    super.new(name);
  endfunction: new
endclass

class comp1 extends uvm_component;
  uvm_analysis_port #(simple_trans) mon_port1;
  
  `uvm_component_utils(comp1)
  
  function new(string name = "comp1", uvm_component parent = null);
    super.new(name, parent);
    mon_port1 = new("mon_port1", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    simple_trans tr = simple_trans::type_id::create("tr");

    phase.raise_objection(this);
    repeat(10) begin
      void'(tr.randomize());
      $display("test1: %0h", tr.data);
      mon_port1.write(tr);
      #1;
    end
    phase.drop_objection(this);
  endtask
endclass

class comp2 extends uvm_component;
  uvm_analysis_port #(simple_trans) mon_port2;
  comp1 u_comp1;
  
  `uvm_component_utils(comp2)

  function new(string name = "comp2", uvm_component parent = null);
    super.new(name, parent);
    mon_port2 = new("mon_port2", this);
  endfunction

  virtual function void build_phase ( uvm_phase phase );
    super.build_phase( phase );
    u_comp1 = comp1::type_id::create("u_comp1", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    u_comp1.mon_port1.connect(mon_port2);
  endfunction
endclass

class comp3 extends uvm_component;
  `uvm_analysis_imp_decl(_recv_port)
  uvm_analysis_imp_recv_port#(simple_trans, comp3) mon_port3;

  `uvm_component_utils(comp3)

  function new(string name = "comp3", uvm_component parent = null);
    super.new(name, parent);
    mon_port3 = new("mon_port3", this);
  endfunction

  virtual function void write_recv_port(simple_trans tr);
    $display("test2: %0h", tr.data);
  endfunction
endclass

//----------------
// environment env
//----------------
class env extends uvm_env;
  comp2 u_comp2;
  comp3 u_comp3;
  `uvm_component_utils(env)

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase ( uvm_phase phase );
    super.build_phase( phase );
    u_comp2 = comp2::type_id::create("u_comp2", this);
    u_comp3 = comp3::type_id::create("u_comp3", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    u_comp2.mon_port2.connect(u_comp3.mon_port3);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
  endtask: run_phase
endclass

//-----------
// module top
//-----------
module top;
env u_env;

initial begin
  u_env = new("u_env");
  run_test();
end

endmodule
