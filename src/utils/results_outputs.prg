subroutine output_template(string %scenario)

  delete(noerr) output_list
  text output_list
  output_list.append(file) .\output_list.txt

  %series_list = ""

  for !i = 1 to output_list.@linecount
    %line = output_list.@line(!i)
    %series_name = @trim(@mid(%line, 1, @instr(%line, "=") - 1))
    %series_formula = @trim(@mid(%line, @instr(%line, "=") + 1))
    if @length(%series_name) > 0 then
      series {%series_name} = {%series_formula}
      %series_list = %series_list + " " + %series_name
    endif
  next

  smpl @all
  group results {%series_list}
  freeze(mode = overwrite, tab_results) results
  tab_results.save(t=txt) .\..\..\results\{%scenario}.txt

endsub


Subroutine standard_outputs(string %grp_name, string %index)

group table_1 100*(GDP_{%index}/GDP_0-1) 100*(VA_18_{%index}/VA_18_0-1) 100*(CH_{%index}/CH_0-1) 100*(IA_{%index}/IA_0-1) 100*((IA_{%index}-IA_19_{%index})/(IA_0-IA_19_0)-1) 100*(X_{%index}/X_0-1) 100*(M_{%index}/M_0-1) 100*(PCH_{%index}/PCH_0-1) 100*(PY_{%index}/PY_0-1) 100*((W_{%index}/PCH_{%index})/(W_0/PCH_0)-1) 100*((CL_{%index}/PVA_{%index})/(CL_0/PVA_0)-1) L_{%index}-L_0 100*(UNR_TOT_{%index}-UNR_TOT_0) 100*((PX_{%index}*X_{%index}-PM_{%index}*M_{%index})/(PGDP_{%index}*GDP_{%index})-(PX_0*X_0-PM_0*M_0)/(PGDP_0*GDP_0)) 100*(Debt_g_val_{%index}/(PGDP_{%index}*GDP_{%index})-Debt_g_val_0 /(PGDP_0*GDP_0)) 100*(DP_G_val_{%index} - DP_G_val_0)  100*(EMS_TOT_{%index}/EMS_TOT_0-1) GDP_0 GDP_2 EN_AGR_20_0  EN_IND_20_0 EN_TRANSP_20_0 EN_SER_20_0  EN_AGR_21_0  EN_IND_21_0 EN_TRANSP_21_0 EN_SER_21_0  EN_AGR_22_0  EN_IND_22_0 EN_TRANSP_22_0 EN_SER_22_0  EN_Gwh_AGR_0  EN_Gwh_IND_0 EN_Gwh_TRANSP_0 EN_Gwh_SER_0 EN_Gwh_HH_22_H01_0  EN_AGR_20_2  EN_IND_20_2 EN_TRANSP_20_2 EN_SER_20_2 EN_AGR_21_2  EN_IND_21_2 EN_TRANSP_21_2 EN_SER_21_2 EN_AGR_22_2  EN_IND_22_2 EN_TRANSP_22_2 EN_SER_22_2 EN_Gwh_AGR_2  EN_Gwh_IND_2 EN_Gwh_TRANSP_2 EN_Gwh_SER_2 EN_Gwh_HH_22_H01_2 EN_CONFIN_TOT_0 EN_CONFIN_TOT_2 EN_Gwh_CONFIN_0 EN_Gwh_CONFIN_2 EN_HH_20_0 EN_HH_21_0 EN_HH_22_0 EN_HH_20_2 EN_HH_21_2 EN_HH_22_2 EN_AGR_0 EN_IND_0 EN_TRANSP_0 EN_SER_0 EN_TRANSFOR_0 EN_GENER_0 EN_AGR_2 EN_IND_2 EN_TRANSP_2 EN_SER_2 EN_TRANSFOR_2 EN_GENER_2 EN_HH_0 EN_HH_2 EMS_AGR_0  EMS_IND_0 EMS_TRANSP_0 EMS_SER_0 EMS_TRANSFOR_0 EMS_GENER_0 EMS_HH_0 EMS_AGR_2 EMS_IND_2 EMS_TRANSP_2 EMS_SER_2 EMS_TRANSFOR_2 EMS_GENER_2 EMS_HH_2 EN_SEC_22_0 EN_SEC_23_0 EN_SEC_24_0 EN_SEC_25_0 EN_SEC_26_0 EN_SEC_27_0 EN_SEC_28_0 EN_SEC_29_0 EN_SEC_30_0 EN_SEC_31_0 EN_SEC_32_0 EN_SEC_33_0 EMS_SEC_22_0 EMS_SEC_23_0 EMS_SEC_24_0 EMS_SEC_25_0 EMS_SEC_26_0 EMS_SEC_27_0 EMS_SEC_28_0  EMS_SEC_29_0 EMS_SEC_30_0 EMS_SEC_31_0 EMS_SEC_32_0 EMS_SEC_33_0 EN_CONFIN_22_22_0 EN_CONFIN_22_23_0 EN_CONFIN_22_24_0 EN_CONFIN_22_25_0 EN_CONFIN_22_26_0 EN_CONFIN_22_27_0 EN_CONFIN_22_28_0 EN_CONFIN_22_29_0 EN_CONFIN_22_30_0 EN_CONFIN_22_31_0 EN_CONFIN_22_32_0 EN_CONFIN_22_33_0 EN_CONFIN_22_22_2 EN_CONFIN_22_23_2 EN_CONFIN_22_24_2 EN_CONFIN_22_25_2 EN_CONFIN_22_26_2 EN_CONFIN_22_27_2 EN_CONFIN_22_28_2 EN_CONFIN_22_29_2 EN_CONFIN_22_30_2 EN_CONFIN_22_31_2 EN_CONFIN_22_32_2 EN_CONFIN_22_33_2

