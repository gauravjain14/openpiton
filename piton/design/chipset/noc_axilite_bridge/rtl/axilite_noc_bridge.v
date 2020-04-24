`include "define.tmp.h"

module axilite_noc_bridge (
    input  wire                                   clk,
    input  wire                                   rst,

    // Memory Splitter <- AXI SPI
    output reg 					                  bridge_splitter_val,
    output reg [`NOC_DATA_WIDTH-1:0] 		      bridge_splitter_data,
    input wire 					                  splitter_bridge_rdy,
   
    // Memory Splitter -> AXI SPI
    input wire 					                  splitter_bridge_val,
    input wire [`NOC_DATA_WIDTH-1:0] 		      splitter_bridge_data,
    output wire 				                  bridge_splitter_rdy,

    // AXI Write Address Channel Signals
    input  wire  [`C_M_AXI_LITE_ADDR_WIDTH-1:0]   m_axi_awaddr,
    input  wire                                   m_axi_awvalid,
    output wire                                   m_axi_awready,

    // AXI Write Data Channel Signals
    input  wire  [`C_M_AXI_LITE_DATA_WIDTH-1:0]   m_axi_wdata,
    input  wire  [`C_M_AXI_LITE_DATA_WIDTH/8-1:0] m_axi_wstrb,
    input  wire                                   m_axi_wvalid,
    output wire                                   m_axi_wready,

    // AXI Read Address Channel Signals
    input  wire  [`C_M_AXI_LITE_ADDR_WIDTH-1:0]   m_axi_araddr,
    input  wire                                   m_axi_arvalid,
    output wire                                   m_axi_arready,

    // AXI Read Data Channel Signals
    output  reg [`C_M_AXI_LITE_DATA_WIDTH-1:0]    m_axi_rdata,
    output  reg [`C_M_AXI_LITE_RESP_WIDTH-1:0]    m_axi_rresp,
    output  reg                                   m_axi_rvalid,
    input  wire                                   m_axi_rready,

    // AXI Write Response Channel Signals
    output  reg [`C_M_AXI_LITE_RESP_WIDTH-1:0]    m_axi_bresp,
    output  reg                                   m_axi_bvalid,
    input  wire                                   m_axi_bready
);

/* States to form NoC packet
* Let's support only MSG_STORE and MSG_LOAD for now*/

