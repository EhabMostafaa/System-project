module REG_FILE_SYS #(parameter ADDRESS_WIDTH=4 , DATA_SIZE=8 , DEPTH=16)
     (  input  wire                         CLK,
        input  wire                         RST,
        input  wire  [ADDRESS_WIDTH-1:0]    Address,
        input  wire                         WrEn,
        input  wire                         RdEn,
        input  wire  [DATA_SIZE-1:0]        WrData,

        output reg   [DATA_SIZE-1:0]        RdData,
        output reg                          RdData_Valid,
        output wire  [DATA_SIZE-1:0]        REG0,       
        output wire  [DATA_SIZE-1:0]        REG1,       
        output wire  [DATA_SIZE-1:0]        REG2,       
        output wire  [DATA_SIZE-1:0]        REG3       
             );


reg [DATA_SIZE-1:0] reg_file [DEPTH-1:0];
integer i;

 always @(posedge CLK or negedge RST ) 
  begin
     RdData_Valid<='b0;
     RdData<='b0;

    if(!RST)
       begin
       for (i =0 ; i<DEPTH ; i=i+1 ) 
       begin
        if(i==2)
             begin
               reg_file[i]<='b001000_01;        // parity enable=1  parity=1 (odd parity)
             end  
        
        else if(i==3)
              begin
               reg_file[i]<='b0000_1000;
              end  

        else 
              begin
               reg_file[i]<='b0;
              end      
       end 
       end

    else if (WrEn && !RdEn)
      begin
       reg_file[Address]<=WrData;   
      end 
     
    else if (RdEn && ! WrEn)
      begin
          RdData<=reg_file[Address];
          RdData_Valid<='b1;
      end

    else
      begin
          RdData_Valid<='b0;
      end
  end

assign REG0 = reg_file[0];
assign REG1 = reg_file[1];
assign REG2 = reg_file[2];
assign REG3 = reg_file[3];

endmodule