Table_1.sheet(t)
show Table_1

group Table_2 L_01_0 L_02_0 L_03_0 L_04_0 L_05_0  L_06_0 L_07_0 L_08_0  L_09_0  L_10_0  L_11_0  L_12_0  L_13_0  L_14_0  L_15_0  L_16_0  L_17_0  L_18_0  L_19_0  L_20_0  L_21_0  L_22_0  L_23_0  L_24_0  L_25_0  L_26_0  L_27_0  L_28_0  L_29_0  L_30_0  L_31_0  L_32_0  L_33_0 L_01_2  L_02_2  L_03_2  L_04_2  L_05_2  L_06_2  L_07_2  L_08_2  L_09_2  L_10_2  L_11_2  L_12_2  L_13_2  L_14_2  L_15_2  L_16_2  L_17_2  L_18_2  L_19_2  L_20_2  L_21_2  L_22_2  L_23_2  L_24_2  L_25_2  L_26_2  L_27_2  L_28_2  L_29_2  L_30_2  L_31_2  L_32_2  L_33_2 IA_01_0 IA_02_0 IA_03_0 IA_04_0 IA_05_0 IA_06_0 IA_07_0 IA_08_0 IA_09_0 IA_10_0 IA_11_0 IA_12_0 IA_13_0 IA_14_0 IA_15_0 IA_16_0 IA_17_0 IA_18_0 IA_19_0 IA_20_0 IA_21_0 IA_22_0 IA_23_0 IA_24_0 IA_25_0 IA_26_0 IA_27_0 IA_28_0 IA_29_0 IA_30_0 IA_31_0 IA_32_0 IA_33_0 IA_01_2 IA_02_2 IA_03_2 IA_04_2 IA_05_2 IA_06_2 IA_07_2 IA_08_2 IA_09_2 IA_10_2 IA_11_2 IA_12_2 IA_13_2 IA_14_2 IA_15_2 IA_16_2 IA_17_2 IA_18_2 IA_19_2 IA_20_2 IA_21_2 IA_22_2 IA_23_2 IA_24_2 IA_25_2 IA_26_2 IA_27_2 IA_28_2 IA_29_2 IA_30_2 IA_31_2 IA_32_2 IA_33_2 CH_01_0 CH_02_0 CH_03_0 CH_04_0 CH_05_0 CH_06_0 CH_08_0 CH_11_0 CH_12_0 CH_13_0 CH_14_0 CH_15_0 CH_16_0 CH_17_0 CH_18_0 CH_19_0 CH_20_0 CH_21_0 CH_22_0 CH_01_2 CH_02_2 CH_03_2 CH_04_2 CH_05_2 CH_06_2 CH_08_2 CH_11_2 CH_12_2 CH_13_2 CH_14_2 CH_15_2 CH_16_2 CH_17_2 CH_18_2 CH_19_2 CH_20_2 CH_21_2 CH_22_2

Table_2.sheet(t)
show Table_2

endsub







