module sync_w2r (waddr_gray,rclk,wrst_n , waddr_gray_sync);
parameter addr_width = 4;
input [addr_width-1:0] waddr_gray;
input rclk;
input wrst_n;
output [addr_width-1:0] waddr_gray_sync;

reg [addr_width-1:0] wq1_wptr;
always @(posedge rclk or negedge wrst_n) begin
    if(!wrst_n) begin
        wq1_wptr <= 0;
        waddr_gray_sync <=0;
    end
     else begin
        wq1_wptr <= waddr_gray;
        waddr_gray_sync <=wq1_wptr;
    end
end
endmodule