# Modified by Princeton University on June 9th, 2015
# ========== Copyright Header Begin ==========================================
# 
# OpenSPARC T1 Processor File: sjm_5.cmd
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
CONFIG id=30 iosyncadr=0x7EF00BEEF00
TIMEOUT 10000000
IOSYNC
#==================================================
#==================================================


LABEL_0:

INT  0x0000013f00000000 +
        0xde55205c 0x7e8c8955 0x27f8e01c 0x80c47f02 +
        0x88d07b53 0x608f671e 0xbc71626e 0x9c7788b9 +
        0x42f2033c 0xb2eefe9c 0xe2e8f3b3 0x6310fab3 +
        0x1d6fcb7e 0x41a227e0 0xe0a82cde 0xbe9bc795 

WRITEIO  0x000006102cd60c80 4 0xa1f4a356 

READIO  0x000006102cd60c80 4 0xa1f4a356 
INT  0x0000010f00000000 +
        0xc1431574 0xf84df36d 0x8c04d2e5 0xa3617f9a +
        0x719ae723 0x55b9e445 0x9469880f 0x56e45ff6 +
        0x952cfca6 0xa1f34b37 0x534a2125 0xfe6abdc8 +
        0xec017648 0xa8dc8116 0x779c763e 0x8f4c9b6e 

WRITEIO  0x0000061a8e5d3640 16 0xd88b9a6d 0x49ee2e5d 0x8f59e928 0xa79ea14c 

WRITEBLK  0x0000001b6eb31d40 +
        0xb06a5614 0x2b245667 0xf95c61c3 0x9396589b +
        0xbaba25c9 0x0467d5d1 0xdf9d84c5 0x5939c5bd +
        0x46d35842 0x387a393d 0x50abc889 0x73142d4c +
        0x5661ed4a 0x957c9681 0x706be726 0xc0623276 

WRITEBLK  0x0000000c7afe4140 +
        0x01f371ea 0x4fe30638 0x59734f00 0xab0ac2dc +
        0x930db8a4 0xeef969d3 0xd1b0300c 0x1247801a +
        0xac9aebe6 0xe67400bf 0x9148e336 0x22015d88 +
        0x6428141f 0xccc274b2 0x0c6558dd 0x18473585 

INT  0x000001df00000000 +
        0xba65368d 0xf4d176c7 0x1fd93440 0xe1fbd0ed +
        0x548f08bd 0x618c02e9 0xcf6a705c 0xd8d0cce0 +
        0xd9f9ba7f 0xa9c1a983 0x5d4edd6e 0x596dd5d3 +
        0xce77797f 0x113f640d 0x67e5d871 0xaec75899 

WRITEBLK  0x0000001557ee8200 +
        0x75a0c2c3 0x60747f84 0xa16b99b2 0x7b82c1b8 +
        0xaa0372a2 0xa027335e 0xefbd20cf 0x1f81b7be +
        0x23abfc2a 0x391daa00 0xac93e6ff 0x48da2310 +
        0x4ab2b2b4 0xde5cb91e 0xd9a68d80 0x4fed3e8e 

READBLK  0x0000001b6eb31d40 +
        0xb06a5614 0x2b245667 0xf95c61c3 0x9396589b +
        0xbaba25c9 0x0467d5d1 0xdf9d84c5 0x5939c5bd +
        0x46d35842 0x387a393d 0x50abc889 0x73142d4c +
        0x5661ed4a 0x957c9681 0x706be726 0xc0623276 

WRITEBLKIO  0x0000061677a06300 +
        0xcb9185a2 0xd8f012ff 0x85c2f64c 0x85362705 +
        0x366764dc 0x60bba4b1 0x2de5e3d3 0x4032a890 +
        0x318fd9e6 0x0a6db162 0x2b683dd2 0x4d15db2d +
        0x0df1cda7 0xc70b3912 0x425a7fed 0x2bbdc6d1 

READBLK  0x0000000c7afe4140 +
        0x01f371ea 0x4fe30638 0x59734f00 0xab0ac2dc +
        0x930db8a4 0xeef969d3 0xd1b0300c 0x1247801a +
        0xac9aebe6 0xe67400bf 0x9148e336 0x22015d88 +
        0x6428141f 0xccc274b2 0x0c6558dd 0x18473585 

