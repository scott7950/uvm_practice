`ifndef __SIMPLE_SCOREBOARD_SV__
`define __SIMPLE_SCOREBOARD_SV__

//m_imp.write() == simple_scoreboard.write()
//
//class uvm_analysis_imp #(type T=int, type IMP=int)
//  extends uvm_port_base #(uvm_tlm_if_base #(T,T));
//  `UVM_IMP_COMMON(`UVM_TLM_ANALYSIS_MASK,"uvm_analysis_imp",IMP)
//  function void write (input T t);
//    m_imp.write (t);
//  endfunction
//endclass

class simple_scoreboard extends uvm_scoreboard;
uvm_analysis_imp #(simple_transaction, simple_scoreboard) drv2sb_port;

`uvm_component_utils(simple_scoreboard)

function new (string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

function void build_phase(uvm_phase phase);
    drv2sb_port = new("drv2sb_port", this);
endfunction

virtual function void write(simple_transaction tr);
    tr.print();
endfunction

endclass

`endif

