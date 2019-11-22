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

class send_smp_seq1 extends simple_sequence;

rand logic [7:0] data;

function new(string name="send_smp_seq1");
    super.new(name);
endfunction
  
`uvm_object_utils(send_smp_seq1)

virtual task body();
    `uvm_do_with(req, {req.data == local::data;})
endtask
  
endclass

class send_smp_seq_extension extends simple_sequence;

send_smp_seq u_send_smp_seq;
send_smp_seq1 u_send_smp_seq1;

function new(string name="send_smp_seq_extension");
    super.new(name);
endfunction
  
`uvm_object_utils(send_smp_seq_extension)

virtual task body();
    repeat(2) begin
        `uvm_do_with(u_send_smp_seq, {u_send_smp_seq.send_smp_seq_data == 10;})
        `uvm_do_with(u_send_smp_seq1, {u_send_smp_seq1.data == 20;})
    end
endtask
  
endclass

class simple_seq_remove_orig_constraint extends simple_sequence;
rand int num_trans;
constraint c1 {num_trans >= 1; num_trans <= 3;};

function new(string name="simple_seq_remove_orig_constraint");
    super.new(name);
endfunction
  
`uvm_object_utils(simple_seq_remove_orig_constraint)

task do_rw();
    req = simple_transaction::type_id::create("simple item", , get_full_name());
    req.con_data.constraint_mode(0);
    //req.data.rand_mode(0);

    start_item(req);
    randomize(req);
    finish_item(req);
endtask

virtual task body();
    repeat (num_trans) begin
        do_rw();
    end
endtask

endclass

`endif

