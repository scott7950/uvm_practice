`ifndef __ETH_SEQUENCER_SV__
`define __ETH_SEQUENCER_SV__

`include "eth_transaction.sv"

class eth_sequencer extends uvm_sequencer #(eth_transaction);

`uvm_component_utils(eth_sequencer)

function new(string name, uvm_component parent=null);
    super.new(name, parent);
endfunction

endclass

`endif

