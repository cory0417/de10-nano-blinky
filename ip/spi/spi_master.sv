module spi_master #(
    parameter D_WIDTH = 16
)(
    input  logic clk,           // 50 MHz system clock
    input  logic reset_n,
    input  logic start,         // signal to start transmission
    input  logic [D_WIDTH:1] d_in,  // data to transmit

    output logic sclk,          // SPI clock
    output logic mosi,          // to slave
    output logic cs,            // active-low chip select
    output logic busy,          // high during transmission
	 output logic ldac
);
	typedef enum logic [1:0] {
		IDLE,
		TRANSFER,
		DONE
	} state_t;

	state_t state;

	logic [D_WIDTH-1:0] shift_reg_out;
	logic [$clog2(D_WIDTH):1] bit_cnt;

	// Clock divider: divide 50MHz to 12.5MHz (divide by 4)
	logic clk_div;
	logic sclk_en;
	logic sclk_int;

	assign sclk = sclk_int;
	assign cs   = (state == TRANSFER) ? 0 : 1;
	assign busy = (state != IDLE);

	always_ff @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			clk_div   <= 0;
         sclk_int  <= 0;
         sclk_en   <= 0;
      end else begin
			sclk_en <= 0;
			if (state == TRANSFER) begin
				clk_div <= clk_div + 1;
					if (clk_div == 1) begin
						sclk_int <= ~sclk_int;
						sclk_en  <= 1;
					end
			end else begin
				clk_div  <= 0;
				sclk_int <= 0;
			end
		end
	end

	always_ff @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			state <= IDLE;
			bit_cnt <= 0;
			shift_reg_out <= 0;
			ldac <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (start) begin
						state <= TRANSFER;
						bit_cnt <= D_WIDTH;
						shift_reg_out <= d_in;
					end
					
				end

				TRANSFER: begin
				end

				DONE: begin
					state <= IDLE;
				end
			endcase
		end
	end

	assign mosi = shift_reg_out[D_WIDTH-1];  // Transfer MSB first
	
	always_ff @(negedge sclk_int) begin
		if (state == TRANSFER | state == DONE) begin
			shift_reg_out <= {shift_reg_out[D_WIDTH-2:0], 1'b0};
			if (bit_cnt == 1) state <= DONE;
			bit_cnt <= bit_cnt - 1;
		end
	end
endmodule
