module mux(
input wire start_bit,
input wire stop_bit,
input wire serial_out,
input wire parity_out,
input wire [1:0] mux_sel,
output reg TX_out 
);
always@(*)
begin
case(mux_sel)
2'b00: TX_out<=start_bit;
2'b01: TX_out<=serial_out;
2'b10: TX_out<=parity_out;
2'b11: TX_out<=stop_bit;
endcase
end 
endmodule