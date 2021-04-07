#------------------------------------------------------------
# Do NOT arbitrarily change the order of files. Some module
# and macro definitions may be needed by the subsequent files
#------------------------------------------------------------

set basejump_stl_dir       $::env(BASEJUMP_STL_DIR)
set bsg_designs_target_dir $::env(BSG_DESIGNS_TARGET_DIR)

set bsg_packaging_dir $::env(BSG_PACKAGING_DIR)
set bsg_package       $::env(BSG_PACKAGE)
set bsg_pinout        $::env(BSG_PINOUT)
set bsg_padmapping    $::env(BSG_PADMAPPING)

set SVERILOG_SOURCE_FILES [join "
    $bsg_designs_target_dir/v/bsg_chip_pkg.v
    $basejump_stl_dir/bsg_cache/bsg_cache_pkg.v

    $basejump_stl_dir/bsg_cache/bsg_cache.v
    $basejump_stl_dir/bsg_cache/bsg_cache_decode.v
    $basejump_stl_dir/bsg_cache/bsg_cache_dma.v
    $basejump_stl_dir/bsg_cache/bsg_cache_miss.v
    $basejump_stl_dir/bsg_cache/bsg_cache_sbuf.v
    $basejump_stl_dir/bsg_cache/bsg_cache_sbuf_queue.v

    $basejump_stl_dir/bsg_dataflow/bsg_fifo_1r1w_small.v
    $basejump_stl_dir/bsg_dataflow/bsg_fifo_1r1w_small_unhardened.v
    $basejump_stl_dir/bsg_dataflow/bsg_fifo_tracker.v
    $basejump_stl_dir/bsg_dataflow/bsg_fifo_periodic.v
    $basejump_stl_dir/bsg_dataflow/bsg_two_fifo.v

    $basejump_stl_dir/bsg_mem/bsg_mem_1r1w.v
    $basejump_stl_dir/bsg_mem/bsg_mem_1r1w_synth.v
    $basejump_stl_dir/bsg_mem/bsg_mem_1rw_sync.v
    $basejump_stl_dir/bsg_mem/bsg_mem_1rw_sync_synth.v
    $basejump_stl_dir/bsg_mem/bsg_mem_1rw_sync_mask_write_bit.v
    $basejump_stl_dir/bsg_mem/bsg_mem_1rw_sync_mask_write_bit_synth.v
    $basejump_stl_dir/bsg_mem/bsg_mem_1rw_sync_mask_write_byte.v
    $basejump_stl_dir/bsg_mem/bsg_mem_1rw_sync_mask_write_byte_banked.v
    $basejump_stl_dir/bsg_mem/bsg_mem_1rw_sync_mask_write_byte_synth.v

    $basejump_stl_dir/bsg_misc/bsg_buf.v
    $basejump_stl_dir/bsg_misc/bsg_counter_clear_up.v
    $basejump_stl_dir/bsg_misc/bsg_counter_clear_up_one_hot.v
    $basejump_stl_dir/bsg_misc/bsg_circular_ptr.v
    $basejump_stl_dir/bsg_misc/bsg_counter_clock_downsample.v
    $basejump_stl_dir/bsg_misc/bsg_decode.v
    $basejump_stl_dir/bsg_misc/bsg_decode_with_v.v
    $basejump_stl_dir/bsg_misc/bsg_dff.v
    $basejump_stl_dir/bsg_misc/bsg_dff_en.v
    $basejump_stl_dir/bsg_misc/bsg_expand_bitmask.v
    $basejump_stl_dir/bsg_misc/bsg_encode_one_hot.v
    $basejump_stl_dir/bsg_misc/bsg_mux.v
    $basejump_stl_dir/bsg_misc/bsg_mux_bitwise.v
    $basejump_stl_dir/bsg_misc/bsg_mux_segmented.v
    $basejump_stl_dir/bsg_misc/bsg_muxi2_gatestack.v
    $basejump_stl_dir/bsg_misc/bsg_nand.v
    $basejump_stl_dir/bsg_misc/bsg_nor3.v
    $basejump_stl_dir/bsg_misc/bsg_lru_pseudo_tree_backup.v
    $basejump_stl_dir/bsg_misc/bsg_lru_pseudo_tree_decode.v
    $basejump_stl_dir/bsg_misc/bsg_lru_pseudo_tree_encode.v
    $basejump_stl_dir/bsg_misc/bsg_priority_encode.v
    $basejump_stl_dir/bsg_misc/bsg_priority_encode_one_hot_out.v
    $basejump_stl_dir/bsg_misc/bsg_reduce.v
    $basejump_stl_dir/bsg_misc/bsg_scan.v
    $basejump_stl_dir/bsg_misc/bsg_strobe.v
    $basejump_stl_dir/bsg_misc/bsg_xor.v
    $basejump_stl_dir/bsg_misc/bsg_xnor.v

    $bsg_designs_target_dir/v/bsg_chip.v
"]

