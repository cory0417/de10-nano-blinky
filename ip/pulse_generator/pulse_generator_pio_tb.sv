`timescale 1ns / 1ps

module pulse_generator_pio_tb;

  // clock & reset
  logic        clk;
  logic        reset_n;

  // inputs to DUT
  logic        start_pio;
  logic [31:0] delay_cycles;
  logic [31:0] pulse_width_cycles;
  logic [15:0] repetition;

  // outputs from DUT
  logic        pulse_out;
  logic        pulse_led;
  logic        delay_led;

  // instantiate the wrapper
  pulse_generator_pio dut (
      .clk               (clk),
      .reset_n           (reset_n),
      .start_pio         (start_pio),
      .delay_cycles      (delay_cycles),
      .pulse_width_cycles(pulse_width_cycles),
      .repetition        (repetition),
      .pulse_out         (pulse_out),
      .pulse_led         (pulse_led),
      .delay_led         (delay_led)
  );

  // expose the internal edge‐detect & ack for checking
  // (you can reference them hierarchically)
  wire start_edge = dut.start_edge;
  wire start_ack = dut.u_pulse_generator.start_ack;

  // 100 MHz clock
  initial clk = 0;
  always #5 clk = ~clk;

  // test sequence
  initial begin
    // dump a VCD for waveform inspection
    $dumpfile("pulse_generator_pio_tb.vcd");
    $dumpvars(0, pulse_generator_pio_tb);

    // initial reset
    reset_n            = 0;
    start_pio          = 0;
    delay_cycles       = 0;
    pulse_width_cycles = 0;
    repetition         = 0;
    #20 reset_n = 1;

    // 1) single pulse test
    delay_cycles       = 3;
    pulse_width_cycles = 2;
    repetition         = 1;
    #10 start_pio = 1;

    // wait long enough for 3+2+slop cycles
    #((delay_cycles + pulse_width_cycles + 2) * 10);

    // check we returned to idle
    if (pulse_out || pulse_led || delay_led) $fatal(1, "Single‐pulse failed to return to idle.");

    // 2) two‐repetition pulse
    delay_cycles       = 2;
    pulse_width_cycles = 1;
    repetition         = 2;
    start_pio          = 0;
    #10 start_pio = 1;

    // wait enough for (delay+width)*2 + margin
    #((delay_cycles + pulse_width_cycles) * repetition * 10 + 20);

    // final check
    if (pulse_out || pulse_led || delay_led) $fatal(1, "Repetition test failed to return to idle.");

    $display(">> All tests passed!");
    $finish;
  end

  // live monitor of key signals
  initial begin
    $display(" time | start_pio start_edge start_ack | delay_led pulse_led pulse_out");
    $monitor("%5t |     %b         %b        %b   |     %b         %b         %b", $time,
             start_pio, start_edge, start_ack, delay_led, pulse_led, pulse_out);
  end

endmodule