READBLKIO  0x0000061677a06300 +
        0xcb9185a2 0xd8f012ff 0x85c2f64c 0x85362705 +
        0x366764dc 0x60bba4b1 0x2de5e3d3 0x4032a890 +
        0x318fd9e6 0x0a6db162 0x2b683dd2 0x4d15db2d +
        0x0df1cda7 0xc70b3912 0x425a7fed 0x2bbdc6d1 

READBLK  0x0000001557ee8200 +
        0x75a0c2c3 0x60747f84 0xa16b99b2 0x7b82c1b8 +
        0xaa0372a2 0xa027335e 0xefbd20cf 0x1f81b7be +
        0x23abfc2a 0x391daa00 0xac93e6ff 0x48da2310 +
        0x4ab2b2b4 0xde5cb91e 0xd9a68d80 0x4fed3e8e 

WRITEMSKIO  0x0000060dd0302940 0xf00f  0x74f8ed62 0x00000000 0x00000000 0xa7c73630 

WRITEIO  0x00000609337ae3c0 8 0xcc960f3d 0xb6f6ca8b 

WRITEIO  0x0000061598d77200 8 0xc5137367 0x93ed3382 

READIO  0x0000061a8e5d3640 16 0xd88b9a6d 0x49ee2e5d 0x8f59e928 0xa79ea14c 
WRITEBLK  0x000000142e7625c0 +
        0x24bf80f7 0x31294fe8 0x64d36bbc 0x5ed0b4f1 +
        0xce7d1b2e 0x926b05f6 0xc2bba96d 0xac099768 +
        0xb2a4d5cb 0x94646294 0xbb93e17a 0xa95ef589 +
        0xb4d36075 0x4e7920a1 0xe2216446 0x61d2ddf0 

WRITEMSK  0x000000142e7625c0 0x00000000f0f00ff0 +
        0x00000000 0x00000000 0x00000000 0x00000000 +
        0x00000000 0x00000000 0x00000000 0x00000000 +
        0xfc6bc679 0x00000000 0xe9decdda 0x00000000 +
        0x00000000 0x3b169f56 0x9c398717 0x00000000 

WRITEMSKIO  0x00000618d1d8f480 0x000f  0x00000000 0x00000000 0x00000000 0x23e8f70a 

WRITEIO  0x0000061f0c8d8c00 8 0xf4897aee 0x1a1e0f4f 

WRITEBLKIO  0x0000060ed0e0d880 +
        0x5740f561 0x83d2c268 0xf722c26e 0xba56e571 +
        0xb1b713cc 0x4453eadf 0x52f27dd1 0x1f254761 +
        0x9130b319 0xe8131ee7 0x090eb2be 0x31237d72 +
        0x87100611 0x3c6dbf61 0x2e782742 0x04d92728 

WRITEBLKIO  0x0000060877d4b380 +
        0x0af7343c 0x80691066 0x6aa03f56 0x5a2913ab +
        0xda9f77f9 0xcb173de4 0x6e075a12 0xb33a8d52 +
        0xcdf52130 0xc27d629d 0x571b9e0b 0xa8f6d43b +
        0x58f4241e 0x84ac7d8a 0xb9f72fb9 0xf909ac41 

WRITEBLKIO  0x0000061136e5c840 +
        0x6229a497 0x8716869b 0xff4759dd 0x05e4c89b +
        0xcfb54924 0xce15245f 0xce715d4d 0xefc0873c +
        0xbf9e1fd5 0xba4bcc52 0x857a80c6 0x5b96d5bc +
        0xf39768bf 0xba49ca6d 0x2a2028ea 0x2ca25dd3 

READMSKIO   0x0000060dd0302940 0xf00f  0x74f8ed62 0x00000000 0x00000000 0xa7c73630 

READBLKIO  0x0000060ed0e0d880 +
        0x5740f561 0x83d2c268 0xf722c26e 0xba56e571 +
        0xb1b713cc 0x4453eadf 0x52f27dd1 0x1f254761 +
        0x9130b319 0xe8131ee7 0x090eb2be 0x31237d72 +
        0x87100611 0x3c6dbf61 0x2e782742 0x04d92728 

