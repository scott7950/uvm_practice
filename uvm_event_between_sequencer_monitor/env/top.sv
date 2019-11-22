`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "test.sv"
`include "simple_interface.svi"

module top;

logic clk;
logic rst_n;

simple_interface smp_vif(clk, rst_n);

rtl u_rtl(
    .rst_n (rst_n        ) ,
    .clk   (clk          ) ,
    .addr  (smp_vif.addr ) ,
    .rw    (smp_vif.rw   ) ,
    .din   (smp_vif.din  ) ,
    .intr  (smp_vif.intr )  
);

initial begin
    clk = 1'b0;
    forever begin
        #10 clk = ~clk;
    end
end

initial begin
    rst_n <= 1'b1;
    repeat(10) @(posedge clk);
    rst_n <= 1'b0;
    repeat(10) @(posedge clk);
    rst_n <= 1'b1;
end

initial begin
    run_test();
end

initial begin
    uvm_config_db#(virtual simple_interface)::set(uvm_root::get(), "*", "smp_vif", smp_vif);
end

`ifdef WAVE_ON
initial begin
    //$dumpfile("wave.vcd");
    //$dumpvars(0, top);
end
`endif

endmodule

