
//********** inputs and outputs ports decleration *************//

module cache_controller (

  input   wire         clk,
  input   wire         rst,
  input   wire         MemRead, MemWrite, ready,
  input   wire [2:0]   tag,
  input   wire [4:0]   index,
  output  reg          refill,update,
  output  reg          write,read,    
  output  reg          stall,cache_read   
);

reg hit;
integer i ; 

//********** FSM Encoding ************//

localparam      idle      = 2'b00,
                reading   = 2'b01,
                writing   = 2'b11;
                
//********** internal signal ************//

reg   [1:0]     current_state, next_state;

reg             valid_bit [0:31];
reg   [2:0]     cache_tag [0:31];

//********** Active Low Asynchronous Rest and State transition ************//

always @(negedge clk or posedge rst)
 begin
  if(rst)
   begin
     current_state <= idle ;
   end
  else
   begin
     current_state <= next_state ;
   end
end

 
 //********** Next State Logic ************//
 
 
always @ (*)
  begin
    case(current_state)
     idle:   begin
            if( MemRead && !hit)
              begin
              next_state = reading;
              end
            else if(MemWrite)
              begin
              next_state = writing;
              end
            else
              begin
              next_state = idle;
              end
            end
    reading: begin
            if(ready)
              begin
              next_state = idle;
              end
            else
              begin
              next_state = reading;
              end
            end
    writing: begin
            if(ready)
              begin
              next_state = idle;
              end
            else
              begin
              next_state = writing;
              end
            end
    default: begin
              next_state = idle;
            end         
           
  endcase
end
  
  //********** Output Logic ************//
  
always @(*)
 begin

   case (current_state)
   idle     :  begin
               stall    = 1'b0;
               write    = 1'b0;
               read     = 1'b0;
               update   = 1'b0;
               refill   = 1'b0;
			   if (hit && MemRead)
					cache_read = 1'b1;
			   else
					cache_read = 1'b0;
               end
   reading  :  begin
               stall    = 1'b1;
               write    = 1'b0;
               read     = 1'b1;
               update   = 1'b0;
               refill   = 1'b1;
			   cache_read = 1'b0;
               end
   writing  :  begin
			  cache_read = 1'b0;
              if (hit)
              begin
               stall    = 1'b1;
               write    = 1'b1;
               read     = 1'b0;
               update   = 1'b1;
               refill   = 1'b0;
               end
               else
               begin
               stall    = 1'b1;
               write    = 1'b1;
               read     = 1'b0;
               update   = 1'b0;
               refill   = 1'b0;
               end
             end
   default  :  begin
               stall    = 1'b0;
               write    = 1'b0;
               read     = 1'b0;
               update   = 1'b0;
               refill   = 1'b0;
			   cache_read = 1'b0;
               end  
   endcase
   
 end

//********** Hit Signal Calculation ************//

//always @(posedge clk or posedge rst) begin
always @(*) begin
  /*if (!rst) 
  begin
    hit <= 1'b0;
  end */
  if (valid_bit[index] && cache_tag[index] == tag) 
  begin
      hit <= 1'b1;
    end 
  else 
  begin
      hit <= 1'b0;
    end
end



//********** Cache Tag and Valid Bit Assignment ************//

always @(negedge clk or posedge rst) 
begin
  if (rst) 
  begin
  for (i = 0 ; i < 32 ; i = i +1)
  begin
    valid_bit [i] <= 1'b0;
    cache_tag [i] <= 3'b0;
  end
  end 
  else if (!hit && ready && MemRead)  /////////////////////////////////////////
  begin
    valid_bit[index] <= 1'b1;
    cache_tag[index] <= tag;
end 

end

endmodule                          