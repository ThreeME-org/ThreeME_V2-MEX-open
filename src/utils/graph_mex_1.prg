delete a_graph*
%list_household = "H01" 	
%list_sec = "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32"
%list_sec_E = "22 23 24 25 26 27 28 29 30 31 32"

%_x = "_2"
%TS = "TS" 
%baseyear = "2008"

      graph a_graph_macro_BL.line(m) 100*@pchy(GDP_0)  100*@pchy(CH_0) 100*@pchy(I_0)  100*@pchy(G_0) _
      100*@pchy(X_0)  100*@pchy(W_0) 100*@pchy(PCH_0) 100*R_0 100*DP_G_VAL_0  100*(DEBT_G_VAL_0/(PGDP_0*GDP_0)) _
      (100*DC_VAL_0/(PGDP_0*GDP_0)) 100*GDP_0/@elem(GDP_0,%baseyear) 100*(-BF_G_VAL_0/(GDP_0*PGDP_0))  _
     100*@pchy(DC_VAL_0/PGDP_0) 100*@pchy(DC_VAL_0) 100*(DC_VAL_0/(GDP_0*PGDP_0))  100*unr_tot_0 _  
     100*@pchy(DEBT_G_VAL_0/PGDP_0) 100*@pchy(DEBT_G_VAL_0) 100*EMS_TOT_0/@elem(EMS_TOT_0,%baseyear) PCH_0 
        show  a_graph_macro_BL


      graph a_graph_macro_2.line(m) 100*@PCHY(GDP_2) 100*@PCHY(Y_2) 100*@PCHY(VA_2) 100*@PCHY(CH_2) 100*@PCHY(G_2) 100*@PCHY(IA_2) _
      100*@PCHY(X_2) 100*@PCHY(M_2) 100*@PCHY(DISPINC_VAL_2/PCH_2) 100*{%TS}_2 100*@PCHY(PCH_2) _
      100*@PCHY(PYQ_2) 100*@PCHY(PX_2) 100*@PCHY(PM_2) 100*@PCHY(W_2/PCH_2) 100*@PCHY(CL_2/PY_2) _
      100*(UNR_TOT_2) 100*@PCHY(L_2) 100*DC_VAL_2/(PGDP_2*GDP_2) -100*DP_G_VAL_2 100*DEBT_G_VAL_2/(PGDP_2*GDP_2) FISC_2 100*r_2
      show  a_graph_macro_2

      graph a_graph_macro_2L.line(m) 100*(GDP_2/GDP_0-1)  100*(CH_2/CH_0-1) 100*(G_2/G_0-1) 100*(IA_2/IA_0-1) _
      100*(X_2/X_0-1) 100*(M_2/M_0-1) 100*(DISPINC_VAL_2/PCH_2/(DISPINC_VAL_0/PCH_0)-1) _
      100*({%TS}_2-{%TS}_0) 100*(PCH_2/PCH_0-1) 100*(PYQ_2/PYQ_0-1) 100*(PX_2/PX_0-1) 100*(PM_2/PM_0-1) _
      100*((W_2/PCH_2)/(W_0/PCH_0)-1) 100*((CL_2/PY_2)/(CL_0/PY_0)-1) L_2-L_0 100*(UNR_TOT_2-UNR_TOT_0) _
      100*(DC_VAL_2/(PGDP_2*GDP_2)-DC_VAL_0/(PGDP_0*GDP_0)) -100*(DP_G_VAL_2-DP_G_VAL_0) 100*(DEBT_G_VAL_2/(PGDP_2*GDP_2)-DEBT_G_VAL_0/(PGDP_0*GDP_0)) (FISC_2-FISC_0) 100*(r_2-r_0)
      show  a_graph_macro_2L



      graph a_graph_macro_test.line(m) 100*@pchy(DEBT_G_VAL_0/PGDP_0) 100*@pchy(DEBT_G_VAL_0) 100*(DEBT_G_VAL_0/(GDP_0*PGDP_0)) 100*(DEBT_G_VAL_2/(GDP_0*PGDP_0)) 100*(DEBT_G_VAL_2/(GDP_2*PGDP_2)) _
      100*@pchy(-BF_G_VAL_0/PGDP_0) 100*@pchy(-BF_G_VAL_0) 100*(-BF_G_VAL_0/(GDP_0*PGDP_0)) 100*(-BF_G_VAL_2/(GDP_0*PGDP_0)) 100*(-BF_G_VAL_2/(GDP_2*PGDP_2)) _
      100*@pchy(DC_VAL_0/PGDP_0) 100*@pchy(DC_VAL_0) 100*(DC_VAL_0/(GDP_0*PGDP_0)) 100*(DC_VAL_2/(GDP_0*PGDP_0)) 100*(DC_VAL_2/(GDP_2*PGDP_2))
      show  a_graph_macro_test
    


     '-----------***Graph EMS***------------------'
       %series = ""
      For %sec {%list_sec}
        if @elem(EMS_SEC_{%sec},%baseyear) <> 0 then
          %series  = %series + " 100*(EMS_SEC_"+%sec+%_x+"/EMS_SEC_"+%sec+"_0-1)"
        endif
      next

      graph a_graph_EMSsec2.line(m)  {%series}
      show a_graph_EMSsec2

     graph a_graph_ems_2V.line(m) 100*EMS_TOT_2/@elem(EMS_TOT_2,%baseyear) 100*EMS_TOT_0/@elem(EMS_TOT_0,%baseyear) 100*EMS_SEC_2/@elem(EMS_SEC_2,%baseyear) 100*EMS_SEC_0/@elem(EMS_SEC_0,%baseyear) _
                                  100*EMS_DC_2/@elem(EMS_DC_2,%baseyear) 100*EMS_DC_0/@elem(EMS_DC_0,%baseyear) 100*EMS_HH_2/@elem(EMS_HH_2,%baseyear) 100*EMS_HH_0/@elem(EMS_HH_0,%baseyear) EMS_TOT_0  EMS_TOT_2
      show  a_graph_ems_2V