subroutine additional_outputs

  smpl @all


  if %save = "yes" and %tabopt = "MEXIQUE" then


    %tablename = "tab_macro_2"
    freeze(mode = overwrite, {%tablename}) a_{%tablename}
    show  {%tablename}

    shell if not exist output_{%DC} mkdir output_{%DC}  ' Windows create the output folder if it does not exist
    {%tablename}.save(t=txt) output_{%DC}\{%tablename}_{%DS}.xls

    shell if not exist output_graphs mkdir output_graphs  ' Windows create the output folder if it does not exist

    %tablename_1 = "tab_SEC"
    freeze(mode = overwrite, {%tablename_1}) a_{%tablename_1}
    'show  {%tablename_1}

    shell if not exist output_{%DC} mkdir output_{%DC}  ' Windows create the output folder if it does not exist
    {%tablename_1}.save(t=txt) output_{%DC}\{%tablename_1}_{%DS}.xls

    shell if not exist output_graphs mkdir output_graphs  ' Windows create the output folder if it does not exist

    for %format png 'jpg 'bmp gif
      a_graph_macro_2.setupdate(manual) @all
      a_graph_macro_2.update
      a_graph_macro_2.save(t={%format}, d=500)  output_graphs\allsmpl_graph_macro_2_{%DS}_{%DC} ' Save graph; t=format; d=nb of dots per inch

      if {%lastdate}>{%lastdate_graph} then
        a_graph_macro_2.setupdate(manual) @first {%lastdate_graph}
        a_graph_macro_2.update
        a_graph_macro_2.save(t={%format}, d=500)  output_graphs\{%lastdate_graph}_graph_macro_2_{%DS}_{%DC}  ' Save graph; t=format; d=nb of dots per inch
      endif
    next

    'for %format png 'jpg 'bmp gif                                                                                  ' Save graph; t=format; d=nb of dots per inch
    'a_graph_production2.setupdate(manual) @all
    'a_graph_production2.update
    'a_graph_production2.save(t={%format}, d=500)  output_graphs\allsmpl_graph_production2_{%DS}_{%DC}
    'if {%lastdate}>{%lastdate_graph} then
    'a_graph_production2.setupdate(manual) @first {%lastdate_graph}
    'a_graph_production2.update
    'a_graph_production2.save(t={%format}, d=500)  output_graphs\{%lastdate_graph}_graph_production2_{%DS}_{%DC}                                                                                      ' Save graph; t=format; d=nb of dots per inch
    'endif
    'next

  endif  

endsub




