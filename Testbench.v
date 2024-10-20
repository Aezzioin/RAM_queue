`timescale 1ns / 100ps

module tb();
   reg rst_n;
   reg clk;
   always #10 clk= ~clk; //系统时钟频率50MHz，每10ns有一个边沿

   reg [5:0] data_in_tb;
   wire [5:0] data_out_tb;

   top #(.DATA_WIDTH(6), .ADDR_WIDTH(4) ) top_inst
   (
      .clk(clk), 
      .rst_n(rst_n), 
      .data_in(data_in_tb),
      .data_out(data_out_tb)
   );


   initial begin
		$dumpfile("testDump.vcd");
		$dumpvars(0, top_inst);
      $dumpvars(
      1,
      tb.top_inst.datapath_inst.queue.ram[0],
      tb.top_inst.datapath_inst.queue.ram[1],
      tb.top_inst.datapath_inst.queue.ram[2],
      tb.top_inst.datapath_inst.queue.ram[3],
      tb.top_inst.datapath_inst.queue.ram[4],
      tb.top_inst.datapath_inst.queue.ram[5],
      tb.top_inst.datapath_inst.queue.ram[6],
      tb.top_inst.datapath_inst.queue.ram[7],
      tb.top_inst.datapath_inst.queue.ram[8],
      tb.top_inst.datapath_inst.queue.ram[9],
      tb.top_inst.datapath_inst.queue.ram[10],
      tb.top_inst.datapath_inst.queue.ram[11],
      tb.top_inst.datapath_inst.queue.ram[12],
      tb.top_inst.datapath_inst.queue.ram[13],
      tb.top_inst.datapath_inst.queue.ram[14],
      tb.top_inst.datapath_inst.queue.ram[15]
    );
      //在第0ns时：设置时钟信号为0,重置信号为1
		clk = 0;
      rst_n = 1;
      //在第4ns时：设置重置信号为0（以产生下降沿，系统会在此下降沿时刻重置）
      #4
      rst_n = 0;
      //在第8ns时：设置重置信号为1，同时开始对系统输入数据
      #4
      rst_n = 1;

      data_in_tb <= 6'd0;
      #20
      data_in_tb <= 6'd1;
      #20
      data_in_tb <= 6'd2;
      #20
      data_in_tb <= 6'd3;
      #20
      data_in_tb <= 6'd4;
      #20
      data_in_tb <= 6'd5;
      #20
      data_in_tb <= 6'd6;
      #20
      data_in_tb <= 6'd7;
      #20
      data_in_tb <= 6'd8;
      #20
      data_in_tb <= 6'd9;
      #20
      data_in_tb <= 6'd10;
      #20
      data_in_tb <= 6'd11;
      #20
      data_in_tb <= 6'd12;
      #20
      data_in_tb <= 6'd13;
      #20
      data_in_tb <= 6'd14;
      #20
      data_in_tb <= 6'd15;
      #20
      data_in_tb <= 6'd16;
      #20
      data_in_tb <= 6'd17;
      #20
      data_in_tb <= 6'd18;
      #20
      data_in_tb <= 6'd19;
      #20
      data_in_tb <= 6'd20;
      #20
      data_in_tb <= 6'd21;
      #20
      data_in_tb <= 6'd22;
      #20
      data_in_tb <= 6'd23;
      #20
      data_in_tb <= 6'd24;
      #20
      data_in_tb <= 6'd25;
      #20
      data_in_tb <= 6'd26;
      #20
      data_in_tb <= 6'd27;
      #20
      data_in_tb <= 6'd28;
      #20
      data_in_tb <= 6'd29;
      #20
      data_in_tb <= 6'd30;
      #20
      data_in_tb <= 6'd31;
      #20
      data_in_tb <= 6'd32;
      #20
      data_in_tb <= 6'd33;
      #20
      data_in_tb <= 6'd34;
      #20
      data_in_tb <= 6'd35;
      #20
      data_in_tb <= 6'd36;
      #20
      data_in_tb <= 6'd37;
      #20
      data_in_tb <= 6'd38;
      #20
      data_in_tb <= 6'd39;
      #20
      data_in_tb <= 6'd40;
      #20
      data_in_tb <= 6'd41;
      #20
      data_in_tb <= 6'd42;
      #20
      data_in_tb <= 6'd43;
      #20
      data_in_tb <= 6'd44;
      #20
      data_in_tb <= 6'd45;
      #20
      data_in_tb <= 6'd46;
      #20
      data_in_tb <= 6'd47;
      #20
      data_in_tb <= 6'd48;
      #20
      data_in_tb <= 6'd49;
      #20
		//*等500ns
      #500;

		//结束系统的仿真
		$finish(1);
	end

endmodule
