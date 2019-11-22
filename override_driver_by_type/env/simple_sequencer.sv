`ifndef __SIMPLE_SEQUENCER_SV__
`define __SIMPLE_SEQUENCER_SV__

`include "simple_transaction.sv"

class simple_sequencer extends uvm_sequencer #(simple_transaction);

`uvm_component_utils(simple_sequencer)

function new(string name, uvm_component parent=null);
    super.new(name, parent);
endfunction

endclass

`endif

