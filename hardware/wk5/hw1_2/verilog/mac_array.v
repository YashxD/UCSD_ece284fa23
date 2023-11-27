// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 
module mac_array (clk, reset, out_s, in_w, in_n, inst_w, valid);

    parameter bw = 4;
    parameter psum_bw = 16;
    parameter col = 8;
    parameter row = 8;

    input  clk, reset;
    output [psum_bw*col-1:0] out_s;
    input  [row*bw-1:0] in_w; // inst[1]:execute, inst[0]: kernel loading
    input  [1:0] inst_w;
    input  [psum_bw*col-1:0] in_n;
    output [col-1:0] valid;

    wire [psum_bw*col*(row+1)-1:0] temp_psum;
    wire [col*(row+1)-1:0] temp_valid;
    reg  [row*bw-1:0] temp_in_w;
    reg  [row*2-1:0] temp_inst;

    assign valid = temp_valid[col*(row+1)-1:col*row];
    assign out_s = temp_psum[psum_bw*col*(row+1)-1:psum_bw*col*row];

    genvar i;
    for (i=1; i < row+1 ; i=i+1) begin : row_num
        mac_row #(.bw(bw), .psum_bw(psum_bw)) mac_row_instance (
         .clk(clk),
         .out_s(temp_psum[psum_bw*col*(i+1)-1:psum_bw*col*i]),
         .in_w(in_w[bw*i-1:bw*(i-1)]),
         .in_n(temp_psum[psum_bw*col*i-1:psum_bw*col*(i-1)]),
         .valid(temp_valid[col*i-1:col*(i-1)]),
         .inst_w(temp_inst[i*2-1:(i-1)*2]),
         .reset()
        );
    end

    always @ (posedge clk) begin
        temp_inst[1:0] <= inst_w;
        temp_inst[3:2] <= temp_inst[1:0];
        temp_inst[5:4] <= temp_inst[3:2];
        temp_inst[7:6] <= temp_inst[5:4];
        temp_inst[9:8] <= temp_inst[7:6];
        temp_inst[11:10] <= temp_inst[9:8];
        temp_inst[13:12] <= temp_inst[11:10];
        temp_inst[15:14] <= temp_inst[13:12];
 
    end
endmodule
