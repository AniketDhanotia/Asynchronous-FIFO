module sync_r2w (raddr_gray,wclk,rrst_n , raddr_gray_sync);
parameter addr_width = 4;
input [addr_width-1:0] raddr_gray;
input wclk;
input rrst_n;
output [addr_width-1:0] raddr_gray_sync;

reg [addr_width-1:0] wq1_rptr;
always @(posedge wclk or negedge rrst_n) begin
    if(!rrst_n) begin
        wq1_rptr <= 0;
        raddr_gray_sync <=0;
    end
     else begin
        wq1_rptr <= raddr_gray;
        raddr_gray_sync <=wq1_rptr;
    end
end
endmodule