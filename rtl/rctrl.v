module rctrl #(

    parameter addr_width = 4
)
( input wire rclk,
  input wire rrst_n,
  input wire [addr_width-1:0]rq2_wptr);
( output reg empty,
  output reg [addr_width-2:0]raddr,
  output reg [addr_width-1:0]raddr_gray,

  );
  reg [addr_width-1:0]rbin;
  wire [addr_width-1:0]rbin_next;
  wire [addr_width-1:0]rgray_next;
  wire    rfull_val;
  assign raddr = rbin[addr_width-2:0];
  assign rbin_next=rbin + (~empty);
  assign rgray_next=(rbin_next>>1)^rbin_next;
  always @(posedge rclk or negedge rrst_n) begin
    if (!rrst_n)
    begin
        rbin<={addr_width{1'b0}};
        raddr_gray<={addr_width{1'b0}};
    end 
    else 
    begin
    rbin <=rbin_next;
    raddr_gray <=rgray_next;

    end
  end
  assign rfull_val=(rgray_next == {~rq2_wptr[addr_width-1:addr_width-2], rq2_wptr[addr_width-3:0]});
  always @(posedge rclk or negedge rrst_n ) begin
    if(!rrst_n)
    empty<=1'b0;
    else
    empty<=rfull_val;
    
  end
    
endmodule