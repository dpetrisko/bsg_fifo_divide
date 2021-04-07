
module bsg_chip
 import bsg_chip_pkg::*;
 import bsg_cache_pkg::*;
 #(localparam cache_pkt_width_lp = `bsg_cache_pkt_width(addr_width_gp, data_width_gp)
   , localparam cache_dma_pkt_width_lp = `bsg_cache_dma_pkt_width(addr_width_gp)
   )
  (input                                               clk_i
   , input                                             reset_i

   , input [cache_pkt_width_lp-1:0]                    data_i
   , input                                             v_i
   , output logic                                      ready_o

   , output logic [data_width_gp-1:0]                  data_o
   , output logic                                      v_o
   , input                                             yumi_i

   , output logic [cache_dma_pkt_width_lp-1:0]         dma_pkt_o
   , output logic                                      dma_pkt_v_o
   , input                                             dma_pkt_yumi_i

   , input [data_width_gp-1:0]                         dma_data_i
   , input                                             dma_data_v_i
   , output logic                                      dma_data_ready_o

   , output logic [data_width_gp-1:0]                  dma_data_o
   , output logic                                      dma_data_v_o
   , input                                             dma_data_yumi_i
   );

  `declare_bsg_cache_pkt_s(addr_width_gp, data_width_gp);
  bsg_cache_pkt_s cache_pkt_li;
  logic cache_pkt_v_li, cache_pkt_ready_lo;
  bsg_two_fifo
   #(.width_p(cache_pkt_width_lp))
   in_fifo
    (.clk_i(clk_i)
     ,.reset_i(reset_i)

     ,.data_i(data_i)
     ,.v_i(v_i)
     ,.ready_o(ready_o)

     ,.data_o(cache_pkt_li)
     ,.v_o(cache_pkt_v_li)
     ,.yumi_i(cache_pkt_ready_lo & cache_pkt_v_li)
     );

  logic slow_clk_li;
  bsg_strobe
   #(.width_p(2))
   strobe
    (.clk_i(clk_i)
     ,.reset_r_i(reset_i)
     ,.init_val_r_i(2'b1)
     ,.strobe_r_o(slow_clk_li)
     );
  wire slow_reset_li = reset_i;

  logic slow_v_li, slow_ready_lo;
  bsg_fifo_periodic
   #(.a_period_p(1), .b_period_p(2))
   packet_divide
    (.a_clk_i(clk_i)
     ,.a_reset_i(reset_i)
     ,.a_v_i(cache_pkt_v_li)
     ,.a_ready_and_o(cache_pkt_ready_lo)

     ,.b_clk_i(slow_clk_li)
     ,.b_reset_i(slow_reset_li)
     ,.b_v_o(slow_v_li)
     ,.b_ready_and_i(slow_ready_lo)
     );

  logic [data_width_gp-1:0] cache_data_lo;
  logic cache_data_v_lo, cache_data_ready_li;
  bsg_cache
   #(.addr_width_p(addr_width_gp)
     ,.data_width_p(data_width_gp)
     ,.block_size_in_words_p(block_size_in_words_gp)
     ,.sets_p(sets_gp)
     ,.ways_p(ways_gp)
     )
   cache
    (.clk_i(slow_clk_li)
     ,.reset_i(slow_reset_li)

     ,.cache_pkt_i(cache_pkt_li)
     ,.v_i(slow_v_li)
     ,.ready_o(slow_ready_lo)

     ,.data_o(cache_data_lo)
     ,.v_o(cache_data_v_lo)
     ,.yumi_i(cache_data_ready_li & cache_data_v_lo)

     ,.dma_pkt_o(dma_pkt_o)
     ,.dma_pkt_v_o(dma_pkt_v_o)
     ,.dma_pkt_yumi_i(dma_pkt_yumi_i)

     ,.dma_data_i(dma_data_i)
     ,.dma_data_v_i(dma_data_v_i)
     ,.dma_data_ready_o(dma_data_ready_o)

     ,.dma_data_o(dma_data_o)
     ,.dma_data_v_o(dma_data_v_o)
     ,.dma_data_yumi_i(dma_data_yumi_i)

     ,.v_we_o()
     );

  logic fast_data_v_lo, fast_data_ready_li;
  bsg_fifo_periodic
   #(.a_period_p(2), .b_period_p(1))
   data_divide
    (.a_clk_i(slow_clk_li)
     ,.a_reset_i(slow_reset_li)
     ,.a_v_i(cache_data_v_lo)
     ,.a_ready_and_o(cache_data_ready_li)

     ,.b_clk_i(clk_i)
     ,.b_reset_i(reset_i)
     ,.b_v_o(fast_data_v_lo)
     ,.b_ready_and_i(fast_data_ready_li & fast_data_v_lo)
     );

  bsg_two_fifo
   #(.width_p(data_width_gp))
   out_fifo
    (.clk_i(clk_i)
     ,.reset_i(reset_i)

     ,.data_i(cache_data_lo)
     ,.v_i(fast_data_v_lo)
     ,.ready_o(fast_data_ready_li)

     ,.data_o(data_o)
     ,.v_o(v_o)
     ,.yumi_i(yumi_i)
     );

endmodule

