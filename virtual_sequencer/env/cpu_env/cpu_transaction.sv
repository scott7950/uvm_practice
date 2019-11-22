`ifndef __CPU_TRANSACTION_SV__
`define __CPU_TRANSACTION_SV__

class cpu_transaction extends uvm_sequence_item;

rand logic [7:0 ] addr;

extern function new(string name = "CPU Transaction");

`uvm_object_utils_begin(cpu_transaction)
    `uvm_field_int(addr, UVM_ALL_ON)
`uvm_object_utils_end

function uvm_object clone();
    cpu_transaction tr = new(); 

    tr.copy(this);
    return tr;
endfunction

endclass

function cpu_transaction::new(string name = "CPU Transaction");
    super.new(name);
endfunction

`endif

