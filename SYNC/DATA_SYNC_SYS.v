module DATA_SYNC_SYS #(parameter DATA_WIDTH=8)
      (
         input   wire                     CLK,
         input   wire                     RST,
         input   wire                     bus_enable,
         input   wire  [DATA_WIDTH-1:0]   unsync_bus,

         output  reg   [DATA_WIDTH-1:0]   sync_bus,
         output  reg                      enable_pulse
      );

//internal connections
reg                     meta_flop   ,
                        sync_flop   ,
                        enable_flop ;
					 
wire                    en_pulse ;

wire  [DATA_WIDTH-1:0]   sync_bus_c ;
					 
//----------------- double flop synchronizer --------------

always @(posedge CLK or negedge RST)
 begin
  if(!RST)      // active low
   begin
    meta_flop <= 1'b0 ;
    sync_flop <= 1'b0 ;	
   end
  else
   begin
    meta_flop <= bus_enable;
    sync_flop <= meta_flop ;
   end  
 end
 

//----------------- pulse generator --------------------

always @(posedge CLK or negedge RST)
 begin
  if(!RST)      // active low
   begin
    enable_flop <= 1'b0 ;	
   end
  else
   begin
    enable_flop <= sync_flop ;
   end  
 end

 
assign en_pulse = sync_flop && !enable_flop ;


//----------------- multiplexing --------------------

assign sync_bus_c =  en_pulse ? unsync_bus : sync_bus ;  


//----------- destination domain flop ---------------

always @(posedge CLK or negedge RST)
 begin
  if(!RST)      // active low
   begin
    sync_bus <= 'b0 ;	
   end
  else
   begin
    sync_bus <= sync_bus_c ;
   end  
 end
 
//--------------- delay generated pulse ------------

always @(posedge CLK or negedge RST)
 begin
  if(!RST)      // active low
   begin
    enable_pulse <= 1'b0 ;	
   end
  else
   begin
    enable_pulse <= en_pulse ;
   end  
 end
 

endmodule