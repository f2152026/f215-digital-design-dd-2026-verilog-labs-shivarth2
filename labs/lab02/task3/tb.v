// tb.v

module tb;

  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;
  integer    i, j;

  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  initial begin
    for (i = 0; i < 4; i = i + 1)
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i[1:0]; t_b = j[1:0]; #5;
        if ({t_gt, t_lt, t_eq} !== {(i > j), (i < j), (i == j)})
          $display("ERROR: A=%0d B=%0d -> GT=%b LT=%b EQ=%b", t_a, t_b, t_gt, t_lt, t_eq);
      end
    $finish;
  end

  initial
    $monitor($time, " A=%b B=%b | GT=%b LT=%b EQ=%b", t_a, t_b, t_gt, t_lt, t_eq);

endmodule