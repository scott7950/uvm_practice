import uvm_pkg::*;
`include "uvm_macros.svh"
class simple_comp extends uvm_component;
  int a;
  `uvm_component_utils(simple_comp)

  function new(string name = "simple_comp", uvm_component parent = null);
    super.new (name, parent);
  endfunction
endclass

class simple_virtual_sequencer extends uvm_sequencer;
  simple_virtual_sequencer m_sqr;
  simple_comp m_comp1;
  simple_comp m_comp2;

  `uvm_component_utils_begin(simple_virtual_sequencer)
    `uvm_field_object(m_comp1, UVM_DEFAULT | UVM_REFERENCE)
    // UVM_ERROR uvm-1.1d/src/base/uvm_component.svh(2037) @ 0: uvm_test_top.m_env.m_comp2 [ILLCLN] 
    // Attempting to clone 'uvm_test_top.m_env.m_comp2'.  Clone cannot be called on a uvm_component.  
    // The clone target variable will be set to null.
    // `uvm_field_object(m_comp2, UVM_DEFAULT)
  `uvm_component_utils_end

  function new(string name = "simple_virtual_sequencer", uvm_component parent = null);
    super.new (name, parent);
  endfunction
endclass

class simple_tb_env extends uvm_env;
  simple_virtual_sequencer m_sqr;
  simple_virtual_sequencer m_wrapper_sqr;

  simple_comp m_comp1;
  simple_comp m_comp2;

  `uvm_component_utils(simple_tb_env)

  function new(string name = "simple_tb_env", uvm_component parent = null);
    super.new (name, parent);
  endfunction

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    m_sqr = simple_virtual_sequencer::type_id::create("m_sqr", this);
    m_wrapper_sqr = simple_virtual_sequencer::type_id::create("m_wrapper_sqr", this);

    m_comp1 = simple_comp::type_id::create("m_comp1", this);
    m_comp2 = simple_comp::type_id::create("m_comp2", this);
  endfunction

  virtual function void connect_phase (uvm_phase phase);
    super.connect_phase (phase);

    m_sqr.m_comp1 = m_comp1;
    m_sqr.m_comp2 = m_comp2;

    m_wrapper_sqr.copy(m_sqr);

    m_wrapper_sqr.m_sqr = m_sqr;
    m_sqr.m_sqr = m_wrapper_sqr;
  endfunction
endclass

class seq1 extends uvm_sequence;
  `uvm_declare_p_sequencer(simple_virtual_sequencer)

  `uvm_object_utils(seq1)

  function new( string name="seq1");
    super.new( name);
  endfunction : new

  virtual task body();
    if( starting_phase != null)
      starting_phase.raise_objection( this);

    $display("test1");
    wait (0);
    $display("test2");

    if( starting_phase != null)
      starting_phase.drop_objection( this);
  endtask
endclass

class seq2 extends uvm_sequence;
  `uvm_declare_p_sequencer(simple_virtual_sequencer)

  `uvm_object_utils(seq2)

  function new( string name="seq2");
    super.new( name);
  endfunction : new

  virtual task body();
    if( starting_phase != null)
      starting_phase.raise_objection( this);

    $display("test3");
    #10ns;
    p_sequencer.m_sqr.stop_sequences();
    #10ns;
    $display("test4");

    p_sequencer.m_comp1.a = 10;
    // p_sequencer.m_comp2.a = 20;
    $display("test5: comp1::a: %0d, %0d", p_sequencer.m_comp1.a, p_sequencer.m_sqr.m_comp1.a);
    $display("test6: comp2::a: %0d", p_sequencer.m_sqr.m_comp2.a);

    p_sequencer.m_sqr.m_comp1.a = 30;
    p_sequencer.m_sqr.m_comp2.a = 40;
    $display("test7: comp1::a: %0d, %0d", p_sequencer.m_comp1.a, p_sequencer.m_sqr.m_comp1.a);
    $display("test8: comp2::a: %0d", p_sequencer.m_sqr.m_comp2.a);

    if( starting_phase != null)
      starting_phase.drop_objection( this);
  endtask
endclass

class simple_test extends uvm_test;
  simple_tb_env m_env;

  `uvm_component_utils(simple_test)

  function new(string name = "simple_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    m_env = simple_tb_env::type_id::create("m_env", this);
    uvm_config_db#(uvm_object_wrapper)::set(this, "m_env.m_sqr.main_phase", "default_sequence", seq1::get_type());
    uvm_config_db#(uvm_object_wrapper)::set(this, "m_env.m_wrapper_sqr.run_phase", "default_sequence", seq2::get_type());
  endfunction
endclass

module tb;
initial begin
  run_test("simple_test");
end
endmodule
