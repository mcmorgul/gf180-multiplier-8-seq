`default_nettype none
// update this to the name of your module
module wrapped_multiplier_8(
`ifdef USE_POWER_PINS
    inout vdd,	// User area 1 1.8V supply
    inout vss,	// User area 1 digital ground
`endif
    // interface as user_proj_example.v
    input wire wb_clk_i,
    input wire wb_rst_i,

    // Logic Analyzer Signals
    // only provide first 32 bits to reduce wiring congestion

    input  wire [`MPRJ_IO_PADS-1:0] io_in,
    output wire [`MPRJ_IO_PADS-1:0] io_out,
    output wire [`MPRJ_IO_PADS-1:0] io_oeb,

);

    // permanently set oeb so that outputs are always enabled: 0 is output, 1 is high-impedance
    // assign io_oeb = {`MPRJ_IO_PADS{1'b0}}; //38 zeros

    assign io_oeb[`MPRJ_IO_PADS-25:`MPRJ_IO_PADS-32] = {8{1'b1}}; //8 ones
    assign io_oeb[`MPRJ_IO_PADS-17:`MPRJ_IO_PADS-24] = {8{1'b1}}; //8 ones
    assign io_oeb[`MPRJ_IO_PADS-1:`MPRJ_IO_PADS-16] = {16{1'b0}}; //16 zeros

    wire reset = wb_rst_i;

    // module boothmul_8x8_signed(input signed[7:0]a,b,output signed [15:0] c);
    
    // wire in1, in2, out;

    // assign out = io_out[`MPRJ_IO_PADS-1:`MPRJ_IO_PADS-16]; // 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22
    // assign in2 = io_in[`MPRJ_IO_PADS-17:`MPRJ_IO_PADS-24]; // 21 20 19 18 17 16 15 14
    // assign in1 = io_in[`MPRJ_IO_PADS-25:`MPRJ_IO_PADS-32]; // 13 12 11 10 9 8 7 6 
    

    boothmul_8x8_signed boothmul_8x8_signed_1(.clk(wb_clk_i),.reset(reset),
        .a_in(io_in[`MPRJ_IO_PADS-25:`MPRJ_IO_PADS-32]),
        .b_in(io_in[`MPRJ_IO_PADS-17:`MPRJ_IO_PADS-24]),
        .c_out(io_out[`MPRJ_IO_PADS-1:`MPRJ_IO_PADS-16])
        );

endmodule 
`default_nettype wire