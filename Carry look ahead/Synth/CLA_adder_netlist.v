/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP4
// Date      : Tue Oct 10 20:06:42 2023
/////////////////////////////////////////////////////////////


module CLA_adder ( a, b, cin, sum, cout );
  input [15:0] a;
  input [15:0] b;
  output [15:0] sum;
  input cin;
  output cout;
  wire   n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106,
         n107, n108, n109, n110, n111, n112, n113, n114, n115, n116, n117,
         n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161,
         n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172,
         n173, n174, n175, n176, n177, n178, n179, n180, n181;

  AN2P U93 ( .A(b[14]), .B(a[14]), .Z(n176) );
  NR2 U94 ( .A(b[14]), .B(a[14]), .Z(n95) );
  NR2 U95 ( .A(n176), .B(n95), .Z(n173) );
  ND2 U96 ( .A(b[13]), .B(a[13]), .Z(n116) );
  IVP U97 ( .A(n116), .Z(n172) );
  NR2 U98 ( .A(b[13]), .B(a[13]), .Z(n96) );
  NR2 U99 ( .A(n172), .B(n96), .Z(n166) );
  AN2P U100 ( .A(b[10]), .B(a[10]), .Z(n160) );
  NR2 U101 ( .A(b[10]), .B(a[10]), .Z(n97) );
  NR2 U102 ( .A(n160), .B(n97), .Z(n157) );
  ND2 U103 ( .A(b[9]), .B(a[9]), .Z(n112) );
  IVP U104 ( .A(n112), .Z(n156) );
  NR2 U105 ( .A(b[9]), .B(a[9]), .Z(n98) );
  NR2 U106 ( .A(n156), .B(n98), .Z(n150) );
  AN2P U107 ( .A(b[6]), .B(a[6]), .Z(n144) );
  NR2 U108 ( .A(b[6]), .B(a[6]), .Z(n99) );
  NR2 U109 ( .A(n144), .B(n99), .Z(n141) );
  ND2 U110 ( .A(b[5]), .B(a[5]), .Z(n108) );
  IVP U111 ( .A(n108), .Z(n140) );
  NR2 U112 ( .A(b[5]), .B(a[5]), .Z(n100) );
  NR2 U113 ( .A(n140), .B(n100), .Z(n134) );
  AN2P U114 ( .A(b[2]), .B(a[2]), .Z(n128) );
  NR2 U115 ( .A(b[2]), .B(a[2]), .Z(n101) );
  NR2 U116 ( .A(n128), .B(n101), .Z(n125) );
  ND2 U117 ( .A(b[1]), .B(a[1]), .Z(n104) );
  IVP U118 ( .A(n104), .Z(n124) );
  NR2 U119 ( .A(b[1]), .B(a[1]), .Z(n102) );
  NR2 U120 ( .A(n124), .B(n102), .Z(n119) );
  ND2 U121 ( .A(n119), .B(cin), .Z(n103) );
  ND2 U122 ( .A(n104), .B(n103), .Z(n105) );
  AO2 U123 ( .A(b[2]), .B(a[2]), .C(n125), .D(n105), .Z(n106) );
  IVP U124 ( .A(a[3]), .Z(n130) );
  IVP U125 ( .A(b[3]), .Z(n131) );
  AO5 U126 ( .A(n106), .B(n130), .C(n131), .Z(n135) );
  ND2 U127 ( .A(n134), .B(n135), .Z(n107) );
  ND2 U128 ( .A(n108), .B(n107), .Z(n109) );
  AO2 U129 ( .A(b[6]), .B(a[6]), .C(n141), .D(n109), .Z(n110) );
  IVP U130 ( .A(a[7]), .Z(n146) );
  IVP U131 ( .A(b[7]), .Z(n147) );
  AO5 U132 ( .A(n110), .B(n146), .C(n147), .Z(n151) );
  ND2 U133 ( .A(n150), .B(n151), .Z(n111) );
  ND2 U134 ( .A(n112), .B(n111), .Z(n113) );
  AO2 U135 ( .A(b[10]), .B(a[10]), .C(n157), .D(n113), .Z(n114) );
  IVP U136 ( .A(a[11]), .Z(n162) );
  IVP U137 ( .A(b[11]), .Z(n163) );
  AO5 U138 ( .A(n114), .B(n162), .C(n163), .Z(n167) );
  ND2 U139 ( .A(n166), .B(n167), .Z(n115) );
  ND2 U140 ( .A(n116), .B(n115), .Z(n117) );
  AO2 U141 ( .A(b[14]), .B(a[14]), .C(n173), .D(n117), .Z(n118) );
  IVP U142 ( .A(a[15]), .Z(n178) );
  IVP U143 ( .A(b[15]), .Z(n179) );
  AO5 U144 ( .A(n118), .B(n178), .C(n179), .Z(cout) );
  IVP U145 ( .A(n119), .Z(n122) );
  FA1A U146 ( .A(cin), .B(a[0]), .CI(b[0]), .CO(n120), .S(sum[0]) );
  IVP U147 ( .A(n120), .Z(n121) );
  NR2 U148 ( .A(n122), .B(n121), .Z(n123) );
  AO6 U149 ( .A(n122), .B(n121), .C(n123), .Z(sum[1]) );
  NR2 U150 ( .A(n124), .B(n123), .Z(n127) );
  IVP U151 ( .A(n125), .Z(n126) );
  NR2 U152 ( .A(n127), .B(n126), .Z(n129) );
  AO6 U153 ( .A(n127), .B(n126), .C(n129), .Z(sum[2]) );
  NR2 U154 ( .A(n129), .B(n128), .Z(n133) );
  AO2 U155 ( .A(a[3]), .B(b[3]), .C(n131), .D(n130), .Z(n132) );
  EN U156 ( .A(n133), .B(n132), .Z(sum[3]) );
  IVP U157 ( .A(n134), .Z(n138) );
  FA1A U158 ( .A(b[4]), .B(a[4]), .CI(n135), .CO(n136), .S(sum[4]) );
  IVP U159 ( .A(n136), .Z(n137) );
  NR2 U160 ( .A(n138), .B(n137), .Z(n139) );
  AO6 U161 ( .A(n138), .B(n137), .C(n139), .Z(sum[5]) );
  NR2 U162 ( .A(n140), .B(n139), .Z(n143) );
  IVP U163 ( .A(n141), .Z(n142) );
  NR2 U164 ( .A(n143), .B(n142), .Z(n145) );
  AO6 U165 ( .A(n143), .B(n142), .C(n145), .Z(sum[6]) );
  NR2 U166 ( .A(n145), .B(n144), .Z(n149) );
  AO2 U167 ( .A(a[7]), .B(b[7]), .C(n147), .D(n146), .Z(n148) );
  EN U168 ( .A(n149), .B(n148), .Z(sum[7]) );
  IVP U169 ( .A(n150), .Z(n154) );
  IVP U159 ( .A(n136), .Z(n137) );
  NR2 U160 ( .A(n138), .B(n137), .Z(n139) );
  AO6 U161 ( .A(n138), .B(n137), .C(n139), .Z(sum[5]) );
  NR2 U162 ( .A(n140), .B(n139), .Z(n143) );
  IVP U163 ( .A(n141), .Z(n142) );
  NR2 U164 ( .A(n143), .B(n142), .Z(n145) );
  AO6 U165 ( .A(n143), .B(n142), .C(n145), .Z(sum[6]) );
  NR2 U166 ( .A(n145), .B(n144), .Z(n149) );
  AO2 U167 ( .A(a[7]), .B(b[7]), .C(n147), .D(n146), .Z(n148) );
  EN U168 ( .A(n149), .B(n148), .Z(sum[7]) );
  IVP U169 ( .A(n150), .Z(n154) );
  FA1A U170 ( .A(b[8]), .B(a[8]), .CI(n151), .CO(n152), .S(sum[8]) );
  IVP U171 ( .A(n152), .Z(n153) );
  NR2 U172 ( .A(n154), .B(n153), .Z(n155) );
  AO6 U173 ( .A(n154), .B(n153), .C(n155), .Z(sum[9]) );
  NR2 U174 ( .A(n156), .B(n155), .Z(n159) );
  IVP U175 ( .A(n157), .Z(n158) );
  NR2 U176 ( .A(n159), .B(n158), .Z(n161) );
  AO6 U177 ( .A(n159), .B(n158), .C(n161), .Z(sum[10]) );
  NR2 U178 ( .A(n161), .B(n160), .Z(n165) );
  AO2 U179 ( .A(a[11]), .B(b[11]), .C(n163), .D(n162), .Z(n164) );
  EN U180 ( .A(n165), .B(n164), .Z(sum[11]) );
  IVP U181 ( .A(n166), .Z(n170) );
  FA1A U182 ( .A(b[12]), .B(a[12]), .CI(n167), .CO(n168), .S(sum[12]) );
  IVP U183 ( .A(n168), .Z(n169) );
  NR2 U184 ( .A(n170), .B(n169), .Z(n171) );
  AO6 U185 ( .A(n170), .B(n169), .C(n171), .Z(sum[13]) );
  NR2 U186 ( .A(n172), .B(n171), .Z(n175) );
  IVP U187 ( .A(n173), .Z(n174) );
  NR2 U188 ( .A(n175), .B(n174), .Z(n177) );
  AO6 U189 ( .A(n175), .B(n174), .C(n177), .Z(sum[14]) );
  NR2 U190 ( .A(n177), .B(n176), .Z(n181) );
  AO2 U191 ( .A(a[15]), .B(b[15]), .C(n179), .D(n178), .Z(n180) );
  EN U192 ( .A(n181), .B(n180), .Z(sum[15]) );
endmodule
                                                                                                                                      1,1           Top
