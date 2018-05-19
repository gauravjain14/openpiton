/*
Copyright (c) 2015 Princeton University
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Princeton University nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY PRINCETON UNIVERSITY "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL PRINCETON UNIVERSITY BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

//l15.vh
`include "define.vh"
`include "iop.h"

`ifndef L15_H
`define L15_H

`define L15_PHYSICAL_ADDRESS_WIDTH 40

// L15 has 512 cache lines
`define L15_NUM_ENTRIES_LOG2 9
`define L15_NUM_4WAY_ENTRIES_LOG2 7

`define L15_MESI_STATE_WIDTH 2
`define L15_MESI_STATE_I 2'd0
`define L15_MESI_STATE_S 2'd1
`define L15_MESI_STATE_E 2'd2
`define L15_MESI_STATE_M 2'd3

`define L15_MESI_TRANS_STATE_WIDTH 2
`define L15_MESI_TRANSITION_STATE_SM 2'b01
`define L15_MESI_TRANSITION_STATE_IM 2'b10

`define L15_CACHE_TAG_RAW_WIDTH 33
`define L15_CACHE_TAG_WIDTH 29
`define L15_CACHE_INDEX_WIDTH 7
`define L15_CACHE_WAY_WIDTH 2

// source
`define L15_PREDECODE_SOURCE_WIDTH 2
`define L15_PREDECODE_SOURCE_INVALID 2'd0
`define L15_PREDECODE_SOURCE_PCX 2'd1
`define L15_PREDECODE_SOURCE_NOC2 2'd2

// MSHR
`define L15_MSHR_WRITE_TYPE_WIDTH 3
`define L15_MSHR_WRITE_TYPE_ALLOCATION 3'b001
`define L15_MSHR_WRITE_TYPE_DEALLOCATION 3'b010
`define L15_MSHR_WRITE_TYPE_UPDATE_ST_STATE 3'b011
`define L15_MSHR_WRITE_TYPE_UPDATE_WRITE_CACHE 3'b100

// controls how many mshr there are
// `define L15_MSHR_COUNT 10
// should be more than the count above when 2^n
`define L15_MSHR_ID_WIDTH 2
`define L15_MSHR_ID_IFILL 2'd1
`define L15_MSHR_ID_LD 2'd2
`define L15_MSHR_ID_ST 2'd3
`define L15_NUM_THREADS 2
`define L15_NUM_THREADS_LOG 1
`define L15_NUM_MSHRID_PER_THREAD 4

// pipeline OPs
`define L15_S1_MSHR_OP_WIDTH 2
`define L15_S1_MSHR_OP_ALLOCATE 2'd1
`define L15_S1_MSHR_OP_UPDATE_WRITECACHE 2'd2

// `define L15_MSHR_ALLOCATE_TYPE_WIDTH 2
// `define L15_MSHR_ALLOCATE_TYPE_LD 2'd1
// `define L15_MSHR_ALLOCATE_TYPE_ST 2'd2
// `define L15_MSHR_ALLOCATE_TYPE_IFILL 2'd3


`define L15_S2_MSHR_OP_WIDTH 1
`define L15_S2_MSHR_OP_READ_WRITE_CACHE 1'd1

`define L15_S3_MSHR_OP_WIDTH 3
`define L15_S3_MSHR_OP_DEALLOCATION 3'd1
`define L15_S3_MSHR_OP_DEALLOCATION_IF_TAGCHECK_MES 3'd2
`define L15_S3_MSHR_OP_DEALLOCATION_IF_TAGCHECK_M_E_ELSE_UPDATE_STATE_STMSHR 3'd3
`define L15_S3_MSHR_OP_UPDATE_ST_MSHR_IM_IF_INDEX_TAGCHECK_WAY_MATCHES 3'd4
`define L15_S3_MSHR_OP_UPDATE_ST_MSHR_IM_IF_INDEX_LRU_WAY_MATCHES 3'd5

`define L15_MSHRS3_OP_DEALLOCATION 2'b01
`define L15_MSHRS3_OP_UPDATE 2'b10

`define L15_REQTYPE_WIDTH 6
`define L15_REQTYPE_NONE 6'd0
`define L15_REQTYPE_IGNORE 6'd1
`define L15_REQTYPE_IFILL 6'd2
`define L15_REQTYPE_STORE 6'd3
`define L15_REQTYPE_CAS 6'd4
`define L15_REQTYPE_SWP_LOADSTUB 6'd5
`define L15_REQTYPE_INVALIDATION 6'd6
`define L15_REQTYPE_DOWNGRADE 6'd7
`define L15_REQTYPE_ACKDT_LD_NC 6'd8
`define L15_REQTYPE_ACKDT_IFILL 6'd9
`define L15_REQTYPE_ACKDT_LD 6'd10
`define L15_REQTYPE_ACKDT_ST_IM 6'd11
`define L15_REQTYPE_ACKDT_ST_SM 6'd12
`define L15_REQTYPE_ACK_WRITETHROUGH 6'd13
`define L15_REQTYPE_ACK_ATOMIC 6'd14
`define L15_REQTYPE_LOAD_NC 6'd15
`define L15_REQTYPE_LOAD_PREFETCH 6'd16
`define L15_REQTYPE_WRITETHROUGH 6'd17
`define L15_REQTYPE_ICACHE_INVALIDATION 6'd18
`define L15_REQTYPE_PCX_INTERRUPT 6'd19
`define L15_REQTYPE_L2_INTERRUPT 6'd20
`define L15_REQTYPE_LOAD 6'd21
`define L15_REQTYPE_INT_VEC_DIS 6'd22
`define L15_REQTYPE_WRITE_CONFIG_REG 6'd23
`define L15_REQTYPE_LOAD_CONFIG_REG 6'd24
`define L15_REQTYPE_DIAG_LOAD 6'd25
`define L15_REQTYPE_DIAG_STORE 6'd26
`define L15_REQTYPE_LINE_FLUSH 6'd27
`define L15_REQTYPE_HMC_FILL 6'd28
`define L15_REQTYPE_HMC_DIAG_LOAD 6'd29
`define L15_REQTYPE_HMC_DIAG_STORE 6'd30
`define L15_REQTYPE_HMC_FLUSH 6'd31
`define L15_REQTYPE_ACK_PREFETCH 6'd32
`define L15_REQTYPE_ICACHE_SELF_INVALIDATION 6'd33
`define L15_REQTYPE_DCACHE_SELF_INVALIDATION 6'd34


`define PCX_SIZE_WIDTH 3
`define PCX_SIZE_FIELD_WIDTH 3
`define PCX_REQTYPE_WIDTH 5
`define PCX_REQTYPE_LOAD `LOAD_RQ
`define PCX_REQTYPE_IFILL `IMISS_RQ
`define PCX_REQTYPE_STORE `STORE_RQ
`define PCX_REQTYPE_CAS1 `CAS1_RQ
`define PCX_REQTYPE_CAS2 `CAS2_RQ
`define PCX_REQTYPE_SWP_LOADSTUB `SWAP_RQ
`define PCX_REQTYPE_INTERRUPT `INT_RQ
`define PCX_REQTYPE_FP1 5'b01010
`define PCX_REQTYPE_FP2 5'b01011
`define PCX_REQTYPE_STREAM_LOAD `STRLOAD_RQ
`define PCX_REQTYPE_STREAM_STORE `STRST_RQ
`define PCX_REQTYPE_FWD_REQ `FWD_RQ
`define PCX_REQTYPE_FWD_REPLY `FWD_RPY


// `define PCX_REQ_SIZE_WIDTH 4
`define CPX_RESTYPE_WIDTH 4
`define CPX_RESTYPE_LOAD `LOAD_RET
`define CPX_RESTYPE_IFILL1 `IFILL_RET
`define CPX_RESTYPE_IFILL2 `IFILL_RET
`define CPX_RESTYPE_STREAM_LOAD `STRLOAD_RET
`define CPX_RESTYPE_INVAL `INV_RET
`define CPX_RESTYPE_STORE_ACK `ST_ACK
`define CPX_RESTYPE_STREAM_STORE_ACK `STRST_ACK
`define CPX_RESTYPE_INTERRUPT `INT_RET
`define CPX_RESTYPE_FP `FP_RET
`define CPX_RESTYPE_FWD_REQ `FWD_RQ_RET
`define CPX_RESTYPE_FWD_REPLY `FWD_RPY_RET
`define CPX_RESTYPE_ATOMIC_RES 4'b1110 // custom type

`define L15_CONTROL_PREFETCH_1B 0
`define L15_CONTROL_BLOCKSTOREINIT_1B (`L15_CONTROL_PREFETCH_1B + 1)
`define L15_CONTROL_LOAD (`L15_CONTROL_BLOCKSTOREINIT_1B + 1)
`define L15_CONTROL_ATOMIC (`L15_CONTROL_LOAD + 1)
`define L15_CONTROL_ICACHE (`L15_CONTROL_ATOMIC + 1)
`define L15_CONTROL_SIZE_3B (`L15_CONTROL_ICACHE + 3)
`define L15_CONTROL_THREADID (`L15_CONTROL_SIZE_3B + `L15_NUM_THREADS_LOG)
`define L15_CONTROL_L1_REPLACEMENT_WAY_2B (`L15_CONTROL_THREADID + 2)
`define L15_CONTROL_NC_1B (`L15_CONTROL_L1_REPLACEMENT_WAY_2B + 1)
`define L15_CONTROL_BLOCKSTORE_1B (`L15_CONTROL_NC_1B + 1)
`define L15_CONTROL_WIDTH (`L15_CONTROL_BLOCKSTORE_1B + 1)

// `L15_NUM_THREADS_LOG
// `L15_NUM_THREADS_LOG-1
// `L15_NUM_THREADS_LOG-1:0
// [`L15_NUM_THREADS_LOG-1:0]

`define L15_FETCH_STATE_WIDTH 3
`define L15_FETCH_STATE_NORMAL 3'd0
`define L15_FETCH_STATE_PCX_WRITEBACK_DONE 3'd1
`define L15_FETCH_STATE_INVAL_2 3'd2
`define L15_FETCH_STATE_INVAL_3 3'd3
`define L15_FETCH_STATE_INVAL_4 3'd4
`define L15_FETCH_STATE_NOC2_WRITEBACK_DONE 3'd5
`define L15_FETCH_STATE_ICACHE_INVAL_2 3'd6

`define L15_ACK_STAGE_WIDTH 2
`define L15_ACK_STAGE_NEVER 2'd0
`define L15_ACK_STAGE_S1 2'd1
`define L15_ACK_STAGE_S2 2'd2
`define L15_ACK_STAGE_S3 2'd3


// [L15_DTAG_OP_WIDTH-1:0]

`define L15_DTAG_OP_WIDTH 2
`define L15_DTAG_OP_READ 2'd1
`define L15_DTAG_OP_WRITE 2'd2

`define L15_DTAG_RW_READ 1'b1
`define L15_DTAG_RW_WRITE 1'b0

`define L15_S2_MESI_OP_WIDTH 1
`define L15_S2_MESI_READ 1'd1

`define L15_DCACHE_OP_WIDTH 4
`define L15_DCACHE_READ_TAGCHECK_WAY_IF_M 4'd1
`define L15_DCACHE_READ_TAGCHECK_WAY_IF_MES 4'd2
`define L15_DCACHE_READ_LRU_WAY_IF_M 4'd3
`define L15_DCACHE_WRITE_TAGCHECK_WAY_IF_ME_FROM_MSHR 4'd4
`define L15_DCACHE_WRITE_LRU_WAY_FROM_NOC2 4'd5
`define L15_DCACHE_WRITE_LRU_WAY_FROM_NOC2_AND_MSHR 4'd6
`define L15_DCACHE_WRITE_MSHR_WAY_FROM_MSHR 4'd7
`define L15_DCACHE_DIAG_READ 4'd8
`define L15_DCACHE_DIAG_WRITE 4'd9
`define L15_DCACHE_READ_FLUSH_WAY_IF_M 4'd10

`define L15_S3_MESI_OP_WIDTH 3
`define L15_S3_MESI_WRITE_TAGCHECK_WAY_S_IF_ME 3'd1
`define L15_S3_MESI_WRITE_TAGCHECK_WAY_M_IF_E 3'd2
`define L15_S3_MESI_INVALIDATE_TAGCHECK_WAY_IF_MES 3'd3
`define L15_S3_MESI_WRITE_LRU_WAY_ACK_STATE 3'd4
`define L15_S3_MESI_WRITE_MSHR_WAY_ACK_STATE 3'd5
`define L15_S3_MESI_INVALIDATE_FLUSH_WAY_IF_MES 3'd6

`define L15_WMT_READ_OP_WIDTH 1
`define L15_WMT_READ 1'd1

`define L15_WMT_WRITE_OP_WIDTH 3
`define L15_WMT_DEMAP_TAGCHECK_WAY_IF_MES 3'd1
`define L15_WMT_DEMAP_LRU_WAY_IF_MES 3'd2
`define L15_WMT_UPDATE_LRU_WAY_AND_DEDUP_ENTRY 3'd3
`define L15_WMT_UPDATE_TAGCHECK_WAY_AND_DEDUP_ENTRY_IF_TAGCHECK_WAY_IS_MES 3'd4
`define L15_WMT_DEMAP_FLUSH_WAY_IF_MES 3'd5

`define L15_LRUARRAY_WRITE_OP_WIDTH 3
`define L15_LRU_UPDATE_ACCESS_BITS_IF_TAGCHECK_WAY_IS_MES 3'd1
`define L15_LRU_EVICTION 3'd2
`define L15_LRU_REPLACEMENT 3'd3
`define L15_LRU_INVALIDATE_IF_TAGCHECK_WAY_IS_MES 3'd4
`define L15_LRU_INVALIDATE_IF_FLUSH_WAY_IS_MES 3'd5

`define L15_CONFIG_OP_WIDTH 2
`define L15_CONFIG_LOAD 2'd1
`define L15_CONFIG_WRITE 2'd2

`define L15_CPX_OP_WIDTH 5
`define L15_CPX_GEN_INVALIDATION_IF_TAGCHECK_MES_AND_WAYMAP_VALID 5'd1
`define L15_CPX_GEN_LD_RESPONSE_BOGUS_DATA 5'd2
`define L15_CPX_GEN_LD_RESPONSE_BOGUS_DATA_IF_TAGCHECK_MES 5'd3
`define L15_CPX_GEN_LD_RESPONSE_IF_TAGCHECK_MES_FROM_DCACHE 5'd4
`define L15_CPX_GEN_LD_RESPONSE_FROM_NOC2 5'd5
`define L15_CPX_GEN_ST_ACK 5'd6
`define L15_CPX_GEN_ST_ACK_IF_TAGCHECK_M_E_WITH_POSSIBLE_INVAL 5'd7
`define L15_CPX_GEN_INVALIDATION_IF_LRU_MES_AND_WAYMAP_VALID 5'd8
`define L15_CPX_GEN_IFILL_RESPONSE_FROM_NOC2 5'd9
`define L15_CPX_GEN_ATOMIC_ACK_FROM_NOC2 5'd10
`define L15_CPX_GEN_ST_ACK_WITH_POSSIBLE_INVAL 5'd11
`define L15_CPX_GEN_BROADCAST_ACK 5'd12
`define L15_CPX_GEN_INTERRUPT 5'd13
`define L15_CPX_GEN_ICACHE_INVALIDATION 5'd14
`define L15_CPX_GEN_LOAD_CONFIG_REG_RESPONSE 5'd15
`define L15_CPX_GEN_LD_RESPONSE_FROM_DCACHE 5'd16
`define L15_CPX_GEN_INVALIDATION_IF_FLUSH_MES_AND_WAYMAP_VALID 5'd17
`define L15_CPX_GEN_LD_RESPONSE_FROM_CSM 5'd18
`define L15_CPX_GEN_DCACHE_INVALIDATION 5'd19

`define L15_NOC1_OP_WIDTH 4
`define L15_NOC1_GEN_DATA_LD_REQUEST 4'd1
`define L15_NOC1_GEN_DATA_LD_REQUEST_IF_TAGCHECK_MISS 4'd2
`define L15_NOC1_GEN_INSTRUCTION_LD_REQUEST 4'd3
`define L15_NOC1_GEN_DATA_ST_UPGRADE_IF_TAGCHECK_S_ELSE_ST_FILL_IF_TAGCHECK_I 4'd4
`define L15_NOC1_GEN_DATA_WRITETHROUGH_REQUEST_FROM_PCX 4'd5
`define L15_NOC1_GEN_DATA_CAS_REQUEST_FROM_PCX 4'd6
`define L15_NOC1_GEN_DATA_SWAP_REQUEST_FROM_PCX 4'd7
`define L15_NOC1_GEN_WRITEBACK_GUARD_IF_LRU_M 4'd8
`define L15_NOC1_GEN_WRITEBACK_GUARD_IF_TAGCHECK_M 4'd9
`define L15_NOC1_GEN_INTERRUPT_FWD 4'd10
// `define L15_NOC1_DUMMY_GEN_NOC1_CREDIT 4'd11
`define L15_NOC1_GEN_WRITEBACK_GUARD_IF_FLUSH_M 4'd12

`define L15_NOC1_CAS_COMPARE_HI_64b 127
`define L15_NOC1_CAS_SWAP_HI_64b 63

`define L15_NOC3_OP_WIDTH 4
`define L15_NOC3_GEN_INVAL_ACK_FROM_DCACHE 4'd1
`define L15_NOC3_GEN_INVAL_ACK_IF_TAGCHECK_M_FROM_DCACHE 4'd2
`define L15_NOC3_GEN_DOWNGRADE_ACK_FROM_DCACHE 4'd3
`define L15_NOC3_GEN_DOWNGRADE_ACK_IF_TAGCHECK_M_FROM_DCACHE 4'd4
`define L15_NOC3_GEN_WRITEBACK_IF_TAGCHECK_M_FROM_DCACHE 4'd5
`define L15_NOC3_GEN_WRITEBACK_IF_LRU_M_FROM_DCACHE 4'd6
`define L15_NOC3_GEN_ICACHE_INVAL_ACK 4'd7
`define L15_NOC3_GEN_WRITEBACK_IF_FLUSH_M_FROM_DCACHE 4'd8

`define L15_CPX_SOURCE_WIDTH 3
`define L15_CPX_SOURCE_BOGUS 3'd0
`define L15_CPX_SOURCE_DCACHE 3'd1
`define L15_CPX_SOURCE_NOC2_BUFFER 3'd2
`define L15_CPX_SOURCE_CONFIG_REGS 3'd3
`define L15_CPX_SOURCE_CSM 3'd4

`define L15_NOC1_SOURCE_WIDTH 2
`define L15_NOC1_SOURCE_PCX_64B 2'd1
`define L15_NOC1_SOURCE_PCX_128B 2'd2

`define L15_DCACHE_SOURCE_WIDTH 3
`define L15_DCACHE_SOURCE_MSHR 3'd1
`define L15_DCACHE_SOURCE_NOC2 3'd2
`define L15_DCACHE_SOURCE_NOC2_AND_MSHR 3'd3
`define L15_DCACHE_SOURCE_PCX_DIAG 3'd4

// L2 shared states


// `define L15_NOC2_ACK_STATE_WIDTH 2
// `define L15_NOC2_ACK_STATE_S 2'd1
// `define L15_NOC2_ACK_STATE_E 2'd2
// `define L15_NOC2_ACK_STATE_M 2'd3

// `define L15_NOC1_REQTYPE_WIDTH `MSG_TYPE_WIDTH
// `define L15_NOC1_REQTYPE_WRITEBACK_GUARD `MSG_TYPE_WBGUARD_REQ
// `define L15_NOC1_REQTYPE_LD_REQUEST `MSG_TYPE_LOAD_REQ
// `define L15_NOC1_REQTYPE_LD_PREFETCH_REQUEST `MSG_TYPE_PREFETCH_REQ
// `define L15_NOC1_REQTYPE_LD_NC_REQUEST `MSG_TYPE_NC_LOAD_REQ
// `define L15_NOC1_REQTYPE_IFILL_REQUEST `MSG_TYPE_LOAD_REQ
// // `define L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST 6'd4
// `define L15_NOC1_REQTYPE_ST_REQUEST `MSG_TYPE_STORE_REQ
// `define L15_NOC1_REQTYPE_BLK_ST_REQUEST `MSG_TYPE_BLK_STORE_REQ
// `define L15_NOC1_REQTYPE_BLK_ST_INIT_REQUEST `MSG_TYPE_BLKINIT_STORE_REQ
// // `define L15_NOC1_REQTYPE__REQUEST
// // `define L15_NOC1_REQTYPE__REQUEST
// // `define L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST 6
// // `define L15_NOC1_REQTYPE_ST_FILL_REQUEST 6'd6
// `define L15_NOC1_REQTYPE_CAS_REQUEST `MSG_TYPE_CAS_REQ
// `define L15_NOC1_REQTYPE_SWAP_REQUEST `MSG_TYPE_SWAP_REQ

// `define L15_NOC3_REQTYPE_WIDTH `MSG_TYPE_WIDTH
// `define L15_NOC3_REQTYPE_WRITEBACK `MSG_TYPE_WB_REQ
// `define L15_NOC3_REQTYPE_NO_DATA_FWD_ACK `MSG_TYPE_NODATA_ACK
// `define L15_NOC3_REQTYPE_DATA_FWD_ACK `MSG_TYPE_DATA_ACK

// `define L2_REQTYPE_WIDTH `MSG_TYPE_WIDTH
// `define L2_REQTYPE_INVALIDATE 6'd1
// `define L2_REQTYPE_DOWNGRADE 6'd2
// `define L2_REQTYPE_ACKDT_LD_NC 6'd3
// `define L2_REQTYPE_ACKDT_IFILL 6'd4
// `define L2_REQTYPE_ACKDT_LD 6'd5
// `define L2_REQTYPE_ACKDT_ST_IM 6'd6
// `define L2_REQTYPE_ACKDT_ST_SM 6'd7
// `define L2_REQTYPE_ACK_WRITETHROUGH 6'd8
// `define L2_REQTYPE_ACK_ATOMIC 6'd9

`define L15_NOC1_REQTYPE_WIDTH 4
`define L15_NOC1_REQTYPE_WRITEBACK_GUARD 4'd1
`define L15_NOC1_REQTYPE_LD_REQUEST 4'd2
`define L15_NOC1_REQTYPE_IFILL_REQUEST 4'd3
`define L15_NOC1_REQTYPE_WRITETHROUGH_REQUEST 4'd4
`define L15_NOC1_REQTYPE_ST_UPGRADE_REQUEST 4'd5
`define L15_NOC1_REQTYPE_ST_FILL_REQUEST 4'd6
`define L15_NOC1_REQTYPE_CAS_REQUEST 4'd7
`define L15_NOC1_REQTYPE_SWAP_REQUEST 4'd8
`define L15_NOC1_REQTYPE_INTERRUPT_FWD 4'd9

`define L15_NOC3_REQTYPE_WIDTH 3
`define L15_NOC3_REQTYPE_WRITEBACK 3'd1
`define L15_NOC3_REQTYPE_INVAL_ACK 3'd2
`define L15_NOC3_REQTYPE_DOWNGRADE_ACK 3'd3
`define L15_NOC3_REQTYPE_ICACHE_INVAL_ACK 3'd4

`define L2_REQTYPE_WIDTH 5
`define L2_REQTYPE_INVALIDATE 5'd1
`define L2_REQTYPE_DOWNGRADE 5'd2
`define L2_REQTYPE_ACKDT_LD_NC 5'd3
`define L2_REQTYPE_ACKDT_IFILL 5'd4
`define L2_REQTYPE_ACKDT_LD 5'd5
`define L2_REQTYPE_ACKDT_ST_IM 5'd6
`define L2_REQTYPE_ACKDT_ST_SM 5'd7
`define L2_REQTYPE_ACK_WRITETHROUGH 5'd8
`define L2_REQTYPE_ACK_ATOMIC 5'd9

// NOC1 ENCODER
`define NOC1_FLIT_STATE_WIDTH 4
`define NOC1_REQ_HEADER_1 4'd0
`define NOC1_REQ_HEADER_2 4'd1
`define NOC1_REQ_HEADER_3 4'd2
`define NOC1_REQ_DATA_1 4'd3
`define NOC1_REQ_DATA_2 4'd4

`define L15_NOC1ENCODER_SOURCE_WIDTH 1
`define L15_NOC1ENCODER_SOURCE_L15 1'b0
`define L15_NOC1ENCODER_SOURCE_CSM 1'b1

// NOC3 ENCODER
`define NOC3_FLIT_STATE_WIDTH 4
`define NOC3_REQ_HEADER_1 4'd0
`define NOC3_REQ_HEADER_2 4'd1
`define NOC3_REQ_HEADER_3 4'd2
`define NOC3_REQ_DATA_1 4'd3
`define NOC3_REQ_DATA_2 4'd4
`define NOC3_RES_HEADER_1 4'd0
`define NOC3_RES_DATA_1 4'd1
`define NOC3_RES_DATA_2 4'd2

// NOC2 BUFFER
`define NOC2_STATE_WIDTH 2
`define NOC2_STATE_IDLE 2'd0
`define NOC2_STATE_RECEIVING 2'd1
`define NOC2_STATE_WAITING_ACK 2'd2

// DMBR
// put this here for now, should be moved to a more appropriate location
`define DMBR_TAG_WIDTH 4

// NOC1 CREDIT MANAGEMENT
// becareful, the noc1buffer module assumes these are power of two
// also, please change the corresponding pyv value in noc1buffer.v.pyv
`define NOC1_BUFFER_NUM_SLOTS 8
`define NOC1_BUFFER_NUM_SLOTS_LOG 3
`define NOC1_BUFFER_NUM_DATA_SLOTS 2
`define NOC1_BUFFER_NUM_DATA_SLOTS_LOG 1

`define NOC1_BUFFER_ACK_DATA_WIDTH 2
`define NOC1_BUFFER_ACK_DATA_16B 2'd2
`define NOC1_BUFFER_ACK_DATA_8B 2'd1

`define L15_NOC1BUFFER_REQTYPE_LO 0
`define L15_NOC1BUFFER_REQTYPE_HI `L15_NOC1BUFFER_REQTYPE_LO + `L15_NOC1_REQTYPE_WIDTH - 1
`define L15_NOC1BUFFER_MSHRID_LO  `L15_NOC1BUFFER_REQTYPE_HI + 1
`define L15_NOC1BUFFER_MSHRID_HI  `L15_NOC1BUFFER_MSHRID_LO + `L15_MSHR_ID_WIDTH - 1
`define L15_NOC1BUFFER_THREADID_LO  `L15_NOC1BUFFER_MSHRID_HI + 1
`define L15_NOC1BUFFER_THREADID_HI  `L15_NOC1BUFFER_THREADID_LO + `L15_NUM_THREADS_LOG - 1
`define L15_NOC1BUFFER_ADDRESS_LO  `L15_NOC1BUFFER_THREADID_HI + 1
`define L15_NOC1BUFFER_ADDRESS_HI  `L15_NOC1BUFFER_ADDRESS_LO + 40 - 1
`define L15_NOC1BUFFER_NON_CACHEABLE_LO  `L15_NOC1BUFFER_ADDRESS_HI + 1
`define L15_NOC1BUFFER_NON_CACHEABLE_HI  `L15_NOC1BUFFER_NON_CACHEABLE_LO + 1 - 1
`define L15_NOC1BUFFER_SIZE_LO  `L15_NOC1BUFFER_NON_CACHEABLE_HI + 1
`define L15_NOC1BUFFER_SIZE_HI  `L15_NOC1BUFFER_SIZE_LO + `PCX_SIZE_WIDTH - 1
`define L15_NOC1BUFFER_PREFETCH_LO  `L15_NOC1BUFFER_SIZE_HI + 1
`define L15_NOC1BUFFER_PREFETCH_HI  `L15_NOC1BUFFER_PREFETCH_LO + 1 - 1
// `define L15_NOC1BUFFER_BLKSTORE_LO  `L15_NOC1BUFFER_PREFETCH_HI + 1
// `define L15_NOC1BUFFER_BLKSTORE_HI  `L15_NOC1BUFFER_BLKSTORE_LO + 1 - 1
// `define L15_NOC1BUFFER_BLKINITSTORE_LO  `L15_NOC1BUFFER_BLKSTORE_HI + 1
// `define L15_NOC1BUFFER_BLKINITSTORE_HI  `L15_NOC1BUFFER_BLKINITSTORE_LO + 1 - 1
// `define L15_NOC1BUFFER_DATA_INDEX_LO  `L15_NOC1BUFFER_BLKINITSTORE_HI + 1
`define L15_NOC1BUFFER_DATA_INDEX_LO  `L15_NOC1BUFFER_PREFETCH_HI + 1
`define L15_NOC1BUFFER_DATA_INDEX_HI  `L15_NOC1BUFFER_DATA_INDEX_LO + 1 - 1
`define L15_NOC1BUFFER_CSM_TICKET_LO  `L15_NOC1BUFFER_DATA_INDEX_HI + 1
`define L15_NOC1BUFFER_CSM_TICKET_HI  `L15_NOC1BUFFER_CSM_TICKET_LO + `L15_CSM_NUM_TICKETS_LOG2 - 1
`define L15_NOC1BUFFER_HOMEID_LO  `L15_NOC1BUFFER_CSM_TICKET_HI + 1
`define L15_NOC1BUFFER_HOMEID_HI  `L15_NOC1BUFFER_HOMEID_LO + `PACKET_HOME_ID_WIDTH - 1
`define L15_NOC1BUFFER_HOMEID_VAL_LO  `L15_NOC1BUFFER_HOMEID_HI + 1
`define L15_NOC1BUFFER_HOMEID_VAL_HI  `L15_NOC1BUFFER_HOMEID_VAL_LO + 1 - 1
`define L15_NOC1BUFFER_CSM_SDID_LO  `L15_NOC1BUFFER_HOMEID_VAL_HI + 1
`define L15_NOC1BUFFER_CSM_SDID_HI  `L15_NOC1BUFFER_CSM_SDID_LO + `MSG_SDID_WIDTH - 1
`define L15_NOC1BUFFER_CSM_LSID_LO  `L15_NOC1BUFFER_CSM_SDID_HI + 1
`define L15_NOC1BUFFER_CSM_LSID_HI  `L15_NOC1BUFFER_CSM_LSID_LO + `MSG_LSID_WIDTH - 1

`define L15_COMMAND_BUFFER_LEN `L15_NOC1BUFFER_CSM_LSID_HI + 1

`define L15_NOC1BUFFER_REQTYPE `L15_NOC1BUFFER_REQTYPE_HI:`L15_NOC1BUFFER_REQTYPE_LO
`define L15_NOC1BUFFER_MSHRID  `L15_NOC1BUFFER_MSHRID_HI:`L15_NOC1BUFFER_MSHRID_LO
`define L15_NOC1BUFFER_THREADID  `L15_NOC1BUFFER_THREADID_HI:`L15_NOC1BUFFER_THREADID_LO
`define L15_NOC1BUFFER_ADDRESS  `L15_NOC1BUFFER_ADDRESS_HI:`L15_NOC1BUFFER_ADDRESS_LO
`define L15_NOC1BUFFER_NON_CACHEABLE  `L15_NOC1BUFFER_NON_CACHEABLE_HI:`L15_NOC1BUFFER_NON_CACHEABLE_LO
`define L15_NOC1BUFFER_SIZE  `L15_NOC1BUFFER_SIZE_HI:`L15_NOC1BUFFER_SIZE_LO
`define L15_NOC1BUFFER_PREFETCH  `L15_NOC1BUFFER_PREFETCH_HI:`L15_NOC1BUFFER_PREFETCH_LO
`define L15_NOC1BUFFER_BLKSTORE  `L15_NOC1BUFFER_BLKSTORE_HI:`L15_NOC1BUFFER_BLKSTORE_LO
`define L15_NOC1BUFFER_BLKINITSTORE  `L15_NOC1BUFFER_BLKINITSTORE_HI:`L15_NOC1BUFFER_BLKINITSTORE_LO
`define L15_NOC1BUFFER_DATA_INDEX  `L15_NOC1BUFFER_DATA_INDEX_HI:`L15_NOC1BUFFER_DATA_INDEX_LO
`define L15_NOC1BUFFER_CSM_TICKET  `L15_NOC1BUFFER_CSM_TICKET_HI:`L15_NOC1BUFFER_CSM_TICKET_LO
`define L15_NOC1BUFFER_HOMEID  `L15_NOC1BUFFER_HOMEID_HI:`L15_NOC1BUFFER_HOMEID_LO
`define L15_NOC1BUFFER_HOMEID_VAL  `L15_NOC1BUFFER_HOMEID_VAL_HI:`L15_NOC1BUFFER_HOMEID_VAL_LO
`define L15_NOC1BUFFER_CSM_SDID  `L15_NOC1BUFFER_CSM_SDID_HI:`L15_NOC1BUFFER_CSM_SDID_LO
`define L15_NOC1BUFFER_CSM_LSID  `L15_NOC1BUFFER_CSM_LSID_HI:`L15_NOC1BUFFER_CSM_LSID_LO

`define L15_INT_VEC_DIS 40'h9800000800
// `define L15_CPUID_ADDRESS 40'h9800000900


`define L15_HMT_OP_WIDTH 1
`define L15_HMT_OP_WRITE 1'd1


////////////////
// CSM
////////////////
`define L15_CSM_NUM_TICKETS 8
`define L15_CSM_NUM_TICKETS_LOG2 3

// Tri: save space on l15 sram
`define L15_CSM_GHID_CHIPID_WIDTH 14
`define L15_CSM_GHID_XPOS_WIDTH 8
`define L15_CSM_GHID_YPOS_WIDTH 8
`define L15_CSM_GHID_WIDTH `L15_CSM_GHID_CHIPID_WIDTH + `L15_CSM_GHID_XPOS_WIDTH + `L15_CSM_GHID_YPOS_WIDTH
`define L15_CSM_GHID_CHIP_MASK `L15_CSM_GHID_WIDTH - 1 -:  `L15_CSM_GHID_CHIPID_WIDTH
`define L15_CSM_GHID_XPOS_MASK `L15_CSM_GHID_XPOS_WIDTH + `L15_CSM_GHID_YPOS_WIDTH - 1 -: `L15_CSM_GHID_XPOS_WIDTH
`define L15_CSM_GHID_YPOS_MASK `L15_CSM_GHID_YPOS_WIDTH - 1 -: `L15_CSM_GHID_YPOS_WIDTH


`define L15_CSM_OP_WIDTH 3
`define L15_CSM_OP_READ_GHID 3'd1
`define L15_CSM_OP_READ_GHID_IF_TAGCHECK_SI 3'd2
`define L15_CSM_OP_HMC_FILL 3'd3
`define L15_CSM_OP_HMC_DIAG_STORE 3'd4
`define L15_CSM_OP_HMC_DIAG_LOAD 3'd5
`define L15_CSM_OP_READ_GHID_IF_TAGCHECK_MISS 3'd6
`define L15_CSM_OP_HMC_FLUSH 3'd7

//HMC array

`define L15_HMC_ENTRIES          16
`define L15_HMC_INDEX_WIDTH      4
`define L15_HMC_ADDR_WIDTH       16
`define L15_HMC_TAG_WIDTH        14
`define L15_HMC_OFFSET_WIDTH     2
`define L15_HMC_DATA_IN_WIDTH    128
`define L15_HMC_DATA_OUT_WIDTH   30
`define L15_HMC_VALID_WIDTH      4
`define L15_HMC_DATA_WIDTH       120
`define L15_HMC_DATA_NUM         4

`define L15_HMC_ADDR_TAG         15:2
`define L15_HMC_ADDR_OFFSET      1:0
`define L15_HMC_ADDR_INDEX       5:2
`define L15_HMC_ADDR_SDID        15:6
`define L15_HMC_ADDR_LSID        5:0


`define L15_HMC_ARRAY_WIDTH      138

`define L15_HMC_TAG              137:124
`define L15_HMC_VALID            123:120
`define L15_HMC_DATA             119:0
`define L15_HMC_SDID             137:128

`define L15_HMC_DATA_CHIPID      29:16
`define L15_HMC_DATA_X           15:8
`define L15_HMC_DATA_Y           7:0

`define L15_HMT_BASE_ADDR_WIDTH  22

//Special addresses for HMC
`define L15_HMC_ADDR_OP_WIDTH            2
`define L15_HMC_ADDR_OP                  31:30
//`define L15_ADDR_TYPE_TAG_ACCESS     8'hb4 // later
//`define L15_ADDR_TYPE_STATE_ACCESS   8'hb6 // later
//`define L15_ADDR_TYPE_DIR_ACCESS     8'hb1 // later
//`define L15_ADDR_TYPE_CTRL_REG       8'hb9
//`define L15_ADDR_TYPE_DIS_FLUSH      8'hbc, 8'hbd, 8'hbe, 8'hbf
// `define L15_ADDR_TYPE_HMT_BASE_REG      8'hb7


`define L15_ADDR_TYPE_WIDTH          8
`define L15_ADDR_TYPE                39:32

`define L15_ADDR_TYPE_DATA_ACCESS       8'hb0
`define L15_ADDR_TYPE_HMC_ACCESS        8'hb2 // todo
`define L15_ADDR_TYPE_LINE_FLUSH        8'hb3
`define L15_ADDR_TYPE_HMC_FLUSH         8'hb5 // todo
`define L15_ADDR_TYPE_CONFIG_REGS       8'hba

`define L15_HOMEID_SRC_WIDTH            2
`define L15_HOMEID_SRC_CSM_MODULE       2'd1
`define L15_HOMEID_SRC_NOC2_SOURCE      2'd2
`define L15_HOMEID_SRC_HMT              2'd3

`endif


