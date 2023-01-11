module model #(parameter
  DATA_WIDTH = 32
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

  logic [DATA_WIDTH-1:0] first, second;
  logic [DATA_WIDTH-1:0] next_first, next_second;

  assign dout = second;

  always_comb begin
    if (resetn == 1'b0) begin
      next_first = 0;
      next_second = 0;
    end
    else begin
      if( din >= first ) begin
        //Change current first
        next_first = din;
        //next second will be current first
        next_second = first;
      end
      else begin
        if( din >= second ) begin
          next_first = first;
          next_second = din;
        end
        else begin
          next_first = first;
          next_second = second;
        end
      end
    end
  end

  always @(posedge clk) begin
    first <= next_first;
    second <= next_second;
  end

endmodule