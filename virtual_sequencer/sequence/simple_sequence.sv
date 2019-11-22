`ifndef _SIMPLE_SEQUENCE_SV__
`define _SIMPLE_SEQUENCE_SV__

`include "simple_virtual_sequencer.sv"

class cpu_sequence extends uvm_sequence #(cpu_transaction);

function new(string name="send_smp_seq");
    super.new(name);
endfunction
  
`uvm_object_utils(cpu_sequence)

virtual task body();
    repeat(5) begin
        `uvm_do_with(req, {req.addr == 10;})
    end
endtask
  
endclass

class eth_sequence extends uvm_sequence #(eth_transaction);

function new(string name="eth_sequence");
    super.new(name);
endfunction
  
`uvm_object_utils(eth_sequence)

virtual task body();
    repeat(2) begin
        `uvm_do_with(req, {req.tx_data == 20;})
    end
endtask
  
endclass

class simple_virt_seq extends uvm_sequence;

function new(string name="simple_virt_seq");
    super.new(name);
    set_automatic_phase_objection(1);
endfunction
  
`uvm_declare_p_sequencer(simple_virtual_sequencer)

`uvm_object_utils(simple_virt_seq)

cpu_sequence cpu_seq;
eth_sequence eth_seq;
//random_traffic_virt_seq rand_virt_seq;

virtual task body();
    `uvm_do_on(cpu_seq, p_sequencer.cpu_sqr)
    `uvm_do_on(eth_seq, p_sequencer.eth_sqr)
    //`uvm_do(rand_virt_seq)
endtask : body

endclass : simple_virt_seq

`endif

