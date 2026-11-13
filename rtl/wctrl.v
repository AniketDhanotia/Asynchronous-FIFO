module wctrl #(

    parameter  = 4
)
( input wire wclk,
  input wire wrst_n,
  input wire we,
  input wire [n-1:0]wq2_rptr);
( output reg ff,
  output reg [n-2:0]waddr,
  output reg [n-1:0]wptr,

  );
  reg [n-1:0]wbin;
  wire [n-1:0]wbin_next;
  wire [n-1:0]wgray_next;
  wire    wfull_val;
  assign waddr = wbin[n-2:0];
  assign wbin_next=wbin + (we & ~ff);
  assign wgray_next=(wbin_next>>1)^wbin_next;
  always @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n)
    begin
        wbin<={n{1'b0}};
        wptr<={n{1'b0}};
    end 
    else 
    begin
    wbin <=wbin_next;
    wbin <=wgray_next;

    end
  end
  assign wfull_val=(wgray_next == {~wq2_rptr[n-1:n-2], wq2_rptr[n-3:0]});
  always @(posedge wclk or negedge wrst_n ) begin
    if(!wrst_n)
    ff<=1'b0;
    else
    ff<=wfull_val;
    
  end
    
endmodule