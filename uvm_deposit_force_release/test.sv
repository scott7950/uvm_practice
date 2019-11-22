`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

module test();
reg [7:0] a;
bit clk;

initial begin
  clk = 0;
  forever #1 clk = ~clk;
end

always @(posedge clk) begin
  a <= 'h5a;
end

initial begin
  string hdl_path = "test.a[1]";

  if(uvm_hdl_check_path("test.a")) begin
    $display("path test.a exists");
  end else begin
    $display("path test.a doesn't exist");
  end

  if(uvm_hdl_check_path("test.a[1]")) begin
    $display("path test.a[0] exists");
  end else begin
    $display("path test.a[0] doesn't exist");
  end

  if(uvm_hdl_check_path("test.a[3:2]")) begin
    $display("path test.a[3:2] exists");
  end else begin
    $display("path test.a[3:2] doesn't exist");
  end

  hdl_path = "test.a";
  repeat (10) begin
    logic [7:0] path_data;

    if (!uvm_pkg::uvm_hdl_read(hdl_path, path_data)) begin
      $display("Cannot read signal");
    end
    // uvm_pkg::uvm_hdl_deposit(hdl_path, ~path_data);
    uvm_pkg::uvm_hdl_force(hdl_path, $urandom());
    #10ns;
    uvm_pkg::uvm_hdl_release(hdl_path);
    #10ns;
  end

  hdl_path = "test.a[1]";
  repeat (10) begin
    uvm_hdl_force(hdl_path, $urandom());
    #10ns;
    uvm_hdl_release(hdl_path);
    #10ns;
  end

  hdl_path = "test.a[3:2]";
  repeat (10) begin
    uvm_hdl_force(hdl_path, $urandom());
    #10ns;
    uvm_hdl_release(hdl_path);
    #10ns;
  end
  $finish();
end
endmodule
