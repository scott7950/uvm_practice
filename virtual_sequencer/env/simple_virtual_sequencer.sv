`ifndef __SIMPLE_VIRTUAL_SEQUENCER_SV__
`define __SIMPLE_VIRTUAL_SEQUENCER_SV__

`include "cpu_sequencer.sv";
`include "eth_sequencer.sv";

class simple_virtual_sequencer extends uvm_sequencer;
eth_sequencer eth_sqr;
cpu_sequencer cpu_sqr;

// UVM automation macros for sequencers
`uvm_component_utils(simple_virtual_sequencer)

// Constructor
function new(input string name="simple_virtual_sequencer", input uvm_component parent=null);
    super.new(name, parent);
endfunction

endclass: simple_virtual_sequencer

`endif

