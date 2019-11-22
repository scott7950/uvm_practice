`ifndef __SIMPLE_SEQUENCER_SV__
`define __SIMPLE_SEQUENCER_SV__

`include "simple_transaction.sv"

class simple_sequencer extends uvm_sequencer #(simple_transaction);

uvm_event intr_triggered;

`uvm_component_utils(simple_sequencer)

function new(string name, uvm_component parent=null);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_db#(uvm_event)::get(this, "", "intr_triggered", intr_triggered);
    if(intr_triggered == null) begin
        `uvm_fatal(get_name(), "intr_triggered must be set in uvm_config_db")
    end

endfunction

virtual task get_next_item (output simple_transaction t);
    super.get_next_item(t);

    intr_triggered.wait_trigger();
endtask

endclass

`endif

