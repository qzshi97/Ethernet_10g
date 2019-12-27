transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {Ethernet_10g.vo}

vlog -vlog01compat -work work +incdir+D:/FPGA/Ethernet/V2.6/Ethernet_10g/simulation/modelsim {D:/FPGA/Ethernet/V2.6/Ethernet_10g/simulation/modelsim/Ethernet_10g.vt}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L altera_lnsim_ver -L stratixv_ver -L lpm_ver -L sgate_ver -L stratixv_hssi_ver -L altera_mf_ver -L stratixv_pcie_hip_ver -L gate_work -L work -voptargs="+acc"  Ethernet_10g_vlg_tst

add wave *
view structure
view signals
run -all
