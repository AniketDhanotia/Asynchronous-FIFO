module dual_port_ram #(
    addr_widht= 4;
    data_width=8;   
) (
    input wire wclk, 
    input wire winc,
    input wire [addr_widht-1:0]waddr,
    input wire [data_width-1:0]wdata,

    input wire rclk,
    input wire rinc,
    input wire [addr_widht-1:0]raddr,
    output reg [data_width-1:0]rdata;

);
    
    localparam depth = 1<<addr_widht;   
    reg [data_width-1:0]mem[0:depth-1];
    
endmodule