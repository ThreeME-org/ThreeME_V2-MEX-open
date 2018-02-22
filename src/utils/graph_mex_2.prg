delete a_graph*
%list_household = "H01" 	
%list_sec = "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32"
%list_sec_E = "22 23 24 25 26 27 28 29 30 31 32"

%_x = "_2"
%TS = "TS" 
%baseyear = "2008"



           '-----------***Table Investissement  S***------------------'     
      %series = ""
      For %sec {%list_sec}
 
            
                   
        if @elem(IA_{%sec},%baseyear) <> 0 then
          %series  =%series  + "(IA_"+%sec+"_2/IA_"+%sec+"_0 -1) " 
        endif       
        
      next      
group a_tab_IA_sec {%series}
'show a_tab_IA_sec

       '-----------***Table Employment**------------------'
      %series = ""
      For %sec {%list_sec}        
                    
        %series  = %series + "L_"+%sec+"_0 "       
         
        %series  = %series + "L_"+%sec+"_2 "+"L_"+%sec+"_2-L_"+%sec+"_0 " 
                       
        %series  =%series  + "(L_"+%sec+"_2/L_"+%sec+"_0 -1) " 
         
      next

group a_tab_L_sec {%series}
'show a_tab_L_sec

       '-----------***Table energy consumption **------------------'
      %series = ""
      For %sec {%list_sec}        

        if @elem(E_{%sec},%baseyear) <> 0 then              
        %series  = %series + "E_"+%sec+"_0 "       
         
        %series  = %series + "E_"+%sec+"_2 "+"E_"+%sec+"_2-E_"+%sec+"_0 " 
                       
        %series  =%series  + "(E_"+%sec+"_2/E_"+%sec+"_0 -1) " 
        endif 

      next

group a_tab_E_sec {%series}
'show a_tab_E_sec

       '-----------***Table Emissions SEC **------------------'
      %series = ""
      For %sec {%list_sec}        
            
        %series  = %series + "EMS_SEC_"+%sec+"_0 "       
         
        %series  = %series + "EMS_SEC_"+%sec+"_2 "+"EMS_SEC_"+%sec+"_2-EMS_SEC_"+%sec+"_0 " 
                       
        %series  =%series  + "(EMS_SEC_"+%sec+"_2/EMS_SEC_"+%sec+"_0 -1) " 
       
      next
      
group a_tab_EMS_sec {%series}
'show a_tab_E_sec
       '-----------***Table Emissions HH**------------------'
     
     Group a_tab_EMS_HH  EMS_HH_0 EMS_HH_2  (EMS_HH_2 - EMS_HH_0) (EMS_HH_2/EMS_HH_0 - 1) _
      EMS_HH_23_0 EMS_HH_23_2 (EMS_HH_23_2 - EMS_HH_23_0) (EMS_HH_23_2/EMS_HH_23_0 - 1) _   
      EMS_HH_22_0 EMS_HH_22_2 (EMS_HH_22_2 - EMS_HH_22_0) (EMS_HH_22_2/EMS_HH_22_0 - 1) _   
      EMS_SOU_23_0 EMS_SOU_23_2 (EMS_SOU_23_2 - EMS_SOU_23_0) (EMS_SOU_23_2/EMS_SOU_23_0 - 1) _   
      EMS_SOU_22_0  EMS_SOU_22_2 (EMS_SOU_22_2 - EMS_SOU_22_0) (EMS_SOU_22_2/EMS_SOU_22_0 - 1)  


group a_tab_sector a_tab_IA_sec a_tab_L_sec a_tab_E_sec a_tab_EMS_sec  a_tab_EMS_HH
Show a_tab_sector


