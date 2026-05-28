// ============================================
// Traffic Light Controller - FSM
// File: traffic_light.v
// ============================================

module traffic_light(
    input  clk,        // Clock signal
    input  reset,      // Active-high reset
    output reg red,    // Red light output
    output reg green,  // Green light output
    output reg yellow  // Yellow light output
);

    // --- State Encoding ---
    localparam RED_STATE    = 2'b00;
    localparam GREEN_STATE  = 2'b01;
    localparam YELLOW_STATE = 2'b10;

    // --- Timing (how many clock cycles each light stays ON) ---
    localparam RED_TIME    = 4'd6;
    localparam GREEN_TIME  = 4'd4;
    localparam YELLOW_TIME = 4'd2;

    // --- Internal Registers ---
    reg [1:0] state;   // Current state (2 bits for 3 states)
    reg [3:0] count;   // Counter (4 bits = counts up to 15)

    // ============================================
    // SEQUENTIAL BLOCK: State transitions + Counter
    // Runs on every rising clock edge
    // ============================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // On reset: go to RED, load RED timer
            state <= RED_STATE;
            count <= RED_TIME - 1;
        end else begin
            if (count == 0) begin
                // Timer expired → move to next state
                case (state)
                    RED_STATE: begin
                        state <= GREEN_STATE;
                        count <= GREEN_TIME - 1;   // Load GREEN timer
                    end
                    GREEN_STATE: begin
                        state <= YELLOW_STATE;
                        count <= YELLOW_TIME - 1;  // Load YELLOW timer
                    end
                    YELLOW_STATE: begin
                        state <= RED_STATE;
                        count <= RED_TIME - 1;     // Load RED timer again
                    end
                    default: begin
                        state <= RED_STATE;
                        count <= RED_TIME - 1;
                    end
                endcase
            end else begin
                count <= count - 1;  // Decrement timer each clock
            end
        end
    end

    // ============================================
    // COMBINATIONAL BLOCK: Output logic
    // Lights depend on current state
    // ============================================
    always @(*) begin
        red    = (state == RED_STATE);
        green  = (state == GREEN_STATE);
        yellow = (state == YELLOW_STATE);
    end

endmodule