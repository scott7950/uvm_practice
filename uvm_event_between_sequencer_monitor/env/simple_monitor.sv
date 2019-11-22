`ifndef __SIMPLE_MONITOR_SV__
`define __SIMPLE_MONITOR_SV__

`include "simple_interface.svi"
`include "simple_transaction.sv"

class simple_monitor extends uvm_monitor;

virtual simple_interface smp_vif;
uvm_event intr_triggered;

`uvm_component_utils(simple_monitor)

function new (string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(virtual simple_interface)::get(this, "", "smp_vif", smp_vif)) begin
        `uvm_fatal("NOVIF",{"virtual interface must be set for: ", get_full_name(), ".smp_vif"});
    end

    uvm_config_db#(uvm_event)::get(this, "", "intr_triggered", intr_triggered);
    if(intr_triggered == null) begin
        `uvm_fatal(get_name(), "intr_triggered must be set in uvm_config_db")
    end

endfunction

virtual protected task collect_transactions();
    forever begin
        @smp_vif.cb;
        if(smp_vif.cb.intr == 1'b1) begin
            `uvm_info(get_full_name(), $sformatf(" intr_triggered is triggered"), UVM_MEDIUM)
            intr_triggered.trigger();
        end
    end
endtask
  
virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);

    fork
        collect_transactions();
    join
endtask

virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
endfunction

endclass

`endif

