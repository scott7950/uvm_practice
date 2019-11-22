
virtual task body();
    uvm_event_pool global_event_pool = global_event_pool.get_global_pool();
    uvm_event seq1_done = global_event_pool.get("seq1_done");
    
    seq1_done.trigger();
    seq_done.wait_trigger();
    
    
    seq1_data.trigger(seq1_data1);
    seq1_data.wait_trigger_data(seq1_data1);
    $cast(seq1_data_cpy, seq1_data1);
endtask
