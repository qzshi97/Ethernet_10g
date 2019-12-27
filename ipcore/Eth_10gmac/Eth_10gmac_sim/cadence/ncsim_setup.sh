
# (C) 2001-2018 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 17.1 590 win32 2018.04.30.15:28:43

# ----------------------------------------
# ncsim - auto-generated simulation script

# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     Eth_10gmac
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level shell script that compiles Altera simulation libraries
# and the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "ncsim.sh", and modify text as directed.
# 
# You can also modify the simulation flow to suit your needs. Set the
# following variables to 1 to disable their corresponding processes:
# - SKIP_FILE_COPY: skip copying ROM/RAM initialization files
# - SKIP_DEV_COM: skip compiling the Quartus EDA simulation library
# - SKIP_COM: skip compiling Quartus-generated IP simulation files
# - SKIP_ELAB and SKIP_SIM: skip elaboration and simulation
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator. In this case, you must also copy the generated files
# # "cds.lib" and "hdl.var" - plus the directory "cds_libs" if generated - 
# # into the location from which you launch the simulator, or incorporate
# # into any existing library setup.
# #
# # Run Quartus-generated IP simulation script once to compile Quartus EDA
# # simulation libraries and Quartus-generated IP simulation files, and copy
# # any ROM/RAM initialization files to the simulation directory.
# # - If necessary, specify any compilation options:
# #   USER_DEFINED_COMPILE_OPTIONS
# #   USER_DEFINED_VHDL_COMPILE_OPTIONS applied to vhdl compiler
# #   USER_DEFINED_VERILOG_COMPILE_OPTIONS applied to verilog compiler
# #
# source <script generation output directory>/cadence/ncsim_setup.sh \
# SKIP_ELAB=1 \
# SKIP_SIM=1 \
# USER_DEFINED_COMPILE_OPTIONS=<compilation options for your design> \
# USER_DEFINED_VHDL_COMPILE_OPTIONS=<VHDL compilation options for your design> \
# USER_DEFINED_VERILOG_COMPILE_OPTIONS=<Verilog compilation options for your design> \
# QSYS_SIMDIR=<script generation output directory>
# #
# # Compile all design files and testbench files, including the top level.
# # (These are all the files required for simulation other than the files
# # compiled by the IP script)
# #
# ncvlog <compilation options> <design and testbench files>
# #
# # TOP_LEVEL_NAME is used in this script to set the top-level simulation or
# # testbench module/entity name.
# #
# # Run the IP script again to elaborate and simulate the top level:
# # - Specify TOP_LEVEL_NAME and USER_DEFINED_ELAB_OPTIONS.
# # - Override the default USER_DEFINED_SIM_OPTIONS. For example, to run
# #   until $finish(), set to an empty string: USER_DEFINED_SIM_OPTIONS="".
# #
# source <script generation output directory>/cadence/ncsim_setup.sh \
# SKIP_FILE_COPY=1 \
# SKIP_DEV_COM=1 \
# SKIP_COM=1 \
# TOP_LEVEL_NAME=<simulation top> \
# USER_DEFINED_ELAB_OPTIONS=<elaboration options for your design> \
# USER_DEFINED_SIM_OPTIONS=<simulation options for your design>
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If Eth_10gmac is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------
# ACDS 17.1 590 win32 2018.04.30.15:28:43
# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="Eth_10gmac"
QSYS_SIMDIR="./../"
QUARTUS_INSTALL_DIR="D:/intelfpga/17.1/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="-input \"@run 100; exit\""

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `ncsim -version` != *"ncsim(64)"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/error_adapter_0/
mkdir -p ./libraries/router/
mkdir -p ./libraries/rsp_mux/
mkdir -p ./libraries/rsp_demux/
mkdir -p ./libraries/cmd_mux/
mkdir -p ./libraries/cmd_demux/
mkdir -p ./libraries/router_001/
mkdir -p ./libraries/avalon_st_adapter/
mkdir -p ./libraries/crosser/
mkdir -p ./libraries/merlin_master_translator_avalon_universal_master_0_limiter/
mkdir -p ./libraries/tx_bridge_s0_agent_rsp_fifo/
mkdir -p ./libraries/tx_bridge_s0_agent/
mkdir -p ./libraries/merlin_master_translator_avalon_universal_master_0_agent/
mkdir -p ./libraries/tx_bridge_s0_translator/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/mm_interconnect_2/
mkdir -p ./libraries/mm_interconnect_1/
mkdir -p ./libraries/mm_interconnect_0/
mkdir -p ./libraries/rxtx_timing_adapter_pauselen_tx/
mkdir -p ./libraries/rxtx_timing_adapter_pauselen_rx/
mkdir -p ./libraries/rxtx_dc_fifo_link_fault_status/
mkdir -p ./libraries/txrx_timing_adapter_link_fault_status_export/
mkdir -p ./libraries/txrx_timing_adapter_link_fault_status_rx/
mkdir -p ./libraries/rx_st_error_adapter_stat/
mkdir -p ./libraries/rx_st_status_output_delay/
mkdir -p ./libraries/rx_eth_crc_pad_rem/
mkdir -p ./libraries/rx_timing_adapter_frame_status_out_frame_decoder/
mkdir -p ./libraries/rx_eth_frame_decoder/
mkdir -p ./libraries/rx_st_timing_adapter_frame_status_in/
mkdir -p ./libraries/rx_register_map/
mkdir -p ./libraries/tx_st_timing_adapter_splitter_out_0/
mkdir -p ./libraries/tx_st_splitter_xgmii/
mkdir -p ./libraries/tx_st_timing_adapter_splitter_in/
mkdir -p ./libraries/tx_st_pipeline_stage_rs/
mkdir -p ./libraries/tx_st_mux_flow_control_user_frame/
mkdir -p ./libraries/tx_st_pause_ctrl_error_adapter/
mkdir -p ./libraries/tx_register_map/
mkdir -p ./libraries/tx_bridge/
mkdir -p ./libraries/merlin_master_translator/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/stratixv_ver/
mkdir -p ./libraries/stratixv_hssi_ver/
mkdir -p ./libraries/stratixv_pcie_hip_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                      -work altera_ver           
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                               -work lpm_ver              
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                  -work sgate_ver            
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                              -work altera_mf_ver        
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                          -work altera_lnsim_ver     
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/stratixv_atoms_ncrypt.v"          -work stratixv_ver         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_atoms.v"                         -work stratixv_ver         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/stratixv_hssi_atoms_ncrypt.v"     -work stratixv_hssi_ver    
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_hssi_atoms.v"                    -work stratixv_hssi_ver    
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cadence/stratixv_pcie_hip_atoms_ncrypt.v" -work stratixv_pcie_hip_ver
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_pcie_hip_atoms.v"                -work stratixv_pcie_hip_ver
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/error_adapter/error_adapter_0003.sv"                                                 -work error_adapter_0                                            -cdslib ./cds_libs/error_adapter_0.cds.lib                                           
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_router/altera_merlin_router_0005.sv"                                   -work router                                                     -cdslib ./cds_libs/router.cds.lib                                                    
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_multiplexer_0004.sv"                         -work rsp_mux                                                    -cdslib ./cds_libs/rsp_mux.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_arbitrator.sv"                               -work rsp_mux                                                    -cdslib ./cds_libs/rsp_mux.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_demultiplexer/altera_merlin_demultiplexer_0004.sv"                     -work rsp_demux                                                  -cdslib ./cds_libs/rsp_demux.cds.lib                                                 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_multiplexer_0003.sv"                         -work cmd_mux                                                    -cdslib ./cds_libs/cmd_mux.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_arbitrator.sv"                               -work cmd_mux                                                    -cdslib ./cds_libs/cmd_mux.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_demultiplexer/altera_merlin_demultiplexer_0003.sv"                     -work cmd_demux                                                  -cdslib ./cds_libs/cmd_demux.cds.lib                                                 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_router/altera_merlin_router_0004.sv"                                   -work router_001                                                 -cdslib ./cds_libs/router_001.cds.lib                                                
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_router/altera_merlin_router_0003.sv"                                   -work router                                                     -cdslib ./cds_libs/router.cds.lib                                                    
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_avalon_st_adapter/altera_avalon_st_adapter_0001.v"                            -work avalon_st_adapter                                          -cdslib ./cds_libs/avalon_st_adapter.cds.lib                                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_avalon_st_handshake_clock_crosser/altera_avalon_st_handshake_clock_crosser.v" -work crosser                                                    -cdslib ./cds_libs/crosser.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_avalon_st_handshake_clock_crosser/altera_avalon_st_clock_crosser.v"           -work crosser                                                    -cdslib ./cds_libs/crosser.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_avalon_st_handshake_clock_crosser/altera_avalon_st_pipeline_base.v"           -work crosser                                                    -cdslib ./cds_libs/crosser.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_avalon_st_handshake_clock_crosser/altera_std_synchronizer_nocut.v"            -work crosser                                                    -cdslib ./cds_libs/crosser.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_multiplexer_0002.sv"                         -work rsp_mux                                                    -cdslib ./cds_libs/rsp_mux.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_arbitrator.sv"                               -work rsp_mux                                                    -cdslib ./cds_libs/rsp_mux.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_demultiplexer/altera_merlin_demultiplexer_0002.sv"                     -work rsp_demux                                                  -cdslib ./cds_libs/rsp_demux.cds.lib                                                 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_multiplexer_0001.sv"                         -work cmd_mux                                                    -cdslib ./cds_libs/cmd_mux.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_arbitrator.sv"                               -work cmd_mux                                                    -cdslib ./cds_libs/cmd_mux.cds.lib                                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_demultiplexer/altera_merlin_demultiplexer_0001.sv"                     -work cmd_demux                                                  -cdslib ./cds_libs/cmd_demux.cds.lib                                                 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_traffic_limiter/altera_merlin_traffic_limiter.sv"                      -work merlin_master_translator_avalon_universal_master_0_limiter -cdslib ./cds_libs/merlin_master_translator_avalon_universal_master_0_limiter.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_traffic_limiter/altera_merlin_reorder_memory.sv"                       -work merlin_master_translator_avalon_universal_master_0_limiter -cdslib ./cds_libs/merlin_master_translator_avalon_universal_master_0_limiter.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_traffic_limiter/altera_avalon_sc_fifo.v"                               -work merlin_master_translator_avalon_universal_master_0_limiter -cdslib ./cds_libs/merlin_master_translator_avalon_universal_master_0_limiter.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_traffic_limiter/altera_avalon_st_pipeline_base.v"                      -work merlin_master_translator_avalon_universal_master_0_limiter -cdslib ./cds_libs/merlin_master_translator_avalon_universal_master_0_limiter.cds.lib
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_router/altera_merlin_router_0002.sv"                                   -work router_001                                                 -cdslib ./cds_libs/router_001.cds.lib                                                
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_router/altera_merlin_router_0001.sv"                                   -work router                                                     -cdslib ./cds_libs/router.cds.lib                                                    
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_avalon_sc_fifo/altera_avalon_sc_fifo.v"                                       -work tx_bridge_s0_agent_rsp_fifo                                -cdslib ./cds_libs/tx_bridge_s0_agent_rsp_fifo.cds.lib                               
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_slave_agent/altera_merlin_slave_agent.sv"                              -work tx_bridge_s0_agent                                         -cdslib ./cds_libs/tx_bridge_s0_agent.cds.lib                                        
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_slave_agent/altera_merlin_burst_uncompressor.sv"                       -work tx_bridge_s0_agent                                         -cdslib ./cds_libs/tx_bridge_s0_agent.cds.lib                                        
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_master_agent/altera_merlin_master_agent.sv"                            -work merlin_master_translator_avalon_universal_master_0_agent   -cdslib ./cds_libs/merlin_master_translator_avalon_universal_master_0_agent.cds.lib  
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_slave_translator/altera_merlin_slave_translator.sv"                    -work tx_bridge_s0_translator                                    -cdslib ./cds_libs/tx_bridge_s0_translator.cds.lib                                   
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_reset_controller/altera_reset_controller.v"                                   -work rst_controller                                             -cdslib ./cds_libs/rst_controller.cds.lib                                            
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_reset_controller/altera_reset_synchronizer.v"                                 -work rst_controller                                             -cdslib ./cds_libs/rst_controller.cds.lib                                            
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_mm_interconnect/altera_mm_interconnect_0003.v"                                -work mm_interconnect_2                                          -cdslib ./cds_libs/mm_interconnect_2.cds.lib                                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_mm_interconnect/altera_mm_interconnect_0002.v"                                -work mm_interconnect_1                                          -cdslib ./cds_libs/mm_interconnect_1.cds.lib                                         
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_mm_interconnect/altera_mm_interconnect_0001.v"                                -work mm_interconnect_0                                          -cdslib ./cds_libs/mm_interconnect_0.cds.lib                                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/timing_adapter/timing_adapter_0008.sv"                                               -work rxtx_timing_adapter_pauselen_tx                            -cdslib ./cds_libs/rxtx_timing_adapter_pauselen_tx.cds.lib                           
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/timing_adapter/timing_adapter_0007.sv"                                               -work rxtx_timing_adapter_pauselen_rx                            -cdslib ./cds_libs/rxtx_timing_adapter_pauselen_rx.cds.lib                           
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_avalon_dc_fifo/altera_avalon_dc_fifo.v"                                       -work rxtx_dc_fifo_link_fault_status                             -cdslib ./cds_libs/rxtx_dc_fifo_link_fault_status.cds.lib                            
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_avalon_dc_fifo/altera_dcfifo_synchronizer_bundle.v"                           -work rxtx_dc_fifo_link_fault_status                             -cdslib ./cds_libs/rxtx_dc_fifo_link_fault_status.cds.lib                            
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_avalon_dc_fifo/altera_std_synchronizer_nocut.v"                               -work rxtx_dc_fifo_link_fault_status                             -cdslib ./cds_libs/rxtx_dc_fifo_link_fault_status.cds.lib                            
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/timing_adapter/timing_adapter_0006.sv"                                               -work txrx_timing_adapter_link_fault_status_export               -cdslib ./cds_libs/txrx_timing_adapter_link_fault_status_export.cds.lib              
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/timing_adapter/timing_adapter_0005.sv"                                               -work txrx_timing_adapter_link_fault_status_rx                   -cdslib ./cds_libs/txrx_timing_adapter_link_fault_status_rx.cds.lib                  
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/error_adapter/error_adapter_0002.sv"                                                 -work rx_st_error_adapter_stat                                   -cdslib ./cds_libs/rx_st_error_adapter_stat.cds.lib                                  
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_avalon_st_delay/altera_avalon_st_delay.sv"                                    -work rx_st_status_output_delay                                  -cdslib ./cds_libs/rx_st_status_output_delay.cds.lib                                 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_eth_crc_pad_rem/altera_eth_crc_pad_rem_pipeline_stage.sv"                     -work rx_eth_crc_pad_rem                                         -cdslib ./cds_libs/rx_eth_crc_pad_rem.cds.lib                                        
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_eth_crc_pad_rem/altera_eth_crc_pad_rem_pipeline_base.v"                       -work rx_eth_crc_pad_rem                                         -cdslib ./cds_libs/rx_eth_crc_pad_rem.cds.lib                                        
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/timing_adapter/timing_adapter_0004.sv"                                               -work rx_timing_adapter_frame_status_out_frame_decoder           -cdslib ./cds_libs/rx_timing_adapter_frame_status_out_frame_decoder.cds.lib          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_eth_frame_decoder/altera_eth_frame_decoder_pipeline_stage.sv"                 -work rx_eth_frame_decoder                                       -cdslib ./cds_libs/rx_eth_frame_decoder.cds.lib                                      
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_eth_frame_decoder/altera_eth_frame_decoder_pipeline_base.v"                   -work rx_eth_frame_decoder                                       -cdslib ./cds_libs/rx_eth_frame_decoder.cds.lib                                      
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/timing_adapter/timing_adapter_0003.sv"                                               -work rx_st_timing_adapter_frame_status_in                       -cdslib ./cds_libs/rx_st_timing_adapter_frame_status_in.cds.lib                      
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_eth_10g_rx_register_map/altera_avalon_st_clock_crosser.v"                     -work rx_register_map                                            -cdslib ./cds_libs/rx_register_map.cds.lib                                           
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/timing_adapter/timing_adapter_0002.sv"                                               -work tx_st_timing_adapter_splitter_out_0                        -cdslib ./cds_libs/tx_st_timing_adapter_splitter_out_0.cds.lib                       
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_avalon_st_splitter/altera_avalon_st_splitter.sv"                              -work tx_st_splitter_xgmii                                       -cdslib ./cds_libs/tx_st_splitter_xgmii.cds.lib                                      
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/timing_adapter/timing_adapter_0001.sv"                                               -work tx_st_timing_adapter_splitter_in                           -cdslib ./cds_libs/tx_st_timing_adapter_splitter_in.cds.lib                          
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_avalon_st_pipeline_stage/altera_avalon_st_pipeline_stage.sv"                  -work tx_st_pipeline_stage_rs                                    -cdslib ./cds_libs/tx_st_pipeline_stage_rs.cds.lib                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_avalon_st_pipeline_stage/altera_avalon_st_pipeline_base.v"                    -work tx_st_pipeline_stage_rs                                    -cdslib ./cds_libs/tx_st_pipeline_stage_rs.cds.lib                                   
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/multiplexer/multiplexer_0001.sv"                                                     -work tx_st_mux_flow_control_user_frame                          -cdslib ./cds_libs/tx_st_mux_flow_control_user_frame.cds.lib                         
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/error_adapter/error_adapter_0001.sv"                                                 -work tx_st_pause_ctrl_error_adapter                             -cdslib ./cds_libs/tx_st_pause_ctrl_error_adapter.cds.lib                            
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_eth_10g_tx_register_map/altera_avalon_st_clock_crosser.v"                     -work tx_register_map                                            -cdslib ./cds_libs/tx_register_map.cds.lib                                           
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/altera_avalon_mm_bridge/altera_avalon_mm_bridge.v"                                   -work tx_bridge                                                  -cdslib ./cds_libs/tx_bridge.cds.lib                                                 
  ncvlog -sv $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/altera_merlin_master_translator/altera_merlin_master_translator.sv"                  -work merlin_master_translator                                   -cdslib ./cds_libs/merlin_master_translator.cds.lib                                  
  ncvlog $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/Eth_10gmac.v"                                                                                                                                                                                                                              
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  export GENERIC_PARAM_COMPAT_CHECK=1
  ncelab -access +w+r+c -namemap_mixgen $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  eval ncsim -licqueue $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS $TOP_LEVEL_NAME
fi
