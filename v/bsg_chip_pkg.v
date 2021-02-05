`ifndef BSG_CHIP_PKG_V
`define BSG_CHIP_PKG_V

package bsg_chip_pkg;

  `include "bsg_defines.v"

  //////////////////////////////////////////////////
  //
  // BSG PARAMETERS
  //
  localparam addr_width_gp = 32;
  localparam data_width_gp = 64;
  localparam block_size_in_words_gp = 8;
  localparam sets_gp = 128;
  localparam ways_gp = 8;

endpackage // bsg_chip_pkg

`endif // BSG_CHIP_PKG_V