' ************************************** TABLES  SUBROUTINE MEXIQUE  *******************************************
' **************************************************************************************************************
' This subroutine makes tables for selected variables 
 subroutine tables(string %tabopt)
 
  if %tabopt="MEXIQUE" then
    if !scenario = 2 and %block_all="yes" then
      %_x = "_2"    'Scenario to be plotted: "_0" for baseline "_2" for shock

      '-----------***Table MACRO***------------------'

      group a_tab_macro_2  100*(GDP_2/GDP_0-1) 100*((VA_2-VA_20_2)/(VA_0-VA_20_0)-1) 100*(CH_2/CH_0-1) 100*(IA_2/IA_0-1) _
      100*(IA_19_2/IA_19_0-1) 100*(X_2/X_0-1) 100*(M_2/M_0-1) 100*(DISPINC_VAL_2/PCH_2/(DISPINC_VAL_0/PCH_0)-1) _
      100*(TS_2-TS_0) 100*(PCH_2/PCH_0-1) 100*(PYQ_2/PYQ_0-1) 100*(PX_2/PX_0-1) 100*(PM_2/PM_0-1) _
      100*((W_2/PCH_2)/(W_0/PCH_0)-1) 100*((CL_2/PY_2)/(CL_0/PY_0)-1) L_2-L_0 100*(UNR_TOT_2-UNR_TOT_0) _
      100*(DC_VAL_2/(PGDP_2*GDP_2)-DC_VAL_0/(PGDP_0*GDP_0)) 100*(DP_SP_G_VAL_2-DP_SP_G_VAL_0) 100*(BF_G_VAL_2/(PGDP_2*GDP_2)-BF_G_VAL_0/(PGDP_0*GDP_0)) 100*(DEBT_G_VAL_2/(PGDP_2*GDP_2)-DEBT_G_VAL_0/(PGDP_0*GDP_0)) _
      100*(GDP_2/@elem(GDP_2,"2008")) 100*(EMS_TOT_2/EMS_TOT_0-1) 100*(EMS_SEC_2/EMS_SEC_0-1) 100*(EMS_HH_2/EMS_HH_0-1) 100*(EMS_TOT_2/@elem(EMS_TOT_2,"2008")) _
      1000000*Ttco_2 (rec_tco_val_2- Rec_Tco_val_0) _
      GDP_2 GDP_0 (VA_2-VA_20_2) (VA_0-VA_20_0)   CH_2 Ch_0 IA_2 IA_0 _
      IA_19_2 IA_19_0 X_2 X_0 M_2 M_0 (DISPINC_VAL_2/PCH_2) (DISPINC_VAL_0/PCH_0) _
      TS_2 TS_0 PCH_2 PCH_0 PYQ_2 PYQ_0 PX_2 PX_0 PM_2 PM_0 _
      (W_2/PCH_2) (W_0/PCH_0) (CL_2/PY_2) (CL_0/PY_0) L_2 L_0 UNR_TOT_2 UNR_TOT_0 _
      100*(DC_VAL_2/(PGDP_2*GDP_2)) 100*(DC_VAL_0/(PGDP_0*GDP_0)) DP_SP_G_VAL_2 DP_SP_G_VAL_0 100*(DEBT_G_VAL_2/(PGDP_2*GDP_2)) 100*(DEBT_G_VAL_0/(PGDP_0*GDP_0)) _
      100*(-BF_G_VAL_2/(PGDP_2*GDP_2)) 100*(-BF_G_VAL_0/(PGDP_0*GDP_0)) EMS_TOT_2 EMS_TOT_0 EMS_SEC_2 EMS_SEC_0 EMS_HH_2 EMS_HH_0 PQ_22_2 PQ_22_0 PQ_23_2 PQ_23_0 _
      PQ_24_2 PQ_24_0 Q_22_2 Q_22_0 Q_23_2 Q_23_0 Q_24_2 Q_24_0 X_22_2 X_22_0 X_23_2 X_23_0 X_24_2 X_24_0 G_2 G_0 DS_2 DS_0 Ttco_base*1000000 100*(REC_TCO_VAL_2/(PGDP_2*GDP_2)-REC_TCO_VAL_0/(PGDP_0*GDP_0)) _
      100*(TCO_VAL_SEC_2/(PGDP_2*GDP_2)-TCO_VAL_SEC_0/(PGDP_0*GDP_0)) 100*(TCO_VAL_HH_2/(PGDP_2*GDP_2)-TCO_VAL_HH_0/(PGDP_0*GDP_0)) (TCO_VAL_SEC_2-TCO_VAL_SEC_0) (TCO_VAL_HH_2-TCO_VAL_HH_0) CHM_2 CHM_0 _
      CHD_0 CHD_2 100*(EMS_TOT_0/@ELEM(EMS_TOT_0,"2008")) 100*(GDP_0/@ELEM(GDP_0,"2008"))((REC_TCO_VAL_2/PGDP_2)-(REC_TCO_VAL_0/PGDP_0))
       show a_tab_macro_2

       '-----------***Table Employment**------------------'
      %series = ""
      For %sec {%list_sec}        
                    
        %series  = %series + "L_"+%sec+"_0 "       
         
        %series  = %series + "L_"+%sec+"_2 "+"L_"+%sec+"_2-L_"+%sec+"_0 " 
                       
        %series  =%series  + "(L_"+%sec+"_2/L_"+%sec+"_0 -1) " 
         
      next

      group a_tab_emploi_sec {%series}
      show a_tab_emploi_sec
      
       '-----------***Table Investissement  S***------------------'     
      %series = ""
      For %sec {%list_sec}
      
        if @elem(IA_{%sec},%baseyear) <> 0 then
          %series  =%series + "IA_"+%sec+"_0 "
        endif
        
        if @elem(IA_{%sec},%baseyear) <> 0 then
          %series  =%series + "IA_"+%sec+"_2 "+"IA_"+%sec+"_2-IA_"+%sec+"_0 "
        endif   
        
        if @elem(IA_{%sec},%baseyear) <> 0 then
          %series  =%series  + "(IA_"+%sec+"_2/IA_"+%sec+"_0 -1) " 
        endif      
        
      next      

      group a_tab_Inv_sec {%series}
      'show a_tab_Inv_sec
      
      
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

       '-----------***Table Emissions SEC and HH **------------------'
      %series = ""
      For %sec {%list_sec}        
            
        %series  = %series + "EMS_SEC_"+%sec+"_0 "       
         
        %series  = %series + "EMS_SEC_"+%sec+"_2 "+"EMS_SEC_"+%sec+"_2-EMS_SEC_"+%sec+"_0 " 
                       
        %series  =%series  + "(EMS_SEC_"+%sec+"_2/EMS_SEC_"+%sec+"_0 -1) " 
       
      next

        %series  = %series + "EMS_HH_0 " + "EMS_HH_2 " + "(EMS_HH_2 - EMS_HH_0)" + "(EMS_HH_2/EMS_HH_0 - 1)" 
        %series  = %series + "EMS_HH_23_0 " + "EMS_HH_23_2 " + "(EMS_HH_23_2 - EMS_HH_23_0)" + "(EMS_HH_23_2/EMS_HH_23_0 - 1)"   
        %series  = %series + "EMS_HH_22_0 " + "EMS_HH_22_2 " + "(EMS_HH_22_2 - EMS_HH_22_0)" + "(EMS_HH_22_2/EMS_HH_22_0 - 1)"   
        %series  = %series + "EMS_SOU_23_0 " + "EMS_SOU_23_2 " + "(EMS_SOU_23_2 - EMS_SOU_23_0)" + "(EMS_SOU_23_2/EMS_SOU_23_0 - 1)"   
        %series  = %series + "EMS_SOU_22_0 " + "EMS_SOU_22_2 " + "(EMS_SOU_22_2 - EMS_SOU_22_0)" + "(EMS_SOU_22_2/EMS_SOU_22_0 - 1)"   
        

     group a_tab_EMS {%series}
    'show a_tab_E_sec      
      
      '-----------***table SEC***------------------'
    group a_tab_SEC  a_tab_emploi_sec a_tab_Inv_sec a_tab_E_sec a_tab_EMS
    show a_tab_SEC
    
    endif
  endif

