# Modified by Princeton University on June 9th, 2015
# ========== Copyright Header Begin ==========================================
# 
# OpenSPARC T1 Processor File: sjm_4.cmd
# Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
# 
# The above named program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public
# License version 2 as published by the Free Software Foundation.
# 
# The above named program is distributed in the hope that it will be 
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public
# License along with this work; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
# 
# ========== Copyright Header End ============================================
CONFIG id=28 iosyncadr=0x7CF00BEEF00
TIMEOUT 10000000
IOSYNC
#==================================================
#==================================================


LABEL_0:

WRITEBLK  0x000000023f190b80 +
        0x50c1e1a7 0x377cb786 0x00188dba 0x388b0b05 +
        0x2c73a8e4 0xda5a18cc 0xa72e0c80 0x82e81797 +
        0x57a79a22 0x2cf361cf 0x78e3f70f 0xb53f8e89 +
        0x7ee3ecd7 0xf906a610 0x52749a3b 0xf7eed7f3 

WRITEBLKIO  0x000006043b46f800 +
        0x7cf9c055 0x5508c3b8 0xeb3771c9 0x73098157 +
        0x8ff42f33 0xad905a53 0xeed33b12 0x27b04cc4 +
        0x4740837a 0x0f42d801 0x7180e7d8 0xe78c08b6 +
        0xcb4420ce 0xbfcbfa6a 0xb4caae68 0xae6dc824 

WRITEMSKIO  0x0000061908b94ac0 0x0f0f  0x00000000 0x46dfe457 0x00000000 0x9161e0b0 

WRITEMSK  0x000000023f190b80 0x0ff00f00ff0f00ff +
        0x00000000 0xfc56f024 0xb6e54ea4 0x00000000 +
        0x00000000 0xb4a09029 0x00000000 0x00000000 +
        0xb8cee35d 0x610f682d 0x00000000 0x9e77612b +
        0x00000000 0x00000000 0xc986094a 0xef93d043 

WRITEBLKIO  0x0000060c843ac540 +
        0x2d697884 0x9d3f1a18 0x4f135dd1 0xa1a4409e +
        0x3792e5ea 0x83e93a3e 0x04c9ac00 0x74e8ace4 +
        0xc808cbea 0x7dec57ac 0x8d5b95e1 0x4ce93aca +
        0x73536e17 0x11d55990 0x7bc658f2 0x44aaa8b1 

WRITEBLK  0x0000001e2c14a3c0 +
        0x82133c9a 0xc684a238 0x994fb14a 0x779b70a8 +
        0x1f3a8e11 0x677e46e6 0x72e98f2b 0xb6b9b3b7 +
        0x4fbb13d1 0x7779db96 0x26dc5eb5 0xb0dc7e34 +
        0xc38ec41e 0xedd15732 0xef41419b 0x0af42eeb 

READBLKIO  0x000006043b46f800 +
        0x7cf9c055 0x5508c3b8 0xeb3771c9 0x73098157 +
        0x8ff42f33 0xad905a53 0xeed33b12 0x27b04cc4 +
        0x4740837a 0x0f42d801 0x7180e7d8 0xe78c08b6 +
        0xcb4420ce 0xbfcbfa6a 0xb4caae68 0xae6dc824 

WRITEMSKIO  0x00000613f47e9b80 0x0ff0  0x00000000 0xb7cb03d0 0x43093578 0x00000000 

WRITEMSK  0x000000023f190b80 0x0f0f0ff0000ff0ff +
        0x00000000 0x2f961864 0x00000000 0x4a9f113b +
        0x00000000 0x9a71fc91 0x8dd99ccf 0x00000000 +
        0x00000000 0x00000000 0x00000000 0x0b19ed3e +
        0x859dae38 0x00000000 0x6ed401af 0xa9079a3a 

READBLKIO  0x0000060c843ac540 +
        0x2d697884 0x9d3f1a18 0x4f135dd1 0xa1a4409e +
        0x3792e5ea 0x83e93a3e 0x04c9ac00 0x74e8ace4 +
        0xc808cbea 0x7dec57ac 0x8d5b95e1 0x4ce93aca +
        0x73536e17 0x11d55990 0x7bc658f2 0x44aaa8b1 

READBLK  0x000000023f190b80 +
        0x50c1e1a7 0x2f961864 0xb6e54ea4 0x4a9f113b +
        0x2c73a8e4 0x9a71fc91 0x8dd99ccf 0x82e81797 +
        0xb8cee35d 0x610f682d 0x78e3f70f 0x0b19ed3e +
        0x859dae38 0xf906a610 0x6ed401af 0xa9079a3a 

WRITEIO  0x000006160e9d3780 8 0x20f4950f 0xf1fc651a 

READBLK  0x0000001e2c14a3c0 +
        0x82133c9a 0xc684a238 0x994fb14a 0x779b70a8 +
        0x1f3a8e11 0x677e46e6 0x72e98f2b 0xb6b9b3b7 +
        0x4fbb13d1 0x7779db96 0x26dc5eb5 0xb0dc7e34 +
        0xc38ec41e 0xedd15732 0xef41419b 0x0af42eeb 

WRITEIO  0x00000617f9d10d40 4 0x5a206c04 

WRITEIO  0x00000607d501ccc0 8 0x6a52cdea 0x1383c57c 

READMSKIO   0x0000061908b94ac0 0x0f0f  0x00000000 0x46dfe457 0x00000000 0x9161e0b0 

WRITEMSKIO  0x000006053568a040 0xf000  0x1104a29c 0x00000000 0x00000000 0x00000000 

READIO  0x000006160e9d3780 8 0x20f4950f 0xf1fc651a 
WRITEIO  0x00000607ef643d80 8 0xda500abb 0xa9527929 

WRITEBLKIO  0x0000060179fa31c0 +
        0x543d55d9 0x0b401ce0 0xf64b7127 0x4e8dbc0a +
        0x2633cb1a 0xc4fabb12 0x95c7fefd 0x033de344 +
        0xffe78186 0xce9179ba 0x6280fa47 0xeb299604 +
        0x4cf40b79 0x043d03c0 0xa7c6a836 0x2b13e9b5 

READIO  0x00000617f9d10d40 4 0x5a206c04 
WRITEBLKIO  0x0000060c597790c0 +
        0x1af37250 0x220a2fd4 0xe23e5fb2 0xc290e55a +
        0x260896d1 0x8614f3a7 0x9bc25c5d 0xeb7b0000 +
        0x202ec56d 0x4055494f 0x22fda428 0xc1fe5f32 +
        0x7137f6a4 0x36f070d5 0x1a05e577 0x301416c6 


BA LABEL_0
