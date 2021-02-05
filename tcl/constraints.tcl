  ########################################
  ##
  ## Clock Setup
  ##
  
  set clk_name            "clk"         ;# main clock
  
  set clk_period_ns       2
  set clk_uncertainty_per 0.0030
  set clk_uncertainty_ns  [expr min([expr ${clk_period_ns}*(${clk_uncertainty_per}/100.0)], 0.02)]
  #set clk_uncertainty_ns 0.0200
  
  set core_clk_name           ${clk_name}
  set core_clk_period_ns      ${clk_period_ns}
  set core_clk_uncertainty_ns ${clk_uncertainty_ns}
  
  set input_delay_per  20
  set output_delay_per 20
  
  set core_input_delay_ns  [expr ${core_clk_period_ns}*(${input_delay_per}/100.0)]
  set core_output_delay_ns [expr ${core_clk_period_ns}*(${output_delay_per}/100.0)]
  
  set driving_lib_cell "INV_X2"
  set load_lib_pin     "INV_X8/A"
  
  # Reg2Reg
  create_clock -period ${core_clk_period_ns} -name ${core_clk_name} [get_ports "clk_i"]
  set_clock_uncertainty ${core_clk_uncertainty_ns} [get_clocks ${core_clk_name}]
  
  # In2Reg
  set core_input_pins [filter_collection [all_inputs] "name!~*clk*"]
  set_driving_cell -no_design_rule -lib_cell ${driving_lib_cell} [remove_from_collection [all_inputs] [get_ports *clk*]]
  set_input_delay ${core_input_delay_ns} -clock ${core_clk_name} ${core_input_pins}
  
  # Reg2Out
  set core_output_pins [all_outputs] 
  set_load [load_of [get_lib_pin */${load_lib_pin}]] ${core_output_pins}
  set_output_delay ${core_output_delay_ns} -clock ${core_clk_name} ${core_output_pins}
  
  # Derate
  set cells_to_derate [list]
  append_to_collection cells_to_derate [get_cells -quiet -hier -filter "ref_name=~free45_*"]
  if { [sizeof $cells_to_derate] > 0 } {
    foreach_in_collection cell $cells_to_derate {
      set_timing_derate -cell_delay -early 0.97 $cell
      set_timing_derate -cell_delay -late  1.03 $cell
      set_timing_derate -cell_check -early 0.97 $cell
      set_timing_derate -cell_check -late  1.03 $cell
    }
  }
  #report_timing_derate

  # Ungrouping
  #=================
  #set_ungroup [get_cells swizzle]

  current_design bsg_chip

