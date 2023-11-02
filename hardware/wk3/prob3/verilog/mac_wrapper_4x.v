// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac_wrapper_4x (clk, out, a0, a1, a2, a3, b0, b1, b2, b3, c);

parameter bw = 4;
parameter psum_bw = 16;

output [psum_bw-1:0] out;
input [bw-1:0] a0;	    // X_in_0
input [bw-1:0] a1;	    // X_in_1
input [bw-1:0] a2;	    // X_in_2
input [bw-1:0] a3;	    // X_in_3
input [bw-1:0] b0;	    // Weight_0
input [bw-1:0] b1;	    // Weight_1
input [bw-1:0] b2;	    // Weight_2
input [bw-1:0] b3;	    // Weight_3
input [psum_bw-1:0] c;
input clk;

reg    [bw-1:0] a_q[3:0];
reg    [bw-1:0] b_q[3:0];
reg    [psum_bw-1:0] c_q;

mac_4x #(.bw(bw), .psum_bw(psum_bw)) mac_instance_0 (
    .a0(a_q[0]),
    .a1(a_q[1]),
    .a2(a_q[2]),
    .a3(a_q[3]),  
    .b0(b_q[0]),
    .b1(b_q[1]),
    .b2(b_q[2]),
    .b3(b_q[3]),
    .c(c_q),
    .out(out)
); 

always @ (posedge clk) begin
        a_q[0]  <= a0;
        a_q[1]  <= a1;
        a_q[2]  <= a2;
        a_q[3]  <= a3;
        b_q[0]  <= b0;
        b_q[1]  <= b1;
        b_q[2]  <= b2;
        b_q[3]  <= b3;
        c_q  <= c;
end

endmodule
