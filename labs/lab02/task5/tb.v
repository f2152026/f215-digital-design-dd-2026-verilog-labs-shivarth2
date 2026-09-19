// tb.v
module tb;

  reg  [3:0] t_a, t_b;
  reg        t_op;
  wire [3:0] t_result;
  integer    i, j, k;
  reg  [3:0] exp;

  alu DUT (.a(t_a), .b(t_b), .op(t_op), .result(t_result));

  initial begin
    // Exhaustive check: every a, b, op combination.
    for (i = 0; i < 16; i = i + 1)
      for (j = 0; j < 16; j = j + 1)
        for (k = 0; k < 2; k = k + 1) begin
          t_a = i[3:0]; t_b = j[3:0]; t_op = k[0]; #1;
          exp = k ? (t_a - t_b) : (t_a + t_b);
          if (t_result !== exp)
            $display("ERROR: a=%0d b=%0d op=%0d got=%0d exp=%0d", t_a, t_b, t_op, t_result, exp);
          $display("a=%0d b=%0d op=%0d got=%0d", t_a, t_b, t_op, t_result);
        end

    t_a = 5; t_b = 3; t_op = 0; #1;
    t_op = 1; #1;
    if (t_result !== (t_a - t_b))
      $display("ERROR: op-only toggle -> result didn't update, got=%0d exp=%0d", t_result, t_a - t_b);

    $display("DONE");
    $finish;
  end

endmodule