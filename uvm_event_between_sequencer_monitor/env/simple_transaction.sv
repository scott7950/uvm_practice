`ifndef __SIMPLE_TRANSACTION_SV__
`define __SIMPLE_TRANSACTION_SV__

class simple_transaction extends uvm_sequence_item;

rand logic [7:0 ] cnt;

extern function new(string name = "simple Transaction");

`uvm_object_utils_begin(simple_transaction)
    `uvm_field_int(cnt, UVM_ALL_ON)
`uvm_object_utils_end

function uvm_object clone();
    simple_transaction tr = new(); 

    tr.copy(this);
    return tr;
endfunction

endclass

function simple_transaction::new(string name = "simple Transaction");
    super.new(name);
endfunction

`endif

