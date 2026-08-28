module serializer #( parameter width=8 )
(
input wire rst,
input wire clk,
input wire [width-1:0] p_input,
input wire load,
input wire serial_en ,
output reg serial_out,
output reg serial_done
);
reg [$clog2(width)-1:0] counter;
reg [width-1:0] data_reg;

always@(posedge clk or negedge rst) 
begin
if(!rst)
begin
serial_out<=0;
serial_done<=0;
counter<=0;
data_reg<=0;
end 
else if(load)
begin
data_reg<=p_input;
counter<=0;
serial_done<=0;
end
else if(serial_en)
begin
serial_out<=data_reg[counter];
if(counter==width-1)
begin 
serial_done<=1;
counter<=0;
end 
else 
begin 
serial_done<=0;
counter<=counter+1;
end
end
end
endmodule
