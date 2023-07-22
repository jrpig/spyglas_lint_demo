module test (
    input clk,
    input rst_n,

    input [1:0] din_a,
    input [1:0] din_b,

    output dout_c,
    output dummy_out
);

    wire dummy_d;

    assign dout_c = din_a + din_b;  // width mismatched
    assign dout_c = dummy_d;        // multi driver and comb loop
    assign dummy_d = dout_c;
    
endmodule
