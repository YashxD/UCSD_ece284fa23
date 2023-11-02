// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac (out, a, b, c);

parameter bw = 4;
parameter psum_bw = 16;

input unsigned [bw-1:0] a;	    // X_in
input signed [bw-1:0] b;	    // Weight
input signed [psum_bw-1:0] c;	// Bias
output signed [psum_bw-1:0] out;

wire signed [2*bw-1:0] product;
wire signed [bw:0] signed_a;
reg  signed [psum_bw-1:0] psum_q;

//assign out = psum_q;
//assign psum_q = a * b + c;
//assign product = 
//assign out = $signed({1'b0,a}) * b + c;
assign signed_a = a;
assign out = (signed_a * b) + c;

endmodule
