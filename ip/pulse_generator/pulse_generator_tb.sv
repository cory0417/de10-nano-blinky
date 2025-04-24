`timescale 1ns / 1ps

module pulse_generator_tb;

  // Inputs
  logic clk;
  logic reset_n;
  logic start;
  logic [31:0] delay_cycles;
  logic [31:0] pulse_width_cycles;

  // Outputs
  logic pulse_out;
  logic pulse_led;
  logic delay_led;

  // Instantiate DUT
  pulse_generator uut (
      .clk(clk),
      .reset_n(reset_n),
      .start(start),
      .delay_cycles(delay_cycles),
      .pulse_width_cycles(pulse_width_cycles),
      .pulse_out(pulse_out),
      .pulse_led(pulse_led),
      .delay_led(delay_led)
  );

  // Clock generation: 50MHz (20ns period)
  localparam CLK_PERIOD = 20;
  always #(CLK_PERIOD / 2) clk = ~clk;

  // Test sequence
  initial begin
    // Initialize
    clk = 0;
    reset_n = 0;
    start = 0;
    delay_cycles = 0;
    pulse_width_cycles = 0;

    $display("Starting test...");
    $dumpfile("pulse_generator_tb.vcd");
    $dumpvars(0, pulse_generator_tb);
    // Apply reset
    #50;
    reset_n            = 1;

    // Set delay and pulse width
    delay_cycles       = 10;  // 10 clock cycles = 200ns
    pulse_width_cycles = 20;  // 20 clock cycles = 400ns

    // Wait a few clocks
    #100;

    // Trigger start pulse
    start = 1;
    #20;
    start = 0;

    // Wait long enough to observe the pulse
    #1000;

    $display("Test finished.");
    $finish;
  end

endmodule
