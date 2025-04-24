`timescale 1ns/1ns

module spi_master_tb;

  parameter D_WIDTH = 16;

  // Testbench signals
  logic clk = 0;
  logic reset_n = 0;
  logic start = 0;
  logic [D_WIDTH-1:0] d_in;
  logic sclk;
  logic mosi;
  logic cs;
  logic busy;
  logic ldac;

  // Instantiate DUT
  spi_master #(.D_WIDTH(D_WIDTH)) uut (
    .clk(clk),
    .reset_n(reset_n),
    .start(start),
    .d_in(d_in),
    .mosi(mosi),
    .sclk(sclk),
    .cs(cs),
    .busy(busy),
	 .ldac(ldac)
  );

  // Clock generation: 50 MHz
  always #10 clk = ~clk;
  
  // Stimulus
  initial begin
    $dumpfile("spi_master_tb.vcd");
    $dumpvars(0, spi_master_tb);

    d_in = 16'hA5A5;
    #30 reset_n = 1;       // Release reset
    #50 start = 1;         // Trigger start
    #20 start = 0;         // Deassert start

    // Wait for transmission to complete
    wait (!busy);
    #200;
    $finish;
  end

endmodule
