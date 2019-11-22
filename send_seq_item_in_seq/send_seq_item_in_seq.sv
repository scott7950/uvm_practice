//1. Create
//2. Synchronize with sequencer
//3. pre_do
//4. Randomize
//5. mid_do
//6. Post synchronization/body execution
//7. post_do

`uvm_do // all 7 steps
`uvm_do_with // all 7 steps
`uvm_create // step 1
`uvm_send // steps 2~7
`uvm_rand_send // steps 2~7
`uvm_rand_send_with // steps 2~7

class new_seq_item extends uvm_sequence_item;
...
endclass

new_seq_item seq;
uvm_sequence_item rsp;

start_item(seq, -1, p_sequencer.sqr1);
finish_item(seq);
get_response(rsp, seq.get_transaction_id());

`uvm_create(seq)
`uvm_send(seq)

`uvm_create_on(seq, p_sequencer.sqr1)
`uvm_send(seq)