endsub


' ************************************** END TABLE SUBROUTINE  *************************************************
' **************************************************************************************************************


' ************************************** GRAPH  SUBROUTINE MEXIQUE *********************************************
' **************************************************************************************************************
' This subroutine makes graph for selected variables
subroutine graph(string %graphopt)

  if %graphopt="MEXIQUE" then
  
      if !scenario = 2 and %block_all="yes" then
      %_x = "_2"    'Scenario to be plotted: "_0" for baseline "_2" for shock

      graph a_graph_macro_2.line(m) 100*(GDP_2/GDP_0-1) 100*((VA_2-VA_20_2)/(VA_0-VA_20_0)-1) 100*(CH_2/CH_0-1) 100*(G_2/G_0-1) 100*(IA_2/IA_0-1) _
      100*(IA_19_2/IA_19_0-1) 100*(X_2/X_0-1) 100*(M_2/M_0-1) 100*(DISPINC_VAL_2/PCH_2/(DISPINC_VAL_0/PCH_0)-1) _
      100*(PCH_2/PCH_0-1) 100*(PYQ_2/PYQ_0-1) 100*(PX_2/PX_0-1) 100*(PM_2/PM_0-1) _
      100*((W_2/PCH_2)/(W_0/PCH_0)-1) 100*(W_2/W_0-1) 100*((CL_2/PY_2)/(CL_0/PY_0)-1) L_2-L_0 100*(UNR_TOT_2-UNR_TOT_0) _
      100*(DC_VAL_2/(PGDP_2*GDP_2)-DC_VAL_0/(PGDP_0*GDP_0)) 100*(DEBT_G_VAL_2/(PGDP_2*GDP_2)-DEBT_G_VAL_0/(PGDP_0*GDP_0)) (FISC_2-FISC_0) 100*(r_2-r_0) _    
      100*(BF_G_VAL_2/(PGDP_2*GDP_2)-BF_G_VAL_0/(PGDP_0*GDP_0)) 100*(EMS_TOT_2/@elem(EMS_TOT_2,"2008")) 100*(EMS_TOT_2/EMS_TOT_0-1)
      show  a_graph_macro_2                                        
      
      'graph a_graph_GDP.line(e) 100*(GDP_2/GDP_0-1) 100*(GD_2/GD_0-1) 100*(CHD_2/CHD_0-1) 100*(CID_2/CID_0-1) 100*(XD_2/XD_0-1) 100*(ID_2/ID_0-1) 100*(M_2/M_0-1)    
      'show a_graph_GDP
      
      'graph a_graph_PRICE.line(e) 100*(PCH_2/PCH_0-1) 100*((W_2/PCH_2)/(W_0/PCH_0)-1) 100*(W_2/W_2-1)
      'show a_graph_PRICE
      

      endif
  endif

endsub

' ***************************************** END GRAPH  SUBROUTINE **********************************************
' **************************************************************************************************************