`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2024 06:02:54 PM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipelineProc_testbench(

    );
    
  logic        clk;
  logic        reset;

  logic [31:0] WriteData, DataAdr, IntrF;
  logic        MemWrite;

    logic [1:0]  ForwardAE, ForwardBE;
    logic        StallF, StallD, FlushD, FlushE;
    
  // instantiate device to be tested
  top dut(clk, reset, WriteData, DataAdr, MemWrite, IntrF, ForwardAE, ForwardBE, StallF, StallD, FlushD, FlushE);
  
  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check results
  always @(negedge clk)
    begin
      if(MemWrite) begin
        if(DataAdr === 100 & WriteData === 25) begin
          $display("Simulation succeeded");
          $stop;
        end else if (DataAdr !== 96) begin
          $display("Simulation failed");
          $stop;
        end
      end
    end    
endmodule
