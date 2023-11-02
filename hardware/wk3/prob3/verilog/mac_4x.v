// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac_4x (out, a0, a1, a2, a3, b0, b1, b2, b3, c);

parameter bw = 4;
parameter psum_bw = 16;

input unsigned [bw-1:0] a0;	    // X_in_0
input unsigned [bw-1:0] a1;	    // X_in_1
input unsigned [bw-1:0] a2;	    // X_in_2
input unsigned [bw-1:0] a3;	    // X_in_3
input signed [bw-1:0] b0;	    // Weight_0
input signed [bw-1:0] b1;	    // Weight_1
input signed [bw-1:0] b2;	    // Weight_2
input signed [bw-1:0] b3;	    // Weight_3
input signed [psum_bw-1:0] c;	// Bias
output signed [psum_bw-1:0] out;

wire signed [bw:0] signed_a[3:0];
wire signed [2*bw-1:0] product[3:0];
wire signed [psum_bw-1:0] psum_q;

assign signed_a[0] = a0;
assign signed_a[1] = a1;
assign signed_a[2] = a2;
assign signed_a[3] = a3;

assign product[0] = signed_a[0] * b0;
assign product[1] = signed_a[1] * b1;
assign product[2] = signed_a[2] * b2;
assign product[3] = signed_a[3] * b3;

assign psum_q = product[0] + product[1] + product[2] + product[3] + c;
assign out = psum_q;

endmodule
