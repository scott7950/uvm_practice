`ifndef _SIMPLE_SEQUENCE_SV__
`define _SIMPLE_SEQUENCE_SV__

virtual class simple_sequence extends uvm_sequence #(simple_transaction);

function new(string name="simple_sequence");
    super.new(name);
    set_automatic_phase_objection(1);
endfunction
  
endclass

class send_smp_seq extends simple_sequence;

//variable name send_smp_seq.send_smp_seq_data should be different from req.data
//otherwise randomization will have random data
rand logic [7:0] send_smp_seq_data;

function new(string name="send_smp_seq");
    super.new(name);
endfunction
  
`uvm_object_utils(send_smp_seq)

virtual task body();
    `uvm_do_with(req, {req.data == send_smp_seq_data;})
endtask
  
endclass

class send_smp_seq_extension extends simple_sequence;

send_smp_seq u_send_smp_seq;

function new(string name="send_smp_seq_extension");
    super.new(name);
endfunction
  
`uvm_object_utils(send_smp_seq_extension)

virtual task body();
    repeat(10) begin
        `uvm_do_with(u_send_smp_seq, {u_send_smp_seq.send_smp_seq_data == 10;})
    end
endtask
  
endclass

`endif

