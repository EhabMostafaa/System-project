module ALU_SYS #(parameter DATA_WIDTH =8 , ALU_FUNC_WIDTH=4,ALU_OUT_WIDTH=16) 
     (
        input  wire                             CLK,
        input  wire                             RST,
        input  wire    [DATA_WIDTH-1:0]         A,
        input  wire    [DATA_WIDTH-1:0]         B,
        input  wire                             Enable,
        input  wire    [ALU_FUNC_WIDTH-1:0]     ALU_FUNC,

        output reg     [ALU_OUT_WIDTH-1:0]      ALU_OUT,
        output reg                              OUT_VALID
     );


   reg     [ALU_OUT_WIDTH-1:0]         alu_out_comb;

always @(posedge CLK or negedge RST ) 
  begin
   if(!RST)
     begin
       ALU_OUT<='b0;
       OUT_VALID<='b0;
     end

   else if(Enable)
      begin
        ALU_OUT<=alu_out_comb;
        OUT_VALID<='b1;
      end

   else     
      begin
       ALU_OUT<='b0;            //
       OUT_VALID<='b0;
      end  
  end

always@(*)
   begin
     alu_out_comb='b0; 
           case (ALU_FUNC)    
           4'b0000:begin
                    alu_out_comb= A + B ;
                    end          
           4'b0001:begin
                    alu_out_comb= A - B ; 
                    end          
           4'b0010:begin
                    alu_out_comb= A * B ;
                    end          
           4'b0011:begin
                    alu_out_comb= A / B ;
                    end 

           4'b0100:begin
                    alu_out_comb= A & B ;
                    end          
           4'b0101:begin
                    alu_out_comb= A | B ;
                    end          
           4'b0110:begin
                    alu_out_comb= ~( A & B );
                    end          
           4'b0111:begin
                    alu_out_comb= ~( A | B );
                    end          
           4'b1000:begin
                    alu_out_comb= A ^ B ;
                    end          
           4'b1001:begin
                    alu_out_comb= ~( A ^ B );
                    end          

           4'b1010:begin
                      if(A==B)
                    alu_out_comb='b1;
                       else
                    alu_out_comb='b0;   
                     end          
           4'b1011:begin
                      if(A>B)
                    alu_out_comb='b1;
                       else
                    alu_out_comb='b0;   
                    end          
           4'b1100:begin
                       if(A<B)
                    alu_out_comb='b1;
                       else
                    alu_out_comb='b0;   
                   end          

           4'b1101:begin
                    alu_out_comb= A >> 1;
                    end          
                   
           4'b1110:begin
                    alu_out_comb= A << 1;
                    end          
                    
           default:begin
                    alu_out_comb= 'b0;
                   end 
    endcase
   end
endmodule