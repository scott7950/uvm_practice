`define TIMER_IDLE 0
`define TIMER_RUN  1
`define TIMER_INTR 2

module rtl(
    rst_n ,
    clk   ,
    addr  ,
    rw    ,
    din   ,
    intr  
);

input        rst_n ;
input        clk   ;
input  [7:0] addr  ;
input        rw    ;
input  [7:0] din   ;
output       intr  ;

wire       rst_n ;
wire       clk   ;
wire [7:0] addr  ;
wire       rw    ;
wire [7:0] din   ;
reg        intr  ;

reg [7:0] ctrl ;
reg [7:0] cnt  ;

reg [7:0] timer_cnt     ;
reg       timer_running ;
reg [1:0] status        ;

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0) begin
        ctrl <= 8'h0;
    end
    else begin
        if(addr == 8'h0 && rw == 1'b1) begin
            if(timer_running == 1'b0) begin
                ctrl <= din;
            end
        end
        else begin
            ctrl <= 1'b0;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0) begin
        cnt <= 8'h0;
    end
    else begin
        if(addr == 8'h4 && rw == 1'b1) begin
            cnt <= din;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0) begin
        timer_running <= 1'b0;
        timer_cnt     <= 8'h0;
        intr          <= 1'b0;
        status        <= `TIMER_IDLE;
    end
    else begin
        case (status)
            `TIMER_IDLE: begin
                intr <= 1'b0;

                if(ctrl[0] == 1'b1 && cnt != 8'h0) begin
                    timer_cnt <= cnt;
                    timer_running <= 1'b1;
                    status <= `TIMER_RUN;
                end
                else begin
                    timer_running <= 1'b0;
                end
            end
            `TIMER_RUN: begin
                if(timer_cnt != 0) begin
                    timer_cnt <= timer_cnt - 8'h1;
                end
                else begin
                    status <= `TIMER_INTR;
                end
            end
            `TIMER_INTR: begin
                intr <= 1'b1;
                status <= `TIMER_IDLE;
            end
            default: begin
                intr <= 1'b0;
                timer_running <= 1'b0;
                timer_cnt <= 8'h0;
            end
        endcase
    end
end

endmodule

