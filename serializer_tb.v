`timescale 1ns/1ps
module serializer_tb #(parameter width_tb=8);
reg rst_tb;
reg clk_tb;
reg [width_tb-1:0] p_input_tb;
reg load_tb;
reg serial_en_tb;
wire serial_out_tb;
wire serial_done_tb;
integer i;

serializer #(.width(width_tb))DUT (
.clk(clk_tb),
.rst(rst_tb),
.p_input(p_input_tb),
.load(load_tb),
.serial_en(serial_en_tb),
.serial_out(serial_out_tb),
.serial_done(serial_done_tb)
);

always #5 clk_tb = ~clk_tb;

initial begin
clk_tb= 0;
rst_tb= 0;
load_tb= 0;
serial_en_tb= 0;
p_input_tb= 8'b00111001;

#20;
rst_tb= 1;

@(posedge clk_tb);
load_tb= 1;
    
@(posedge clk_tb);
load_tb= 0;
serial_en_tb= 1;

for (i = 0; i < width_tb; i = i + 1) 
begin
@(posedge clk_tb);
#1;
if (serial_out_tb === p_input_tb[i])
$display("DATA_BIT %0d PASS serial_out= %b", i ,serial_out_tb);
else
$display("DATA_BIT %0d FAIL serial_out= %b", i ,serial_out_tb);
end
#1;
if (serial_done_tb === 1)
$display("SERIAL DONE PASS = %b", serial_done_tb);
else
$display("SERIAL DONE FAIL = %b", serial_done_tb);

#20;
$display("FINISHED");

$finish;
end
endmodule
