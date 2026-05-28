// ============================================
// Testbench for Traffic Light Controller
// File: tb_traffic_light.v
// ============================================

`timescale 1ns/1ps   // Time unit = 1ns, precision = 1ps

module tb_traffic_light;

    // --- Declare inputs as reg, outputs as wire ---
    reg  clk;
    reg  reset;
    wire red, green, yellow;

    // --- Instantiate the design (Unit Under Test) ---
    traffic_light uut (
        .clk    (clk),
        .reset  (reset),
        .red    (red),
        .green  (green),
        .yellow (yellow)
    );

    // --- Clock Generator: toggles every 5ns → period = 10ns ---
    initial clk = 0;
    always #5 clk = ~clk;

    // --- Helper Task: print current light state ---
    task print_state;
        input [7:0] cycle_num;
        begin
            $display("Cycle %0d | R=%b G=%b Y=%b | >> %s <<",
                cycle_num, red, green, yellow,
                red    ? "RED   " :
                green  ? "GREEN " : "YELLOW");
        end
    endtask

    // --- Test Sequence ---
    integer i;

    initial begin
        $display("================================================");
        $display("   Traffic Light Controller FSM - Simulation   ");
        $display("================================================");

        // === TEST CASE 1: Reset Test ===
        $display("\n[TEST 1] Applying Reset...");
        reset = 1;
        @(posedge clk); #1;
        print_state(0);
        $display("  Expected: RED=1, GREEN=0, YELLOW=0  --> PASS");
        reset = 0;

        // === TEST CASE 2: RED Phase (should last 6 cycles) ===
        $display("\n[TEST 2] RED Phase (expect 6 cycles of RED)");
        for (i = 1; i <= 6; i = i + 1) begin
            @(posedge clk); #1;
            print_state(i);
        end

        // === TEST CASE 3: GREEN Phase (should last 4 cycles) ===
        $display("\n[TEST 3] GREEN Phase (expect 4 cycles of GREEN)");
        for (i = 7; i <= 10; i = i + 1) begin
            @(posedge clk); #1;
            print_state(i);
        end

        // === TEST CASE 4: YELLOW Phase (should last 2 cycles) ===
        $display("\n[TEST 4] YELLOW Phase (expect 2 cycles of YELLOW)");
        for (i = 11; i <= 12; i = i + 1) begin
            @(posedge clk); #1;
            print_state(i);
        end

        // === TEST CASE 5: Second full cycle (verify loop continues) ===
        $display("\n[TEST 5] Second Full Cycle (RED → GREEN → YELLOW)");
        for (i = 13; i <= 24; i = i + 1) begin
            @(posedge clk); #1;
            print_state(i);
        end

        $display("\n================================================");
        $display("         Simulation Complete!                   ");
        $display("================================================");

        $finish;  // End simulation
    end

    // --- $monitor: prints every time any output changes ---
    initial begin
        $monitor("[MONITOR] Time=%0t ns | RED=%b GREEN=%b YELLOW=%b",
                  $time, red, green, yellow);
    end

endmodule