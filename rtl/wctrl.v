module wctrl #(

    parameter addr_width = 4
)
( input wire wclk,
  input wire wrst_n,
  input wire [addr_width -1:0]raddr_gray_sync);
( output reg full,
  output reg [addr_width-2:0]waddr,
  output reg [addr_width-1:0]waddr_gray,

  );
  reg [addr_width-1:0]wbin;
  wire [addr_width-1:0]wbin_next;
  wire [addr_width-1:0]wgray_next;
  wire    wfull_val;
  assign waddr = wbin[addr_width-2:0];
  assign wbin_next=wbin + (~full);
  assign wgray_next=(wbin_next>>1)^wbin_next;
  always @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n)
    begin
        wbin<={addr_width{1'b0}};
        waddr_gray<={addr_width{1'b0}};
    end 
    else 
    begin
    wbin <=wbin_next;
    waddr_gray <=wgray_next;

    end
  end
  assign wfull_val=(wgray_next == {~raddr_gray_sync[addr_width-1:addr_width-2], raddr_gray_sync[addr_width-3:0]});
  always @(posedge wclk or negedge wrst_n ) begin
    if(!wrst_n)
    full<=1'b0;
    else
    full<=wfull_val;
    
  end
    
endmodule