`timescale 1ns / 1ns

module pulse_generator_tb;

  // Inputs
  logic clk;
  logic reset_n;
  logic start_in;
  logic [31:0] delay_cycles;
  logic [31:0] pulse_width_cycles;
  logic [15:0] repetition;

  // Outputs
  logic start_ack;
  logic pulse_out;
  logic pulse_led;
  logic delay_led;


  // Instantiate DUT
  pulse_generator uut (
      .clk(clk),
      .reset_n(reset_n),
      .start_in(start_in),
      .delay_cycles(delay_cycles),
      .pulse_width_cycles(pulse_width_cycles),
      .repetition(repetition),
      .start_ack(start_ack),
      .pulse_out(pulse_out),
      .pulse_led(pulse_led),
      .delay_led(delay_led)
  );

  // Clock generation: 100MHz (10ns period)
  localparam CLK_PERIOD = 10;
  always #(CLK_PERIOD / 2) clk = ~clk;

  // Test sequence
  initial begin
    // Initialize
    clk = 0;
    reset_n = 0;
    start_in = 0;
    delay_cycles = 0;
    pulse_width_cycles = 0;
    repetition = 0;

    $display("Starting test...");
    $dumpfile("pulse_generator_tb.vcd");
    $dumpvars(0, pulse_generator_tb);
    // Apply reset
    #50;
    reset_n            = 1;

    // Set delay and pulse width
    delay_cycles       = 10;  // 10 clock cycles = 100ns
    pulse_width_cycles = 20;  // 20 clock cycles = 200ns
    repetition         = 2;  // 2 repetitions
    // --- Normal operation ---
    $display("Testing normal pulse sequence...");
    start_in = 1;
    wait (start_ack == 1);
    start_in = 0;  // Clear start_in to simulate a pulse

    // Wait enough to see pulses complete
    #1000;
    assert (uut.state == uut.IDLE)
    else $fatal(1, "Error: Did not return to IDLE after repetitions");


    // --- Test early stop ---
    $display("Testing early stop by pulling reset...");
    repetition = 10;  // many repetitions
    start_in   = 1;
    wait (start_ack == 1);
    start_in = 0;  // Clear start_in to simulate a pulse
    #500;
    reset_n = 0;  // Pull reset
    #25;
    reset_n = 1;  // Release reset
    assert (uut.state == uut.IDLE)
    else $fatal(1, "Error: Module did not reset to IDLE when start=0");


    // --- Test infinite repetition ---
    $display("Testing infinite repetition mode...");
    repetition = 0;  // infinite
    start_in   = 1;
    wait (start_ack == 1);
    start_in = 0;  // Clear start_in to simulate a pulse
    #3000;

    // Check that repetition counter does not go to zero (infinite)
    assert (uut.is_last_repetition == 0)
    else $fatal(1, "Error: Infinite mode incorrectly finished");

    $display("Test finished successfully.");
    $finish;
  end

endmodule
