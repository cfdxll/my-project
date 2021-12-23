#-----------------------------------------------------------
#                  Constraints                             -
#-----------------------------------------------------------

# --- Define and constrain system clock
create_clock -period 3.332 -name clk300 [get_ports clk300p]
set_propagated_clock [get_clocks clk300]

# --- False paths
set_false_path -to [get_ports led*]
set_false_path -from [get_ports reset]


#-----------------------------------------------------------
#                  Pin and IO Property                     -
#-----------------------------------------------------------

# --- Clocks -----------------------------------------------
set_property ODT RTT_48 [get_ports clk300n]
set_property IOSTANDARD DIFF_SSTL12_DCI [get_ports clk300n]
set_property PACKAGE_PIN AK16 [get_ports clk300n]
set_property PACKAGE_PIN AK17 [get_ports clk300p]
set_property IOSTANDARD DIFF_SSTL12_DCI [get_ports clk300p]
set_property ODT RTT_48 [get_ports clk300p]

# --- Reset ------------------------------------------------
set_property PACKAGE_PIN AN8 [get_ports reset]
set_property IOSTANDARD LVCMOS18 [get_ports reset]

# --- LEDs -------------------------------------------------
set_property PACKAGE_PIN AP8 [get_ports {led[0]}]
set_property PACKAGE_PIN H23 [get_ports {led[1]}]
set_property PACKAGE_PIN P20 [get_ports {led[2]}]
set_property PACKAGE_PIN P21 [get_ports {led[3]}]
set_property PACKAGE_PIN N22 [get_ports {led[4]}]
set_property PACKAGE_PIN M22 [get_ports {led[5]}]
set_property PACKAGE_PIN R23 [get_ports {led[6]}]
set_property PACKAGE_PIN P23 [get_ports {led[7]}]

set_property IOSTANDARD LVCMOS18 [get_ports led*]

#--------------------------------------
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 40 [current_design]
#--------------------------------------
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]
#--------------------------------------
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

#-------------------------------------
create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list sys_clk_bufg]]
set_property PROBE_TYPE DATA [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {LED_o[0]} {LED_o[1]} {LED_o[2]} {LED_o[3]} {LED_o[4]} {LED_o[5]} {LED_o[6]} {LED_o[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list rst_gc_n]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets sys_clk_bufg]