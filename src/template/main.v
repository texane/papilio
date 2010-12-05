module counter(clk, porta);
   input clk;
   output [7:0] porta;

   reg [27:0] count;
   
   always @(posedge clk)
     begin
	count <= count + 1;
	if (count[20] == 0)
	  begin
	     count[20] <= 1;
	  end
     end

   assign porta = count[27:20];
   
endmodule // counter
