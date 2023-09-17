# RISC-V Processor with Data Cache Memory System
## Introduction:
I have designed and implemented a Single Cycle 32-bit RISC-V processor with an integrated data cache memory system. This project involved in-depth exploration of the RISC-V instruction set architecture (ISA) and its principles, as well as the design and construction of a fully functional processor. My RISC-V processor supports integer instructions only (RV32I).
## Objective:
Referring to the figure below. I have written the RTL Verilog files for all submodules of the RISC-V processor (e.g. Contol Unit, Instruction Memory, ALU, etc.). Then, implemented the top module of the RISC-V processor.
![riscv](https://github.com/mo2men3la2/RISC-V-Processor-with-Data-Cache-Memory-System/assets/54054905/c230a034-a2ad-4ddb-969c-248a1f11dea1)
## Data Cache Memory View:
  ● Only data memory will be cached. The instruction memory will not be affected.  
  ● We will have only one level of caching.  
  ● The main memory module is assumed to have a capacity of 4 Kbytes (word addressable using 10 bits or 
    byte addressable using 12 bits).  
  ● Main memory access (for read or write) takes 4 clock cycles.  
  ● The data cache geometry is (512, 16, 1). This means that the total cache capacity is 512 bytes, that each 
    cache block is 16 bytes (implying that the cache has 32 blocks in total), and that the cache uses direct 
    mapping.  
  ● The cache uses write-through and write-around policies for write hit and write miss handling and no 
    write buffers exist. This implies that all SW instructions need to stall the processor.  
  ● LW instructions will only stall the processor in case of a miss.  
### Cache Memory Specs:
  • Associativity: Direct mapping.  
  • Cache Size: 512 bytes.  
  • Block Size: 16 bytes.  
  • Address Size: 10 bits.  
  • offset: 2 bits.  
  • Index: 5 bits.  
  • Tag: 3 bits.  
  • Valid: 1 bit.  
  ![WhatsApp Image 2023-09-04 at 22 35 23](https://github.com/mo2men3la2/RISC-V-Processor-with-Data-Cache-Memory-System/assets/54054905/16c9d938-41bb-435a-a854-381842b36d1b)
## Simulation & Results
● To test the functionality of the whole processor I worte an assembly program that covers all scenarios of storing and loading from the Data Memory. After that, I preloaded the Instruction Memory with the machine code of my assembly program. Using my designed testbench, I have verified the functionality of my design:  
| Assembly Instruction   | Function             | Machine Code |
| ---------------------- | -------------------- | ------------ |
| / addi x0, x0, 0 /     | # x0 = 0             | 0x00000013   |
| / addi x1, x0, 1 /     | # x1 = 1             | 0x00100093   |
| / addi x2, x0, 2 /     | # x2 = 2             | 0x00200113   |
| / addi x3, x0, 3 /     | # x3 = 3             | 0x00300193   |
| / addi x4, x0, 0x457 / | # x4 = 32’h00000457  | 0x45700213   |
| / addi x5, x0, 0xfffff8ae / | # x5 = 32’hfffff8ae | 0x8ae00293 |
| / addi x6, x0, 0xfffffd05 / | # x6 = 32’hfffffd05 | 0xd0500313 |
| / addi x7, x0, 0x15c / | # x7 = 32’h0000015c   | 0x15c00393   |
| / sw x4, 0(x0) /       | # [0] = 00000457     | 0x00402023   |
| / sw x5, 0(x1) /       | # [1] = fffff8ae     | 0x0050a023   |
| / sw x6, 0(x2) /       | # [2] = fffffd05     | 0x00612023   |
| / sw x7, 0(x3) /       | # [3] = 0000015c     | 0x0071a023   |
| / lw x8, 0(x0) /       | # x8 = [0] = 00000457 | 0x00002403   |
| / lw x9, 0(x1) /       | # x9 = [1] = fffff8ae | 0x0000a483   |
| / lw x10, 0(x2) /      | # x10 = [2] = fffffd05 | 0x00012503   |
| / lw x11, 0(x3) /      | # x11 = [3] = 0000015c | 0x0001a583   |
| / sw x9, 0(x0) /       | # [0] = fffff8ae     | 0x00902023   |
| / lw x12, 0(x0) /      | # x11 = [0] = fffff8ae | 0x00002603   |
| / sw x12, 50(x0) /     | # [50] = fffff8ae    | 0x02c02923   |  

![image](https://github.com/mo2men3la2/RISC-V-Processor-with-Data-Cache-Memory-System/assets/54054905/13846334-9e08-4dd9-9ac6-7c02515438c7)

## Note:
The Machine code that is loaded in the Instruction Memory is found in riscvtest.txt 


