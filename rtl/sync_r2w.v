module sync_r2w (rptr,wclk,rrst_n , wq2_rptr);
parameter addr_width = 4;
input [addr_width-1:0] rptr;
input wclk;
input rrst_n;
output [addr_width-1:0] wq2_rptr;

reg [addr_width-1:0] wq1_rptr;
always @(posedge wclk or negedge rrst_n) begin
    if(!rrst_n) begin
        wq1_rptr <= 0;
        wq2_rptr <=0;
    end
     else begin
        wq1_rptr <= rptr;
        wq2_rptr <=wq1_rptr;
    end
end
endmodule