reg [`NOC_DATA_WIDTH-1:0]    counter;

// States for Incoming Piton Messages
`define MSG_STATE_INVALID    3'd0 // Invalid Message
`define MSG_STATE_HEADER_0   3'd1 // Header 0
`define MSG_STATE_HEADER_1   3'd2 // Header 1
`define MSG_STATE_HEADER_2   3'd3 // Header 2
`define MSG_STATE_DATA       3'd4 // Data Lines

// Types for Incoming Piton Messages
`define MSG_TYPE_INVAL       2'd0 // Invalid Message
`define MSG_TYPE_LOAD        2'd1 // Load Request
`define MSG_TYPE_STORE       2'd2 // Store Request


reg                             noc_valid;
reg [`NOC_DATA_WIDTH-1:0]       noc_data;
reg [2:0]                       flit_state;
reg [2:0]                       flit_state_next;
reg [`NOC_DATA_WIDTH-1:0]       flit;
reg [1:0]                       axi_to_noc_msg_type;


/* flit fields */
reg [`C_M_AXI_LITE_ADDR_WIDTH-1:0]      address;
reg [`MSG_SRC_CHIPID_WIDTH-1:0]         src_chipid;
reg [`MSG_SRC_X_WIDTH-1:0]              src_xpos;
reg [`MSG_SRC_Y_WIDTH-1:0]              src_ypos;
reg [`MSG_SRC_FBITS_WIDTH-1:0]          src_fbits;
reg [`MSG_LENGTH_WIDTH-1:0]             msg_length;
reg [`MSG_TYPE_WIDTH-1:0]               msg_type;
reg [`MSG_MSHRID_WIDTH-1:0]             msg_mshrid;
reg [`MSG_OPTIONS_1]                    msg_options_1;
reg [`MSG_OPTIONS_2_]                   msg_options_2;
reg [`MSG_OPTIONS_3_]                   msg_options_3;
reg [`MSG_OPTIONS_4]                    msg_options_4;
reg [`MSG_DST_CHIPID_WIDTH-1:0]         dest_chipid;
reg [`MSG_DST_X_WIDTH-1:0]              dest_xpos;
reg [`MSG_DST_Y_WIDTH-1:0]              dest_ypos;
reg [`MSG_DST_FBITS_WIDTH-1:0]          dest_fbits;

/* Directly pass-through signals for now. Later, add a fifo 
* to store noc packets */
assign m_axi_awready = splitter_bridge_rdy;
assign m_axi_wready = splitter_bridge_rdy;
assign m_axi_arready = splitter_bridge_rdy;

assign axi_to_noc_STORE = m_axi_awvalid & m_axi_wvalid;
assign axi_to_noc_LOAD = m_axi_arvalid;

assign axi_to_noc_msg_type = (axi_to_noc_STORE) ? `MSG_TYPE_STORE :
                            (axi_to_noc_LOAD) ? `MSG_TYPE_LOAD :
                            `MSG_TYPE_INVAL;

/* Is it possible that there are two store requests
in consecutive cycles? If yes, then axi_store_data
would be overwritten before we reach the state
flit_state == MSG_STATE_DATA 
Even if not, we should be using a buffer/fifo over here*/
always @ (*)
begin
    dest_fbits = `NOC_FBITS_MEM;
    src_xpos = 0;
    src_ypos = 0;
    src_chipid = 0;
    src_fbits = `NOC_FBITS_L1;
    msg_mshrid = 0;
    msg_options_1 = 0;
    msg_options_2 = 0;
    msg_options_3 = 0;
    msg_options_4 = 0;
    noc_data = 0;

   case (axi_to_noc_msg_type)
        `MSG_TYPE_STORE:
        begin
            address = m_axi_awaddr;
            msg_type = `MSG_TYPE_STORE_MEM;
            msg_length = 3;
            noc_valid = axi_to_noc_STORE;
            noc_data = m_axi_wdata;
        end

        `MSG_TYPE_LOAD:
        begin
            address = m_axi_awaddr;
            msg_type = `MSG_TYPE_LOAD_MEM;
            msg_length = 2;
            noc_valid = axi_to_noc_LOAD;
        end
	  
        default:
        begin
    	    address = 0;
	        msg_length = 0;
	        msg_type = 0;
	        noc_valid = 0;
        end
   endcase // case (axi_to_noc_msg_type)]
end

always @(posedge clk)
begin
    if (rst) begin
        flit_state <= `MSG_STATE_HEADER_0;
        bridge_splitter_val <= 1'b0;
        bridge_splitter_data <= {`NOC_DATA_WIDTH{1'b0}};
    end
    else
    begin
        flit_state <= flit_state_next;
        bridge_splitter_val <= noc_valid;
        bridge_splitter_data <= flit;
    end
end

always @ (*)
begin
    flit_state_next = flit_state;

    if (noc_valid)
    begin
        if (splitter_bridge_rdy)
        begin
            if (flit_state != msg_length)
                flit_state_next = flit_state + 1;
            else
                flit_state_next = `MSG_STATE_HEADER_0;
        end
    end
end 

assign dest_chipid = {14{1'b1}};
assign dest_xpos = 8'hab;
assign dest_ypos = 8'hcd;
assign src_chipid = {14{1'b0}};
assign src_xpos = 8'hef;
assign src_ypos = 8'h12;

always @ (*)
begin
    flit[`NOC_DATA_WIDTH-1:0] = 0; 

    if (flit_state == `MSG_STATE_HEADER_0)
    begin
        flit[`MSG_DST_CHIPID] = dest_chipid;
        flit[`MSG_DST_X] = dest_xpos;
        flit[`MSG_DST_Y] = dest_ypos;
        flit[`MSG_DST_FBITS] = dest_fbits;
        flit[`MSG_LENGTH] = msg_length;
        flit[`MSG_TYPE] = msg_type;
        flit[`MSG_MSHRID] = msg_mshrid;
        flit[`MSG_OPTIONS_1] = msg_options_1;
    end
    else if (flit_state == `MSG_STATE_HEADER_1)
    begin
        flit[`MSG_ADDR_] = address;
        flit[`MSG_OPTIONS_2_] = msg_options_2;
    end
    else if (flit_state == `MSG_STATE_HEADER_2)
    begin
        flit[`MSG_SRC_CHIPID_] = src_chipid;
        flit[`MSG_SRC_X_] = src_xpos;
        flit[`MSG_SRC_Y_] = src_ypos;
        flit[`MSG_SRC_FBITS_] = src_fbits;
        flit[`MSG_OPTIONS_3_] = msg_options_3;
    end
    else if (flit_state == `MSG_STATE_DATA)
    begin
        flit[`NOC_DATA_WIDTH-1:0] = noc_data;
    end
end

endmodule