WRITEMSK  0x000000142e7625c0 0x00ff0fff0f0f0fff +
        0x00000000 0x00000000 0xa427698c 0x2181d767 +
        0x00000000 0x51a5daaa 0x6044f310 0xa27a8e72 +
        0x00000000 0xc1c9033e 0x00000000 0x7411b01e +
        0x00000000 0xd0e49bd6 0xf32f2ef4 0x64defce9 

READBLKIO  0x0000060877d4b380 +
        0x0af7343c 0x80691066 0x6aa03f56 0x5a2913ab +
        0xda9f77f9 0xcb173de4 0x6e075a12 0xb33a8d52 +
        0xcdf52130 0xc27d629d 0x571b9e0b 0xa8f6d43b +
        0x58f4241e 0x84ac7d8a 0xb9f72fb9 0xf909ac41 

WRITEMSK  0x000000142e7625c0 0x0000f00ffffff00f +
        0x00000000 0x00000000 0x00000000 0x00000000 +
        0xf4a1ceb0 0x00000000 0x00000000 0x6dc4c2e6 +
        0x7e0aa01d 0x4d0ce880 0x00eb5ae9 0x890c9247 +
        0xffa28db7 0x00000000 0x00000000 0x8e46b126 

WRITEMSK  0x000000142e7625c0 0x000f00fff0ff0f0f +
        0x00000000 0x00000000 0x00000000 0x02908d87 +
        0x00000000 0x00000000 0x981a6d08 0x1371adf3 +
        0x95328fc5 0x00000000 0x79e35b78 0xb8a4b902 +
        0x00000000 0xe92bd86c 0x00000000 0x2bf77f49 

READBLK  0x000000142e7625c0 +
        0x24bf80f7 0x31294fe8 0xa427698c 0x02908d87 +
        0xf4a1ceb0 0x51a5daaa 0x981a6d08 0x1371adf3 +
        0x95328fc5 0x4d0ce880 0x79e35b78 0xb8a4b902 +
        0xffa28db7 0xe92bd86c 0xf32f2ef4 0x2bf77f49 

READMSKIO   0x00000618d1d8f480 0x000f  0x00000000 0x00000000 0x00000000 0x23e8f70a 

WRITEBLKIO  0x00000618e1c3af00 +
        0x5beac1f1 0xb1205a14 0x8e940497 0xf01d1c0c +
        0xc0a47a80 0x8fd78d82 0xcd516492 0xaf68ca45 +
        0xf0c5f99e 0x17c3cb66 0x499172c7 0xabebb29d +
        0xb1a8ac9b 0xb28d938e 0x950a4779 0x07cb26cb 

INT  0x0000007f00000000 +
        0x9a6690c6 0x15a8015b 0x720eb9bc 0x4eb0c1ad +
        0xfd189bb7 0xa77a3602 0x17a64868 0x6b6697a5 +
        0xc98aceb2 0xf967b3ec 0xfd630a5c 0xb7c36a79 +
        0xed88b1cb 0x94ff9dca 0x37a98478 0x914a1eb7 

WRITEBLKIO  0x0000060f677ff680 +
        0xe1ce7556 0xbab570d0 0xe80ff2c1 0x3aafec2b +
        0x3a44fae6 0x0a0ddfbe 0x6a817138 0x46c465a2 +
        0x5d9be618 0xcc2d724c 0x28ca4725 0x4a51d616 +
        0xa52f4375 0xda9bcd13 0x27579572 0x6adac3f0 

WRITEIO  0x00000603b41b3b40 4 0xe07df0df 

READIO  0x00000609337ae3c0 8 0xcc960f3d 0xb6f6ca8b 
INT  0x000001bf00000000 +
        0x278b71c5 0xb238e3a7 0xb2bbb5cc 0xdb37538d +
        0x050ba911 0xfae5b7d1 0xb6a49395 0xab222621 +
        0xce42d483 0x2ad696d4 0x66124a89 0xd37d14da +
        0xd9812b02 0xa271050e 0x8cb419f4 0xf66fff52 

WRITEIO  0x000006152e7aabc0 8 0x5c15ed90 0xef25a378 

