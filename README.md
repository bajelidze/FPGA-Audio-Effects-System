# FPGA Audio Effects System

This is Bachelor's Degree Senior Design project. It implements a digital audio effects system which includes effects:

```
Distortion
Tremolo
Ring Modulation
Echo
Vibrato
Slapback
```

The board used is Terasic DE1-SoC with Intel Cyclone V FPGA. Quartus 18.1 version used.
Input can be received through both Line In and Mic In inputs. Output is forwarded to Line Out.
To switch between Mic In / Line In modify CLOCK_500.sv according to comments and recompile.

```systemverilog
ROM[2] = 16'h0812;	//LINE IN: 0812, MIC IN: 0815
```
