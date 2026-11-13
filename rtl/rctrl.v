module rctrl #(

    parameter  = 4
)
( input wire rclk,
  input wire rrst_n,
  input wire re,
  input wire [n-1:0]rq2_wptr);
( output reg ff,
  output reg [n-2:0]raddr,
  output reg [n-1:0]rptr,

  );
  reg [n-1:0]rbin;
  wire [n-1:0]rbin_next;
  wire [n-1:0]rgray_next;
  wire    rfull_val;
  assign raddr = rbin[n-2:0];
  assign rbin_next=rbin + (re & ~ff);
  assign rgray_next=(rbin_next>>1)^rbin_next;
  always @(posedge rclk or negedge rrst_n) begin
    if (!rrst_n)
    begin
        rbin<={n{1'b0}};
        rptr<={n{1'b0}};
    end 
    else 
    begin
    rbin <=rbin_next;
    rbin <=rgray_next;

    end
  end
  assign rfull_val=(rgray_next == {~rq2_wptr[n-1:n-2], rq2_wptr[n-3:0]});
  always @(posedge rclk or negedge rrst_n ) begin
    if(!rrst_n)
    ff<=1'b0;
    else
    ff<=rfull_val;
    
  end
    
endmodule