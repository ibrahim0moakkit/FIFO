`timescale 1ns/1ps
`include "fifo.v"
module fifo_tb;

reg clk,reset,write_en,read_en;
reg [7:0] data_in;
wire full_flag,empty_flag;
wire [7:0] data_out;


fifo uut(
.clk(clk),
.reset(reset),
.write_en(write_en),
.read_en(read_en),
.data_in(data_in),
.full_flag(full_flag),
.empty_flag(empty_flag),
.data_out(data_out));


always begin
#5;
clk=~clk;


end


integer  i;
initial begin
   clk=0;
    $dumpfile("fifo_tb.vcd");
    $dumpvars(0,fifo_tb);


reset=1'b1;

write_en=1'b0;
read_en=1'b0;

data_in=8'b0;


#10;
reset=1'b0;

#10;
reset=1'b1;


//write data

write_en=1'b1;
read_en=1'b0;


for(i=0;i<8;i=i+1) begin
data_in=i;
#10;
end

//read data
write_en=1'b0;
read_en=1'b1;

#80;


//write data

write_en=1'b1;
read_en=1'b0;

for(i=0;i<8;i=i+1) begin
data_in=i;
#10;
end
  
#10;
#10;
#10;

#5000000 $finish;

end

endmodule

