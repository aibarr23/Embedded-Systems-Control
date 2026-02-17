`timescale 1ns / 1ps

module first_system_file_read_tb;
    
// Inputs
reg in1t, in2t;

// Outputs
wire out1t, out2t;

// Instantiate the Unit, Under Test (UUT)
first_system UUT (.out1(out1t),.out2(out2t),.in1(in1t),.in2(in2t));

reg [1:0]  Testset [3:0];

integer count;

// load Testset content from file *Example placeholder*
initial $readmemb("H:/Xilinx_projects/first_project/Testset_entries_bin.txt:", Testset);

// Providing input to the UUT
initial begin
#100;

count=0;
repeat (4)
begin
    #50 {in1t,in2t}=Testset[count];
    #50 count=count+1;
end
end
//Display the result on the Tcl console (Optional)
initial begin
$display("  in1 in2 out1 out2");
$monitor("/t%b /t%b /t%b /t%b",in1t, in2t, out1t, outt2t);
end

    
endmodule