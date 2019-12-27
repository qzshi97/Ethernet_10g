
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
# vcs - auto-generated simulation script

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
# testbench files, follow the guidelines below.
# 
# 1) Copy the shell script text from the TOP-LEVEL TEMPLATE section
# below into a new file, e.g. named "vcs_sim.sh".
# 
# 2) Copy the text from the DESIGN FILE LIST & OPTIONS TEMPLATE section into
# a separate file, e.g. named "filelist.f".
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # TOP_LEVEL_NAME is used in the Quartus-generated IP simulation script to
# # set the top-level simulation or testbench module/entity name.
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator.
# #
# # Source the Quartus-generated IP simulation script and do the following:
# # - Compile the Quartus EDA simulation library and IP simulation files.
# # - Specify TOP_LEVEL_NAME and QSYS_SIMDIR.
# # - Compile the design and top-level simulation module/entity using
# #   information specified in "filelist.f".
# # - Override the default USER_DEFINED_SIM_OPTIONS. For example, to run
# #   until $finish(), set to an empty string: USER_DEFINED_SIM_OPTIONS="".
# # - Run the simulation.
# #
# source <script generation output directory>/synopsys/vcs/vcs_setup.sh \
# TOP_LEVEL_NAME=<simulation top> \
# QSYS_SIMDIR=<script generation output directory> \
# USER_DEFINED_ELAB_OPTIONS="\"-f filelist.f\"" \
# USER_DEFINED_SIM_OPTIONS=<simulation options for your design>
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# ----------------------------------------
# # DESIGN FILE LIST & OPTIONS TEMPLATE - BEGIN
# #
# # Compile all design files and testbench files, including the top level.
# # (These are all the files required for simulation other than the files
# # compiled by the Quartus-generated IP simulation script)
# #
# +systemverilogext+.sv
# <design and testbench files, compile-time options, elaboration options>
# #
# # DESIGN FILE LIST & OPTIONS TEMPLATE - END
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
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="D:/intelfpga/17.1/quartus/"
SKIP_FILE_COPY=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"
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
if [[ `vcs -platform` != *"amd64"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# copy RAM/ROM files to simulation directory

vcs -lca -timescale=1ps/1ps -sverilog +verilog2001ext+.v -ntb_opts dtm $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v \
  $QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/stratixv_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_atoms.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/stratixv_hssi_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_hssi_atoms.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/stratixv_pcie_hip_atoms_ncrypt.v \
  -v $QUARTUS_INSTALL_DIR/eda/sim_lib/stratixv_pcie_hip_atoms.v \
  $QSYS_SIMDIR/error_adapter/error_adapter_0003.sv \
  $QSYS_SIMDIR/altera_merlin_router/altera_merlin_router_0005.sv \
  $QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_multiplexer_0004.sv \
  $QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_arbitrator.sv \
  $QSYS_SIMDIR/altera_merlin_demultiplexer/altera_merlin_demultiplexer_0004.sv \
  $QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_multiplexer_0003.sv \
  $QSYS_SIMDIR/altera_merlin_demultiplexer/altera_merlin_demultiplexer_0003.sv \
  $QSYS_SIMDIR/altera_merlin_router/altera_merlin_router_0004.sv \
  $QSYS_SIMDIR/altera_merlin_router/altera_merlin_router_0003.sv \
  $QSYS_SIMDIR/altera_avalon_st_adapter/altera_avalon_st_adapter_0001.v \
  $QSYS_SIMDIR/altera_avalon_st_handshake_clock_crosser/altera_avalon_st_handshake_clock_crosser.v \
  $QSYS_SIMDIR/altera_avalon_st_handshake_clock_crosser/altera_avalon_st_clock_crosser.v \
  $QSYS_SIMDIR/altera_avalon_st_handshake_clock_crosser/altera_avalon_st_pipeline_base.v \
  $QSYS_SIMDIR/altera_avalon_st_handshake_clock_crosser/altera_std_synchronizer_nocut.v \
  $QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_multiplexer_0002.sv \
  $QSYS_SIMDIR/altera_merlin_demultiplexer/altera_merlin_demultiplexer_0002.sv \
  $QSYS_SIMDIR/altera_merlin_multiplexer/altera_merlin_multiplexer_0001.sv \
  $QSYS_SIMDIR/altera_merlin_demultiplexer/altera_merlin_demultiplexer_0001.sv \
  $QSYS_SIMDIR/altera_merlin_traffic_limiter/altera_merlin_traffic_limiter.sv \
  $QSYS_SIMDIR/altera_merlin_traffic_limiter/altera_merlin_reorder_memory.sv \
  $QSYS_SIMDIR/altera_merlin_traffic_limiter/altera_avalon_sc_fifo.v \
  $QSYS_SIMDIR/altera_merlin_router/altera_merlin_router_0002.sv \
  $QSYS_SIMDIR/altera_merlin_router/altera_merlin_router_0001.sv \
  $QSYS_SIMDIR/altera_merlin_slave_agent/altera_merlin_slave_agent.sv \
  $QSYS_SIMDIR/altera_merlin_slave_agent/altera_merlin_burst_uncompressor.sv \
  $QSYS_SIMDIR/altera_merlin_master_agent/altera_merlin_master_agent.sv \
  $QSYS_SIMDIR/altera_merlin_slave_translator/altera_merlin_slave_translator.sv \
  $QSYS_SIMDIR/altera_reset_controller/altera_reset_controller.v \
  $QSYS_SIMDIR/altera_reset_controller/altera_reset_synchronizer.v \
  $QSYS_SIMDIR/altera_mm_interconnect/altera_mm_interconnect_0003.v \
  $QSYS_SIMDIR/altera_mm_interconnect/altera_mm_interconnect_0002.v \
  $QSYS_SIMDIR/altera_mm_interconnect/altera_mm_interconnect_0001.v \
  $QSYS_SIMDIR/timing_adapter/timing_adapter_0008.sv \
  $QSYS_SIMDIR/timing_adapter/timing_adapter_0007.sv \
  $QSYS_SIMDIR/altera_avalon_dc_fifo/altera_avalon_dc_fifo.v \
  $QSYS_SIMDIR/altera_avalon_dc_fifo/altera_dcfifo_synchronizer_bundle.v \
  $QSYS_SIMDIR/timing_adapter/timing_adapter_0006.sv \
  $QSYS_SIMDIR/timing_adapter/timing_adapter_0005.sv \
  $QSYS_SIMDIR/error_adapter/error_adapter_0002.sv \
  $QSYS_SIMDIR/altera_avalon_st_delay/altera_avalon_st_delay.sv \
  $QSYS_SIMDIR/altera_eth_crc_pad_rem/altera_eth_crc_pad_rem_pipeline_stage.sv \
  $QSYS_SIMDIR/altera_eth_crc_pad_rem/altera_eth_crc_pad_rem_pipeline_base.v \
  $QSYS_SIMDIR/timing_adapter/timing_adapter_0004.sv \
  $QSYS_SIMDIR/altera_eth_frame_decoder/altera_eth_frame_decoder_pipeline_stage.sv \
  $QSYS_SIMDIR/altera_eth_frame_decoder/altera_eth_frame_decoder_pipeline_base.v \
  $QSYS_SIMDIR/timing_adapter/timing_adapter_0003.sv \
  $QSYS_SIMDIR/timing_adapter/timing_adapter_0002.sv \
  $QSYS_SIMDIR/altera_avalon_st_splitter/altera_avalon_st_splitter.sv \
  $QSYS_SIMDIR/timing_adapter/timing_adapter_0001.sv \
  $QSYS_SIMDIR/altera_avalon_st_pipeline_stage/altera_avalon_st_pipeline_stage.sv \
  $QSYS_SIMDIR/multiplexer/multiplexer_0001.sv \
  $QSYS_SIMDIR/error_adapter/error_adapter_0001.sv \
  $QSYS_SIMDIR/altera_avalon_mm_bridge/altera_avalon_mm_bridge.v \
  $QSYS_SIMDIR/altera_merlin_master_translator/altera_merlin_master_translator.sv \
  $QSYS_SIMDIR/Eth_10gmac.v \
  -top $TOP_LEVEL_NAME
# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS
fi