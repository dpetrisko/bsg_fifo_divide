
set basejump_stl_dir       $::env(BASEJUMP_STL_DIR)
set bsg_designs_target_dir $::env(BSG_DESIGNS_TARGET_DIR)

# list of files to replace
set HARD_SWAP_FILELIST [join "
  $bsg_designs_target_dir/v/hard/free45/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v
  $bsg_designs_target_dir/v/hard/free45/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v
"]

set NETLIST_SOURCE_FILES [join "
"]

set NEW_SVERILOG_SOURCE_FILES [join "
"]