WRITEIO  0x0000060351b1fb00 4 0x0e0a9ab0 

READIO  0x0000061598d77200 8 0xc5137367 0x93ed3382 
INT  0x0000005f00000000 +
        0x9b9383aa 0x79092aaf 0x5c6ff9d5 0x9b98a844 +
        0xf65cf9d2 0x072d0c67 0x02d5a1a7 0xf847cc5e +
        0xaf689816 0xe9be73b5 0x3aef6cb6 0xd1e98581 +
        0x3f29fc6c 0x30cc2471 0x8c8e735c 0x9bc630af 

READIO  0x0000061f0c8d8c00 8 0xf4897aee 0x1a1e0f4f 
INT  0x0000004f00000000 +
        0xda01eb46 0x4eec07b2 0xe04216e7 0x9fcd7aad +
        0xeab507b2 0xde31f584 0x54edfc64 0x0c90f0e3 +
        0x9d0c3cac 0x6af73db5 0xdc28cc5f 0x40b566bb +
        0x5a01c517 0xc23552ba 0x2891b971 0x7b81795a 

READBLKIO  0x0000061136e5c840 +
        0x6229a497 0x8716869b 0xff4759dd 0x05e4c89b +
        0xcfb54924 0xce15245f 0xce715d4d 0xefc0873c +
        0xbf9e1fd5 0xba4bcc52 0x857a80c6 0x5b96d5bc +
        0xf39768bf 0xba49ca6d 0x2a2028ea 0x2ca25dd3 

READIO  0x00000603b41b3b40 4 0xe07df0df 
WRITEBLK  0x00000014c0d83f80 +
        0xe9edc40c 0x9d4f9e3d 0x1fea165a 0xe2a1f5e6 +
        0xa33e3f51 0xfed71943 0xf84c33d0 0x4f9c0804 +
        0x5f2d9a57 0xa25054a0 0x1589cfcb 0x9bcd166b +
        0x9f5270b8 0xfc0460ff 0x36656ff9 0x85e3577c 

READBLK  0x00000014c0d83f80 +
        0xe9edc40c 0x9d4f9e3d 0x1fea165a 0xe2a1f5e6 +
        0xa33e3f51 0xfed71943 0xf84c33d0 0x4f9c0804 +
        0x5f2d9a57 0xa25054a0 0x1589cfcb 0x9bcd166b +
        0x9f5270b8 0xfc0460ff 0x36656ff9 0x85e3577c 

WRITEBLKIO  0x00000610b64a6980 +
        0xa977a92b 0x0193d6fb 0x171a6b92 0x52f9d09e +
        0x876a0306 0xe7800d4d 0x9b101687 0xa95a3945 +
        0x6108676d 0x31b9a158 0x784ddbc5 0x8eead57a +
        0xf4ef0de0 0x3ead462d 0x5ca847d7 0x07709d6f 

WRITEMSKIO  0x000006179e845080 0x0fff  0x00000000 0xba65e367 0xdb1a1d41 0x3c8227ad 

INT  0x0000003f00000000 +
        0x12e70f24 0x7a94769c 0xdca4a3b7 0x2cada0ba +
        0x38951971 0x2232de68 0xeaadaaeb 0xc36fb104 +
        0xe887b849 0xb8b0e464 0xd51c9d70 0x18b1cc16 +
        0xad12721e 0x2211cd4b 0x15e46ced 0xf6d2f9c2 

READMSKIO   0x000006179e845080 0x0fff  0x00000000 0xba65e367 0xdb1a1d41 0x3c8227ad 

WRITEMSKIO  0x0000061ecc670cc0 0x0fff  0x00000000 0x20949fc0 0x91d34d4c 0x4888a1a9 

WRITEBLKIO  0x0000061f93637dc0 +
        0xed8c3804 0xce740503 0x96ce05c3 0x3c27879e +
        0xadd05fe2 0xe6447bd6 0x0e8d9ecd 0x4a634071 +
        0x8112e92a 0xb3d07c6a 0x701af321 0xae91375b +
        0x96679363 0xc416967e 0x1caf4744 0x4664eba3 

READMSKIO   0x0000061ecc670cc0 0x0fff  0x00000000 0x20949fc0 0x91d34d4c 0x4888a1a9 

