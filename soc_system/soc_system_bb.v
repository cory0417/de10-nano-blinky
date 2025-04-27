
module soc_system (
	clk_clk,
	fpga_clk_pll_100_clk,
	hps_0_h2f_reset_reset_n,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	pll_0_locked_export,
	pll_0_refclk_clk,
	pll_0_reset_reset,
	pulse_delay_pio_export,
	pulse_start_pio_export,
	pulse_width_pio_export,
	reset_reset_n);	

	input		clk_clk;
	output		fpga_clk_pll_100_clk;
	output		hps_0_h2f_reset_reset_n;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
	output		pll_0_locked_export;
	input		pll_0_refclk_clk;
	input		pll_0_reset_reset;
	output	[31:0]	pulse_delay_pio_export;
	output		pulse_start_pio_export;
	output	[31:0]	pulse_width_pio_export;
	input		reset_reset_n;
endmodule
