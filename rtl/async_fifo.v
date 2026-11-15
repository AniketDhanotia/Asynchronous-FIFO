module async_fifo (
    wclk, wrst_n, winc,waddr, wdata, wfull, rclk, raddr, rrst_n, rinc, rdata, rempty
);

    
    dual_port_ram #(.addr_width(addr_width), .data_width(data_width)) ram (
        .wclk(wclk),
        .winc(winc),
        .waddr(waddr),
        .wdata(wdata),
        .rclk(rclk),
        .rinc(rinc),
        .raddr(raddr),
        .rdata(rdata)
    );

    rctrl #(.addr_width(addr_width)) rctrl_inst (
        .rclk(rclk),
        .rrst_n(rrst_n),
        .rq2_wptr(waddr_gray_sync),
        .empty(rempty),
        .raddr(raddr),
        .raddr_gray(raddr_gray)
    );

    wctrl #(.addr_width(addr_width)) wctrl_inst (
        .wclk(wclk),
        .wrst_n(wrst_n),
        .raddr_gray_sync(raddr_gray_sync),
        .full(wfull),
        .waddr(waddr),
        .waddr_gray(waddr_gray)
    );

    sync_w2r #(.addr_width(addr_width)) sync_w2r_inst (
        .waddr_gray(waddr_gray),
        .rclk(rclk),
        .wrst_n(wrst_n),
        .waddr_gray_sync(waddr_gray_sync)
    );

    sync_r2w #(.addr_width(addr_width)) sync_r2w_inst (
        .raddr_gray(raddr_gray),
        .wclk(wclk),
        .rrst_n(rrst_n),
        .raddr_gray_sync(raddr_gray_sync)
    );

endmodule