READBLKIO  0x00000618e1c3af00 +
        0x5beac1f1 0xb1205a14 0x8e940497 0xf01d1c0c +
        0xc0a47a80 0x8fd78d82 0xcd516492 0xaf68ca45 +
        0xf0c5f99e 0x17c3cb66 0x499172c7 0xabebb29d +
        0xb1a8ac9b 0xb28d938e 0x950a4779 0x07cb26cb 

READBLKIO  0x0000060f677ff680 +
        0xe1ce7556 0xbab570d0 0xe80ff2c1 0x3aafec2b +
        0x3a44fae6 0x0a0ddfbe 0x6a817138 0x46c465a2 +
        0x5d9be618 0xcc2d724c 0x28ca4725 0x4a51d616 +
        0xa52f4375 0xda9bcd13 0x27579572 0x6adac3f0 

WRITEIO  0x0000060ea3b34040 4 0xfbb2ea13 

WRITEMSKIO  0x0000060e800db700 0xf0ff  0xdd2706b6 0x00000000 0x2f1cbfd9 0xcf7e15cd 

READIO  0x000006152e7aabc0 8 0x5c15ed90 0xef25a378 
WRITEIO  0x0000061ee534a940 4 0xf32b7fcb 

READIO  0x0000060351b1fb00 4 0x0e0a9ab0 
WRITEBLKIO  0x00000600f0381200 +
        0x454ad0f6 0x786c315a 0xc081e5b2 0x095b909b +
        0x0e030788 0x43e79279 0xb8749ec9 0x8a5425cc +
        0xc4ea3172 0x76285dde 0xf2f0cf35 0x33bcf9fe +
        0xd47c16df 0x3718fc9a 0x14b26ebe 0x79819117 

READBLKIO  0x00000610b64a6980 +
        0xa977a92b 0x0193d6fb 0x171a6b92 0x52f9d09e +
        0x876a0306 0xe7800d4d 0x9b101687 0xa95a3945 +
        0x6108676d 0x31b9a158 0x784ddbc5 0x8eead57a +
        0xf4ef0de0 0x3ead462d 0x5ca847d7 0x07709d6f 

READMSKIO   0x0000060e800db700 0xf0ff  0xdd2706b6 0x00000000 0x2f1cbfd9 0xcf7e15cd 

READBLKIO  0x0000061f93637dc0 +
        0xed8c3804 0xce740503 0x96ce05c3 0x3c27879e +
        0xadd05fe2 0xe6447bd6 0x0e8d9ecd 0x4a634071 +
        0x8112e92a 0xb3d07c6a 0x701af321 0xae91375b +
        0x96679363 0xc416967e 0x1caf4744 0x4664eba3 

WRITEBLKIO  0x0000060503a82140 +
        0x2a0dfa80 0xcd04b3db 0xec71da07 0x983c7c8f +
        0x8ea20f55 0x96fc4ee0 0x712faa5d 0x30514380 +
        0xa7373aca 0xa308a781 0x6f7661ec 0x9b0211b5 +
        0x12b6d483 0x5c28987d 0x20d8214f 0xc0a8be33 

WRITEBLK  0x00000012ee8a8e40 +
        0x7de7c770 0xc54bf9c4 0xc3ddaf89 0x29b186bf +
        0x3809fabd 0x566a5e5c 0xf14724a1 0x20ddae0b +
        0x8da07101 0xbcf905f1 0x75dadf16 0x399e52ad +
        0x837fee28 0x41cd419f 0xa2d6d421 0xc93bc585 

WRITEBLK  0x00000014651c3d00 +
        0x3ce4046f 0xac75b9e5 0x028d21e3 0xf885afb0 +
        0xaf8cc4a5 0x84aafc7e 0x197c5714 0xd36c0fd6 +
        0x7b637b0c 0xe088ec1d 0x0a749c4a 0x91d97d61 +
        0x377aedae 0x59df60aa 0x4af24aa8 0x7b450370 

