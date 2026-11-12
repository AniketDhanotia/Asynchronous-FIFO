module sync_w2r (wptr,rclk,wrst_n , wq2_wptr);
parameter addr_width = 4;
input [addr_width-1:0] wptr;
input rclk;
input wrst_n;
output [addr_width-1:0] wq2_wptr;

reg [addr_width-1:0] wq1_wptr;
always @(posedge rclk or negedge wrst_n) begin
    if(!wrst_n) begin
        wq1_wptr <= 0;
        wq2_wptr <=0;
    end
     else begin
        wq1_wptr <= wptr;
        wq2_wptr <=wq1_wptr;
    end
end
endmodule