module fsm (
input wire rst,
input wire clk,
input wire serial_done,
input wire valid_input,
input wire parity_en,
output reg load,
output reg busy,
output reg [1:0] mux_sel,
output reg serial_en
);
localparam     idle =3'b000;
localparam    start =3'b001;
localparam ser_data =3'b010;
localparam   parity =3'b011;
localparam     stop =3'b100;
reg [2:0] current_state , next_state ;
always @(posedge clk or negedge rst)
begin
if (!rst) 
current_state<= idle;
else 
current_state<= next_state;
end
always @(*)
begin
case(current_state)

idle:
begin
busy = 0;
load = 0;
serial_en = 0;
mux_sel = 2'b11;
if(valid_input==1)
next_state=start;
else 
next_state=idle;
end
 
start:
begin
busy = 1;
load = 1;
serial_en = 0;
mux_sel = 2'b00;
next_state =ser_data;
end

ser_data:
begin
busy = 1;
load = 0;
serial_en = 1;
mux_sel = 2'b01;
if (serial_done == 1) 
begin
if (parity_en == 1)
next_state = parity;
else
next_state = stop;
end 
else
next_state = ser_data;                
end

parity:
begin 
busy = 1;
load = 0;
serial_en = 0;
mux_sel = 2'b10;
next_state = stop;
end 

stop:
begin 
busy = 1;
load = 0;
serial_en = 0;
mux_sel = 2'b11;
next_state = idle;
end 

default:
begin
busy = 0;
load = 0;
serial_en = 0;
mux_sel = 2'b11;
next_state = idle;
end 

endcase
end 
endmodule
