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

