/*
  * Pulse Generator Module
  * This module generates a pulse signal with a specified delay and width.
  * It also provides LED indicators for the pulse and delay states.
  *
  * Parameters:
  *   - clk: Clock input
  *   - reset_n: Active low reset input
  *   - start_in: Start signal to initiate pulse generation (from external source)
  *   - delay_cycles: Number of clock cycles for the delay before the pulse
  *   - pulse_width_cycles: Number of clock cycles for the pulse width
  *   - repetition: Number of repetitions for the pulse generation -- 0 means infinite
  *
  * Outputs:
  *   - start_ack: Acknowledgment signal for the start input
  *   - pulse_out: Generated pulse output
  *   - pulse_led: LED indicator for the pulse state
  *   - delay_led: LED indicator for the delay state
  *
  * Description: 
  *   The module uses a finite state machine (FSM) to manage the pulse generation process.
  *   It has three states: IDLE, DELAY, and PULSE.
  *   - In IDLE state, it waits for the start signal.
  *   - In DELAY state, it counts down the delay_cycles.
  *   - In PULSE state, it generates the pulse for pulse_width_cycles.
  *   After the pulse, it goes back to IDLE or DELAY based on the repetition count.
  *   The pulse_out signal is asserted during the PULSE state.
  *   The pulse_led and delay_led signals indicate the current state of the FSM.
  *   The module is designed to be used in a hardware system where pulse generation is required.
  */

module pulse_generator (
    input  logic        clk,
    input  logic        reset_n,
    input  logic        start_in,
    input  logic [31:0] delay_cycles,
    input  logic [31:0] pulse_width_cycles,
    input  logic [15:0] repetition,
    output logic        start_ack,
    output logic        pulse_out,
    output logic        pulse_led,
    output logic        delay_led
);


  // State definitions
  typedef enum logic [1:0] {
    IDLE  = 2'b00,
    DELAY = 2'b01,
    PULSE = 2'b10
  } state_t;

  state_t state;
  logic [31:0] counter;
  logic [15:0] repetition_counter;
  logic is_last_repetition;
  logic pulse_done;
  logic internal_start;

  assign is_last_repetition = (repetition_counter == 1) ? 1'b1 : 1'b0;


  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      state <= IDLE;
      counter <= 32'd0;
      repetition_counter <= 16'd0;
      start_ack <= 1'b0;
    end else if (start_in) begin
      if (start_in) begin
        if (delay_cycles > 0) begin
          repetition_counter <= repetition;
          counter <= delay_cycles;
          state <= DELAY;
        end else begin
          if (pulse_width_cycles > 0) begin
            repetition_counter <= repetition;
            counter <= pulse_width_cycles;
            state <= PULSE;
          end else begin
            state <= IDLE;  // No pulse to generate
          end
        end
        start_ack <= 1'b1;  // Acknowledge start
      end else begin
        start_ack <= 1'b0;  // Clear start_ack when in IDLE
      end
    end else begin
      case (state)
        IDLE: state <= IDLE;  // No pulse to generate
        DELAY: begin
          start_ack <= 1'b0;  // Clear start_ack when in DELAY
          if (counter == 32'd1) begin
            if (pulse_width_cycles > 0) begin
              counter <= pulse_width_cycles;
              state   <= PULSE;
            end else begin
              state <= IDLE;  // No pulse to generate
            end
          end else begin
            counter <= counter - 32'd1;
          end
        end

        PULSE: begin
          start_ack <= 1'b0;  // Clear start_ack when in DELAY
          if (counter == 32'd1) begin
            if (is_last_repetition) begin
              state <= IDLE;
              repetition_counter <= 16'd0;
            end else begin
              if (delay_cycles > 0) begin
                counter <= delay_cycles;
                state   <= DELAY;
              end else begin
                counter <= pulse_width_cycles;
                state   <= PULSE;
              end
              if (repetition_counter > 0) repetition_counter <= repetition_counter - 1;
            end
          end else begin
            counter <= counter - 32'd1;
          end
        end
      endcase
    end
  end

  assign pulse_led = (state == PULSE);
  assign delay_led = (state == DELAY);
  assign pulse_out = (state == PULSE);

endmodule

module pulse_generator_pio (
    input  logic        clk,
    input  logic        reset_n,
    input  logic        start_pio,
    input  logic [31:0] delay_cycles,
    input  logic [31:0] pulse_width_cycles,
    input  logic [15:0] repetition,
    output logic        pulse_out,
    output logic        pulse_led,
    output logic        delay_led
);

  logic req_ff, start_edge;

  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      req_ff <= 0;
    end else begin
      req_ff <= start_pio;  // PIO from CPU
    end
  end

  assign start_edge = start_pio & ~req_ff;  // one-cycle pulse

  // Instantiate the pulse generator module
  pulse_generator u_pulse_generator (
      .clk(clk),
      .reset_n(reset_n),
      .start_in(start_edge),
      .delay_cycles(delay_cycles),
      .pulse_width_cycles(pulse_width_cycles),
      .repetition(repetition),
      .start_ack(start_ack),
      .pulse_out(pulse_out),
      .pulse_led(pulse_led),
      .delay_led(delay_led)
  );

endmodule
