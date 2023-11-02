// Created by prof. Mingu Kang @VVIP Lab in UCSD ECE department
// Please do not spread this code without permission 


module mac_tb;

parameter bw = 4;
parameter psum_bw = 16;

reg clk = 0;

reg  [bw-1:0] a[3:0];
reg  [bw-1:0] b[3:0];
reg  [psum_bw-1:0] c;
wire [psum_bw-1:0] out;
reg  [psum_bw-1:0] expected_out = 0;

integer w_file ; // file handler
integer w_scan_file ; // file handler

integer x_file ; // file handler
integer x_scan_file ; // file handler

integer x_dec[3:0];
integer w_dec[3:0];
integer i; 
integer u; 

function [3:0] w_bin ;
    input integer  weight ;
    begin
        if (weight>-1)
            w_bin[3] = 0;
        else begin
            w_bin[3] = 1;
            weight = weight + 8;
        end

        if (weight>3) begin
            w_bin[2] = 1;
            weight = weight - 4;
        end
        else 
            w_bin[2] = 0;

        if (weight>1) begin
            w_bin[1] = 1;
            weight = weight - 2;
        end
        else 
            w_bin[1] = 0;

        if (weight>0) 
            w_bin[0] = 1;
        else 
            w_bin[0] = 0;
    end
endfunction



function [3:0] x_bin ;
    input integer act;
    begin
        if (act > -1) begin
            if (act > 7) begin
                x_bin[3] = 1;
                act = act - 8;
            end else
                x_bin[3] = 0;
            
            if (act > 3) begin
                x_bin[2] = 1;
                act = act - 4;
            end else
                x_bin[2] = 0;
            
            if (act > 1) begin
                x_bin[1] = 1;
                act = act - 2;
            end else
                x_bin[1] = 0;

            if (act > 0)
                x_bin[0] = 1;
            else
                x_bin[0] = 0;
            //x_bin = act;
        end        
        else begin
            // Undefined case.
        end
    end
endfunction


// Below function is for verification
function [psum_bw-1:0] mac_predicted;

input unsigned [bw-1:0] act0;
input unsigned [bw-1:0] act1;
input unsigned [bw-1:0] act2;
input unsigned [bw-1:0] act3;
input signed [bw-1:0] weight0;
input signed [bw-1:0] weight1;
input signed [bw-1:0] weight2;
input signed [bw-1:0] weight3;
input signed [psum_bw-1:0] bias;

begin
    mac_predicted = ($signed({1'b0,act0}) * weight0) + 
                    ($signed({1'b0,act1}) * weight1) +
                    ($signed({1'b0,act2}) * weight2) +
                    ($signed({1'b0,act3}) * weight3) +
                    bias;
end

endfunction



mac_wrapper_4x #(.bw(bw), .psum_bw(psum_bw)) mac_wrapper_instance (
	.clk(clk), 
    .a0(a[0]),
    .a1(a[1]),
    .a2(a[2]),
    .a3(a[3]), 
    .b0(b[0]),
    .b1(b[1]),
    .b2(b[2]),
    .b3(b[3]),
    .c(c),
	.out(out)
); 
 

initial begin 

  w_file = $fopen("b_data.txt", "r");  //weight data
  x_file = $fopen("a_data.txt", "r");  //activation

  $dumpfile("mac_tb.vcd");
  $dumpvars(0,mac_tb);
 
  #1 clk = 1'b0;  
  #1 clk = 1'b1;  
  #1 clk = 1'b0;

  $display("-------------------- Computation start --------------------");
  

  for (i=0; i<5; i=i+1) begin  // Data lenght is 10 in the data files

     #1 clk = 1'b1;
     #1 clk = 1'b0;
    
    for (u=0; u<4; u=u+1) begin
        w_scan_file = $fscanf(w_file, "%d\n", w_dec[u]);
        x_scan_file = $fscanf(x_file, "%d\n", x_dec[u]);

        a[u] = x_bin(x_dec[u]); // unsigned number
        b[u] = w_bin(w_dec[u]); // signed number
    end

     c = expected_out;

     expected_out = mac_predicted(a[0], a[1], a[2], a[3],
                                  b[0], b[1], b[2], b[3],c);

  end



  #1 clk = 1'b1;
  #1 clk = 1'b0;

  $display("-------------------- Computation completed --------------------");

  #10 $finish;


end

endmodule




