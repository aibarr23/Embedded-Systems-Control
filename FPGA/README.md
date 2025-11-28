# Using ICARUS Verilog

Terminal -> for using Icarus Verilog

first step

```console
iverilog -o filename_tb.vvp filename_tb.v
```

next

```bash
vvp filename_tb.vvp
```

view as logic "analyzer" through gtkwave

```shell
gtkwave
```

$=================

Converting VHDL to verilog

```console
    iverilog -tvhdl -o output_file.vhd input_file.v
```

output_file.vhd: Specifies the name for the generated VHDL file.

input_file.v: Refers to the Verilog source file you wish to convert
