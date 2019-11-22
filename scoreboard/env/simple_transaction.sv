`ifndef __SIMPLE_TRANSACTION_SV__
`define __SIMPLE_TRANSACTION_SV__

class simple_transaction extends uvm_sequence_item;

rand logic [7:0 ] data;

constraint con_data {data >=10; data<=20;};

extern function new(string name = "simple Transaction");

`uvm_object_utils_begin(simple_transaction)
    //`uvm_field_int(data, UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(data, UVM_ALL_ON)
`uvm_object_utils_end

function uvm_object clone();
    simple_transaction tr = new(); 

    tr.copy(this);
    return tr;
endfunction

//function void do_copy (uvm_object rhs);
//    simple_transaction rhs_;
//    super.do_copy(rhs);
//
//    $cast(rhs_, rhs);
//
//    data = rhs_.data;
//endfunction

endclass

function simple_transaction::new(string name = "simple Transaction");
    super.new(name);
endfunction

`endif