WRITEMSK  0x00000012ee8a8e40 0x0f000ff000f0f0ff +
        0x00000000 0xc155c718 0x00000000 0x00000000 +
        0x00000000 0x17271f85 0x355cbdcc 0x00000000 +
        0x00000000 0x00000000 0x2f22acbf 0x00000000 +
        0x57710581 0x00000000 0x8b9da310 0xfc79eda0 

WRITEIO  0x0000060a0503ee00 4 0x65181143 

WRITEBLK  0x0000000e0e21b580 +
        0xf89736e4 0x4185f199 0x467b56ff 0x8d2317b0 +
        0x156d86a1 0x1d4d9304 0x5b3fe212 0x5b0bd8b3 +
        0x09053a6f 0xc22818e5 0xcc64f202 0x84e03d80 +
        0x172c9398 0xe193ceb6 0x905a6423 0x95c5b639 

WRITEBLKIO  0x00000604f02f5f40 +
        0xc354bcff 0x09b23e37 0x35b0ecd5 0x70d93b03 +
        0x33748abe 0x1981a6cb 0x99e3c498 0x13a007af +
        0x3ae7adf2 0xa69af8bd 0x47e37311 0x558c35ac +
        0x1f086b4d 0x22f14f03 0x6f8b5f90 0xf3dcb3e6 

READBLKIO  0x00000600f0381200 +
        0x454ad0f6 0x786c315a 0xc081e5b2 0x095b909b +
        0x0e030788 0x43e79279 0xb8749ec9 0x8a5425cc +
        0xc4ea3172 0x76285dde 0xf2f0cf35 0x33bcf9fe +
        0xd47c16df 0x3718fc9a 0x14b26ebe 0x79819117 

WRITEBLK  0x0000001128263ec0 +
        0x607c28d4 0x382c5f18 0x049447ff 0x0c415dc1 +
        0x5b34449d 0x17cde017 0x445d9598 0xe91e58d5 +
        0xa5a4f83b 0x39662757 0xf312a555 0x28164ebe +
        0x439f20aa 0xe14c8a2e 0xd8bf80fe 0x8ff26e34 

INT  0x0000010f00000000 +
        0x3c432a97 0x701a86a0 0xba48800d 0xe73b626f +
        0xed0fa884 0x450dd668 0xeb9c0404 0x1dce0594 +
        0xdf6a84c4 0xfc5d49e6 0xb5bf006e 0xd7bf3177 +
        0xb17ddc81 0x8b4ba72f 0x219caee2 0x9cc6b01b 

WRITEIO  0x0000061cc800bb40 8 0x265bc976 0xabb87874 

READIO  0x0000060ea3b34040 4 0xfbb2ea13 
WRITEMSKIO  0x00000611d8a57fc0 0x000f  0x00000000 0x00000000 0x00000000 0x77930e07 

WRITEBLKIO  0x00000616f4e1ad40 +
        0x04e1700e 0x4f64d081 0x6c7e34b2 0xea40fcd4 +
        0x1dfb1a27 0x60d98366 0x42bc117a 0x86b9be8d +
        0x9881ae9e 0x7b347dae 0x1f722c74 0xc9f0ce64 +
        0xe6a0b0fc 0xa55afa10 0x728cb3bd 0x28814f8f 

WRITEIO  0x0000061c8c839380 4 0x6b03b606 

READBLKIO  0x0000060503a82140 +
        0x2a0dfa80 0xcd04b3db 0xec71da07 0x983c7c8f +
        0x8ea20f55 0x96fc4ee0 0x712faa5d 0x30514380 +
        0xa7373aca 0xa308a781 0x6f7661ec 0x9b0211b5 +
        0x12b6d483 0x5c28987d 0x20d8214f 0xc0a8be33 

WRITEMSK  0x00000012ee8a8e40 0xf000ff00ff00f0ff +
        0x855ec206 0x00000000 0x00000000 0x00000000 +
        0x2048c8e5 0x78c2b8fb 0x00000000 0x00000000 +
        0xa2779150 0xda042cc3 0x00000000 0x00000000 +
        0xa246748c 0x00000000 0xa996a041 0xe900b2d0 

WRITEIO  0x00000608ccf81a00 4 0xf37c8f15 

WRITEMSKIO  0x00000616143dce00 0xffff  0xe2afda6b 0xd97f44b1 0xd6e14de5 0xefd3ccf1 
