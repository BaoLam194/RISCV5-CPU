`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.09.2026 22:02:37
// Design Name: 
// Module Name: test_Wrapper
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

// Mimicthe test_Wrapper_DIP_to_LED file
// File usage Basic_Functionality.asm

`define ERROR(msg) \
    begin \
    $display(""); \
    $display("============================================================"); \
    $display("                    SOME TEST FAILED"); \
    $display("============================================================"); \
    $error("  Instruction check failed: %s",msg); \
    $display("============================================================"); \
    end

module test_Wrapper_BF #(
	   parameter N_LEDs_OUT	= 8,					
	   parameter N_DIPs		= 16,
	   parameter N_PBs		= 3 
	)
	(
	);
	
	// Signals for the Unit Under Test (UUT)
	reg  [N_DIPs-1:0] DIP = 0;		
	reg  [N_PBs-1:0] PB = 0;			
	wire [N_LEDs_OUT-1:0] LED_OUT;
	wire [6:0] LED_PC;			
	wire [31:0] SEVENSEGHEX;	
	wire [7:0] UART_TX;
	reg  UART_TX_ready = 0;
	wire UART_TX_valid;
	reg  [7:0] UART_RX = 0;
	reg  UART_RX_valid = 0;
	wire UART_RX_ack;
	wire OLED_Write;
	wire [6:0] OLED_Col;
	wire [5:0] OLED_Row;
	wire [23:0] OLED_Data;
	reg [31:0] ACCEL_Data;
	wire ACCEL_DReady;			
	reg  RESET = 0;	
	reg  CLK = 0;				
	
	// Instantiate UUT
    Wrapper dut(DIP, PB, LED_OUT, LED_PC, SEVENSEGHEX, UART_TX, UART_TX_ready, UART_TX_valid, UART_RX, UART_RX_valid, UART_RX_ack, OLED_Write, OLED_Col, OLED_Row, OLED_Data, ACCEL_Data, ACCEL_DReady, RESET, CLK) ;

	
	// Note: This testbench is for DIP_to_LED program. Other assembly programs require appropriate modifications.
	// STIMULI
    initial
    begin
        RESET = 1; #10; RESET = 0; //hold reset state for 10 ns.
        
        #80; // the "and" instruction is executed,
        #10; // the "andi" instruction is executed,
        assert(dut.RV1.RegFile1.RegBank[14] === 32'h40) else `ERROR("and instrution is failed");
        #10; // the "or" instruction is executed,
        assert(dut.RV1.RegFile1.RegBank[15] === 32'h58) else `ERROR("andi instrution is failed");
        #10; // the "ori" instruction is executed,
        assert(dut.RV1.RegFile1.RegBank[16] === 32'hfffffff8) else `ERROR("or instrution is failed");
        #10; // the "slt" instruction is executed,
        assert(dut.RV1.RegFile1.RegBank[17] === 32'h404) else `ERROR("ori instrution is failed");
        #10; // the "slt" instruction is executed,
        assert(dut.RV1.RegFile1.RegBank[24] === 32'h1) else `ERROR("slt instrution is failed");
        #10; // the "sltu" instruction is executed,
        assert(dut.RV1.RegFile1.RegBank[25] === 32'h0) else `ERROR("slt instrution is failed");
        #10; // the "sltu" instruction is executed,
        assert(dut.RV1.RegFile1.RegBank[26] === 32'h1) else `ERROR("sltu instrution is failed");
        #10; // the "sltu" instruction is executed,
        assert(dut.RV1.RegFile1.RegBank[27] === 32'h0) else `ERROR("sltu instrution is failed");
	end
	// GENERATE CLOCK       
    always          
    begin
       #5 CLK = ~CLK ; // invert clk every 5 time units 
    end
    
endmodule
