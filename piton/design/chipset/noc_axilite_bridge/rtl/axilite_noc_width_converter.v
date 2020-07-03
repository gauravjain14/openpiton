/* This module should be intended to convert between narrow source and wider
 destination and vice-versa
 Some assumptions:
 1. Input data should be byte-aligned - 1B, 2B, 4B, 8B,...

*/
`include "define.tmp.h"

module axilite_noc_width_converter #(
    parameter DATA_INPUT_WIDTH = 64,
    parameter DATA_OUTPUT_WIDTH = 512
)(
    input wire                                    clk,
    input wire                                    rst_n,

    input wire                                    inp_valid,
    input wire [DATA_INPUT_WIDTH-1:0]             inp_data,
    
    output reg                                    out_valid,
    output reg [DATA_OUTPUT_WIDTH-1:0]            out_data
);

localparam IO_WIDTH_RATIO = DATA_OUTPUT_WIDTH/DATA_INPUT_WIDTH;

genvar k;
generate
    for (k=0; k<IO_WIDTH_RATIO; k++)
    begin: WIDTH_GEN
        out_data[k*DATA_INPUT_WIDTH +: DATA_INPUT_WIDTH] = inp_data;
    end
endgenerate