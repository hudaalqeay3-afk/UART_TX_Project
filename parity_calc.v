module parity_calc #( parameter width=8 )(
input wire [width-1:0] p_input,
input wire parity_bit,
output reg parity_out
);
always @(*)
begin
if(parity_bit==0)
begin
if(^p_input == 0)
parity_out<=0;
else
parity_out<=1;
end else if(^p_input == 0)   
parity_out<=1;
else
parity_out<=0;
end
endmodule

