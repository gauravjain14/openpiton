/* This uses the Mealy State Machine. There is another implementation
for Moore State Machine as well. */

`include "define.tmp.h"

module axilite_master_test #(
    parameter AXILITE_ADDR_WIDTH = 64,
    parameter AXILITE_DATA_WIDTH = 64,
    parameter MAX_DATA_COUNT = 2048
) (
    input                                   clk,
    input                                   rst,

    output reg [AXILITE_ADDR_WIDTH-1:0]     m_axi_awaddr,
    output reg                              m_axi_awvalid,
    input                                   m_axi_awready,
    output reg [AXILITE_DATA_WIDTH-1:0]     m_axi_wdata,
    output reg                              m_axi_wvalid,
    input                                   m_axi_wready,

	/* verilator lint_off UNDRIVEN */
    output [AXILITE_ADDR_WIDTH-1:0]         m_axi_araddr,     
	/* verilator lint_off UNDRIVEN */
	output                                  m_axi_arvalid,
	/* verilator lint_off UNUSED */
    input                                   m_axi_arready,

    // AXI Read Data Channel Signals
    input  wire [AXILITE_DATA_WIDTH-1:0]    m_axi_rdata,
    //input  wire [`C_M_AXI_LITE_RESP_WIDTH-1:0]    m_axi_rresp,
    input  wire                             m_axi_rvalid,
    output  reg                             m_axi_rready 
);

localparam RESET_WRITE = 2'b00;
localparam HOLD_WRITE = 2'b01;
localparam GEN_WRITE = 2'b10;
localparam STOP_WRITE = 2'b11;

localparam RESET_READ = 1'b0;
localparam GEN_READ = 1'b1;

reg                                         start;
reg [1:0] 	                                gen_write_f;
reg [1:0]                                   gen_write_next;
reg											addr_valid;
reg											data_valid;
reg [AXILITE_ADDR_WIDTH-1:0]                addr_counter;
reg [AXILITE_ADDR_WIDTH-1:0]                max_wr_addr;
reg [AXILITE_DATA_WIDTH-1:0]                data_counter;
reg [3:0]									interval_counter;
reg                                         gen_read_f;
reg                                         gen_read_next;
reg                                         rd_valid;
reg [AXILITE_ADDR_WIDTH-1:0]                rd_addr;

wire										write_ready;
wire                                        start_read;
wire [6:0]                                  offset;

localparam addr_base = 'h80000000;
assign start_read = (gen_write_f == STOP_WRITE);
assign m_axi_rready = 1'b1; // always ready
assign offset = AXILITE_DATA_WIDTH >> 3;

integer file;
initial begin
    file = $fopen("axilite_master_test.log", "w");
end

always @(posedge clk)
begin
    if (m_axi_awvalid && m_axi_awready)
    begin
        $fwrite(file, "awaddr-fifo %064x\n", m_axi_awaddr);
        $fflush(file);
    end 
    if (m_axi_wvalid && m_axi_wready)
    begin
        $fwrite(file, "wdata-fifo %064x\n", m_axi_wdata);
        $fflush(file);
    end
end

integer file_rd;
initial begin
    file_rd = $fopen("axilite_master_read.log", "w");
end

always @(posedge clk)
begin
    if (m_axi_rvalid && m_axi_rready)
    begin
        $fwrite(file_rd, "rdata %064x\n", m_axi_rdata);
        $fflush(file_rd);
    end
end

always @(posedge clk)
begin
    if (rst) begin
        m_axi_arvalid <= 1'b0;
        m_axi_araddr <= addr_base;
    end
    else begin
        m_axi_arvalid <= rd_valid;
        m_axi_araddr <= rd_addr;
    end
end

always @(posedge clk)
begin
    if (rst) 
        gen_read_f <= RESET_READ;
    else
        gen_read_f <= gen_read_next;
end

always @(*)
begin
    gen_read_next <= gen_read_f;
    rd_valid = 1'b0;
    case (gen_read_f)
        RESET_READ: begin
            rd_addr = addr_base;
            if (start_read && m_axi_arready) begin
                gen_read_next = GEN_READ;
            end
        end

        GEN_READ: begin
            if (rd_addr < max_wr_addr) begin
                rd_valid = 1'b1;
                rd_addr = m_axi_araddr + (offset & {7{m_axi_arready}});
            end
        end
    endcase
end

always @(posedge clk)
begin
    if (rst) begin
        start <= 1'b0;
        gen_write_f <= RESET_WRITE;
    end
    else begin
        start <= 1'b1;
        gen_write_f <= gen_write_next;
    end
end

assign write_ready = m_axi_awready && m_axi_wready;

always @(*)
begin
	gen_write_next = gen_write_f;
    
    if (start == 1'b0) 
        gen_write_next = RESET_WRITE;
    else begin
        if (data_counter < MAX_DATA_COUNT) begin
            gen_write_next = (write_ready) ? GEN_WRITE : HOLD_WRITE;
        end
        else begin
            gen_write_next = STOP_WRITE;
        end
    end
end

always @(*)
begin
	addr_valid = m_axi_awvalid;
	data_valid = m_axi_wvalid;

	case (gen_write_f)
        RESET_WRITE: begin
            addr_valid = 1'b0;
            data_valid = 1'b0;
            addr_counter = addr_base;
            data_counter = {AXILITE_DATA_WIDTH{1'b0}};
        end

		HOLD_WRITE: begin
			addr_valid = 1'b1;
			data_valid = 1'b1;
		end

		GEN_WRITE: begin
			addr_valid = 1'b1;
			data_valid = 1'b1;
            max_wr_addr = addr_counter;
			addr_counter = m_axi_awaddr + offset; // 1'b1; byte-addressable
			data_counter = m_axi_wdata + 1'b1;
		end

        STOP_WRITE: begin
            addr_valid = 1'b0;
            data_valid = 1'b0;
            addr_counter = {AXILITE_ADDR_WIDTH{1'b1}};
            data_counter = {AXILITE_DATA_WIDTH{1'b1}};
        end
	endcase
end

always @(posedge clk)
begin
    if (rst) begin
        m_axi_awvalid <= 1'b0;
        m_axi_wvalid <= 1'b0;
        m_axi_awaddr <= addr_base; // let it start with some random addr in mem-range {AXILITE_ADDR_WIDTH{1'b0}};
        m_axi_wdata <= {AXILITE_DATA_WIDTH{1'b0}};
    end
    else begin
        m_axi_awvalid <= addr_valid;
        m_axi_wvalid <= data_valid;
        if (m_axi_awready && m_axi_wready) begin
            m_axi_awaddr <= addr_counter;
            m_axi_wdata <= data_counter;
        end
    end
end

endmodule

