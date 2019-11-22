`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "test.sv"

module top;

initial begin
    run_test();
end

`ifdef WAVE_ON
initial begin
    //$dumpfile("wave.vcd");
    //$dumpvars(0, top);
end
`endif

endmodule

