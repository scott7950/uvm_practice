`ifndef _SIMPLE_SEQUENCE_SV__
`define _SIMPLE_SEQUENCE_SV__

virtual class simple_sequence extends uvm_sequence #(simple_transaction);

function new(string name="simple_sequence");
    super.new(name);
    set_automatic_phase_objection(1);
endfunction
  
endclass

class send_smp_seq extends simple_sequence;

function new(string name="send_smp_seq");
    super.new(name);
endfunction
  
`uvm_object_utils(send_smp_seq)

virtual task body();
    uvm_table_printer printer = new();
    do_print(printer);
    repeat(10) begin
        `uvm_do(req)
    end
endtask
  
endclass

`endif

