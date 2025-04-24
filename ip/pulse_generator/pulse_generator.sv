module pulse_generator (
    input  logic        clk,
    input  logic        reset_n,
    input  logic        start,
    input  logic [31:0] delay_cycles,
    input  logic [31:0] pulse_width_cycles,
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

  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      state     <= IDLE;
      counter   <= 32'd0;
      pulse_out <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          pulse_out <= 1'b0;
          if (start) begin
            counter <= delay_cycles;
            state   <= DELAY;
          end
        end

        DELAY: begin
          if (counter == 32'd1) begin
            counter   <= pulse_width_cycles;
            pulse_out <= 1'b1;
            state     <= PULSE;
          end else begin
            counter <= counter - 32'd1;
          end
        end

        PULSE: begin
          if (counter == 32'd1) begin
            pulse_out <= 1'b0;
            state     <= IDLE;
          end else begin
            counter <= counter - 32'd1;
          end
        end
      endcase
    end
  end

  assign pulse_led = (state == PULSE);
  assign delay_led = (state == DELAY);

endmodule
