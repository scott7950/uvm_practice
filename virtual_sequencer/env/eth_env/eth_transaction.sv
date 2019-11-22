`ifndef __ETH_TRANSACTION_SV__
`define __ETH_TRANSACTION_SV__

class eth_transaction extends uvm_sequence_item;

rand logic [7:0 ] tx_data;

extern function new(string name = "ETH Transaction");

`uvm_object_utils_begin(eth_transaction)
    `uvm_field_int(tx_data, UVM_ALL_ON)
`uvm_object_utils_end

function uvm_object clone();
    eth_transaction tr = new(); 

    tr.copy(this);
    return tr;
endfunction

endclass

function eth_transaction::new(string name = "ETH Transaction");
    super.new(name);
endfunction

`endif

