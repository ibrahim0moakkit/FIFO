module fifo(input clk,
            input reset,
            input write_en,
            input read_en,
            input [7:0] data_in,
            

            output full_flag,
            output empty_flag,
            output reg [7:0] data_out

);




parameter DEPTH = 8; //we can store 8 bits in this fifo

reg [7:0] mem [0:7];

reg [2:0] write_pointer;
reg [2:0] read_pointer;

reg [3:0] counter;

assign full_flag=(counter==DEPTH)?1:0;
assign empty_flag=(counter==0)?1:0;

//   handle write process

always @(posedge clk or negedge reset) begin
  if (!reset) begin
    write_pointer<=3'd0;
  end
  else begin if(write_en==1)
  begin
    mem[write_pointer]<=data_in;
    write_pointer<=write_pointer+1;
    end
  end
  
end

// handle read process

always @(posedge clk or negedge reset) begin
  if (!reset) begin
    read_pointer<=3'd0;
  end
  else begin if(read_en==1)
  begin
   data_out=mem[read_pointer];
   read_pointer<=read_pointer+1;
    end
  end
  
end


// handle the count process

always @(posedge clk or negedge reset)
begin
 if(!reset) begin
  counter<=4'd0;
 end
 else begin
   case({write_en,read_en})
2'b10: counter<=counter+1;
2'b01: counter<=counter-1;
2'b11: counter<=counter;
2'b00: counter<=counter;
default: counter<=counter;
   endcase

 end


end


endmodule
