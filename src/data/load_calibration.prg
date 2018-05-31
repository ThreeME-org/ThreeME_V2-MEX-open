subroutine load_calibration

  ' Load parameter from Excel and store them into a matrix (L,C)

  matrix(150,150) SUPPLY_USE_DOM                                ' Matrix supply use domestic
  SUPPLY_USE_DOM.read(C6,s=SUPPLY_USE_DOM) {%data_calibration}

  matrix(150,150) SUPPLY_USE_FOREIGN                                ' Matrix supply use Foreign
  SUPPLY_USE_FOREIGN.read(C6,s=SUPPLY_USE_FOREIGN) {%data_calibration}

  matrix(50,10) OTH_VARIABLE                            ' Matrix of the data OTHER_VARIABLES
  OTH_VARIABLE.read(C4,s=OTH_VARIABLE) {%data_calibration}

  matrix(150,1) STEADYSTATE                                     ' Matrix of the coefficients of the Steady state rate
  STEADYSTATE.read(B2,s=BaselineHypotheses) {%data_calibration}

  matrix(50,1) NELEMSET                                     ' Matrix of the coefficients of the Steady state rate
  NELEMSET.read(G2,s=BaselineHypotheses) {%data_calibration}

  matrix(100,6) ADJUST                                      ' Matrix of the coefficients of the ajustment processes
  ADJUST.read(C4,s=Adjustment) {%data_calibration}

  matrix(25,41) INV_MAT                                 ' Matrix investment by sector incommodities
  INV_MAT.read(C4,s=INV_MAT)           {%data_calibration}

  matrix(37,7) ES_KLEM                                  ' Matrix of elasticity of substitution (level 1, KLEM)
  ES_KLEM.read(B4,s=ELAS_L1_KLEM)          {%data_calibration}

  matrix(37,6) ES_NRJ                                   ' Matrix of elasticity of substitution (level 2, between type of energy)
  ES_NRJ.read(B4,s=ELAS_L2_NRJ) {%data_calibration}

  matrix(37,24) ES_TRANSP_CI                                 ' Matrix of elasticity of substitution (level 2, between type of transport)
  ES_TRANSP_CI.read(B4,s=ELAS_L2_TRANSPORT) {%data_calibration}

  matrix(24,24) ES_TRANSP_MARG                                   ' Matrix of elasticity of substitution (Level 3, Transport Margins, between type of transport)
  ES_TRANSP_MARG.read(B4,s=ELAS_TRANSP_MARGIN) {%data_calibration}

  matrix(37,24) ES_CIM                                  ' Matrix of elasticity of substitution (level 3, Material between domestic and imported)
  ES_CIM.read(B4,s=ELAS_L3_IMP_DOM) {%data_calibration}

  matrix(37,24) ES_IAM                                  ' Matrix of elasticity of substitution (level 3, Investment allocation between domestic and imported)
  ES_IAM.read(B4,s=ELAS_INVEST) {%data_calibration}

  matrix(70,5) EMISSION                                 ' Matrix of the emssions of GHG by type of source
  EMISSION.read(D3,s=GHG_Emissions) {%data_calibration}

  matrix(70,5)ENERGY                                 ' Matrix of the emssions of GHG by type of source
  ENERGY.read(D3,s=Energy_consumption) {%data_calibration}

  matrix(40,10) DEMOGRAPHY                                  ' Matrix of the emssions of GHG by type of source
  DEMOGRAPHY.read(C3,s=Demography) {%data_calibration}

  matrix(37,7)RHO                                   ' Matrix of the parameters in the wage equation
  RHO.read(D5,s=ELAS_WAGE) {%data_calibration}

  matrix(100,10) household                           ' Matrix of the data household
  household.read(E4,s=household) {%data_calibration}

  matrix(1,1) ES_LES_CES                                ' Matrix of the elasticity of the household's consumption eq.
  ES_LES_CES.read(E1,s=ELAS_OTHER) {%data_calibration}

  matrix(1,11) ES_LVL3_NRJ                              ' Matrix of the parameters in the wage equation
  ES_LVL3_NRJ.read(B6,s=ELAS_OTHER) {%data_calibration}

  matrix(1,19) ES_LVL4_HH                           ' Matrix of the parameters in the wage equation
  ES_LVL4_HH.read(B11,s=ELAS_OTHER) {%data_calibration}

  matrix(1,24) ES_GOV                       ' Matrix of the parameters in the wage equation
  ES_GOV.read(B16,s=ELAS_OTHER) {%data_calibration}

  matrix(24,2) ES_X                     ' Matrix of the parameters in export equation
  ES_X.read(B4,s=ELAS_EXPORT) {%data_calibration}

  call create_series("P",STEADYSTATE(15,1),1)

  !step_1=0
  For %com {%list_com}

    ''      series NELEMSET_verif = (NELEMSET(1,1)+1)+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+10
    call create_series("QD_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+11))
    call create_series("CHD_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+1))
    call create_series("GD_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+2))
    call create_series("ID_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+3))
    call create_series("DSD_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+5))
    call create_series("XD_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+4))

    call create_series ("VATD_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+1))
    call create_series ("OTHTD_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+5))
    call create_series ("SUBD_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+NELEMSET(7,1)))
    call create_series ("ENERTD_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+4))
    call create_series ("VATD_HSH_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+2))
    call create_series ("VATD_OTH_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)+3))
    call create_series("MCD_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)+NELEMSET(5,1)))
    call create_series("YQ_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,(NELEMSET(1,1)+1)))

    call create_series("QM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+11))
    call create_series("CHM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+1))
    call create_series("GM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+2))
    call create_series("IM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+3))
    call create_series("DSM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+5))
    call create_series("XM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+4))
    call create_series("M_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1))


    call create_series ("OTHTM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+5))
    call create_series ("SUBM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+6))
    call create_series ("ENERTM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+4))
    call create_series ("VATM_HSH_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+2))
    call create_series ("VATM_OTH_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+3))
    call create_series("MCM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)))
    call create_series ("VATM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1,1+NELEMSET(5,1)+1))

    !step_1=!step_1+1
  next

  !step_1=0
  For %sec {%list_sec}

    !step_2=0
    For %ci {%list_com}

      call create_series("CID_"+%ci+"_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_2,(NELEMSET(1,1)+1)+NELEMSET(5,1)++NELEMSET(7,1)+1+!step_1))
      call create_series("CIM_"+%ci+"_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_2,1+NELEMSET(5,1)+NELEMSET(7,1)+1+!step_1))

      !step_2=!step_2+1
    next

    !step_1=!step_1+1
  next

  !step_1=0
  For %com {%list_com}

    !step_2=0
    For %sec  {%list_sec}
      call create_series("Y_"+%com+"_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1,1+!step_2))
      !step_2=!step_2+1
    next
    !step_1=!step_1+1
  next

  !step_1=0
  For %com {%list_com}
    !step_2=0
    For %sec  {%list_sec}
      call create_series("PhiY_"+%com+"_"+%sec,0,SUPPLY_USE_DOM(1+!step_1,1+!step_2)/SUPPLY_USE_DOM(1+!step_1,NELEMSET(1,1)+1))

      !step_2=!step_2+1
    next
    !step_1=!step_1+1
  next


  !step_1=0
  For %mar {%list_trsp}

    !step_2=0
    For %com  {%list_com}
      call create_series("MTD_"+%mar+"_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_2,(NELEMSET(1,1)+2)+!step_1))

      call create_series("MTM_"+%mar+"_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_2,2+!step_1))
      !step_2=!step_2+1
    next

    !step_1=!step_1+1
  next

  call create_series("W_SE",STEADYSTATE(5,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+(NELEMSET(9,1)+3)+(3*NELEMSET(11,1)), ( NELEMSET(1,1)+1)))

  call create_series("TCSS",0,OTH_VARIABLE(8,1))
  call create_series("TCSS_SE",0,OTH_VARIABLE(9,1))


  !step_1=!step_HH
  For %hous {%list_household}
    call create_series("SB_ROW_"+%hous,STEADYSTATE(1,1),household(56,1+!step_1 ))
    call create_series("CSS_H_"+%hous,STEADYSTATE(2,1),household(57,1+!step_1 ))
    call create_series("CSS_H_SE_"+%hous,STEADYSTATE(2,1),household(58,1+!step_1 ))
    call create_series("L_S_"+%hous,STEADYSTATE(3,1),household(54,1+!step_1 ))
    call create_series("W_S_"+%hous,STEADYSTATE(5,1),household(52,1+!step_1 ))
    call create_series("L_SE_"+%hous,STEADYSTATE(3,1),household(55,1+!step_1 ))
    call create_series("W_SE_"+%hous,STEADYSTATE(5,1),household(53,1+!step_1 ))

    call create_series("PRESOC_DOM_VAL_"+%hous,STEADYSTATE(1,1),household(59,1+!step_1))
    call create_series("TR_OTH_VAL_"+%hous,STEADYSTATE(1,1),household(60,1+!step_1))
    call create_series("INT_VAL_"+%hous,STEADYSTATE(1,1),household(61,1+!step_1))

    call create_series("DIV_HH_VAL_"+%hous,STEADYSTATE(1,1),household(62,1+!step_1))

    !step_1= !step_1+1
  next

  call create_series("IS_Val",STEADYSTATE(1,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+1,( NELEMSET(1,1)+1)))

  call create_series("PRESOC_ROW_VAL",STEADYSTATE(1,1),OTH_VARIABLE(2,1))

  !step_1=0
  For %sec {%list_sec}
    call create_series("PROG_L",STEADYSTATE(4,1),1)

    call create_series("IA_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+(NELEMSET(9,1)+1),1+!step_1))
    call create_series("L_S_"+%sec,STEADYSTATE(3,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+(NELEMSET(9,1)+3)+1,1+!step_1))
    call create_series("L_SE_"+%sec,STEADYSTATE(3,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+(NELEMSET(9,1)+3)+NELEMSET(11,1),1+!step_1))
    call create_series("W_SE_"+%sec,STEADYSTATE(5,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+NELEMSET(9,1)+3+(3*NELEMSET(11,1)),1+!step_1))
    call create_series("CL_S_"+%sec,STEADYSTATE(15,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+NELEMSET(9,1)+3+(NELEMSET(11,1)+1),1+!step_1))

    call create_series("K_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+NELEMSET(9,1)+3,1+!step_1))
    call create_series("Tdec_"+%sec,0,SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+NELEMSET(9,1)+2,1+!step_1))
    call create_series("W_S_"+%sec,STEADYSTATE(5,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+NELEMSET(9,1)+3+(NELEMSET(11,1)+3),1+!step_1))

    call create_series("CSE_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1),1+!step_1))
    call create_series("IY_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+2,1+!step_1))
    call create_series("SY_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_DOM((NELEMSET(3,1)+1)+2+(NELEMSET(11,1)+1)+NELEMSET(9,1),1+!step_1))

    call create_series("DIV_GOV_VAL",STEADYSTATE(1,1),OTH_VARIABLE(3,1))
    call create_series("DIV_ROW_VAL",STEADYSTATE(1,1),OTH_VARIABLE(5,1))
    call create_series("DIV_BK_VAL",STEADYSTATE(1,1),OTH_VARIABLE(6,1))

    !step_1=!step_1+1
  next

  call create_series("R_DIR",0,STEADYSTATE(17,1))
  call create_series("CSE_ROW",STEADYSTATE(2,1),OTH_VARIABLE(1,1))

  !step_1=0
  For %sec {%list_sec}

    !step_2=0
    For %com {%list_com_MAT}

      call create_series("MATD_"+%com+"_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_2,(NELEMSET(1,1)+1)+NELEMSET(5,1)+NELEMSET(7,1)+1+!step_1))
      call create_series("MATM_"+%com+"_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_2,1+NELEMSET(5,1)+NELEMSET(7,1)+1+!step_1))
      !step_2=!step_2+1
    next

    !step_2=0
    For %com  {%list_com_E}

      call create_series("ED_"+%com+"_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_DOM((NELEMSET(3,1)-NELEMSET(4,1)+1)+!step_2,(NELEMSET(1,1)+1)+NELEMSET(5,1)+NELEMSET(7,1)+1+!step_1))
      call create_series("EM_"+%com+"_"+%sec,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN((NELEMSET(3,1)-NELEMSET(4,1)+1)+!step_2,1+NELEMSET(5,1)+NELEMSET(7,1)+1+!step_1))
      !step_2=!step_2+1
    next
    !step_1=!step_1+1
  next

  !step_1=0
  For %sec {%list_sec}

    !step_2=0
    For %com {%list_com}
      call create_series("IA_"+%com+"_"+%sec,STEADYSTATE(2,1),INV_MAT(1+!step_2,1+!step_1))

      !step_2=!step_2+1
    next
    !step_1=!step_1+1
  next

'---------------------------***LOAD EMISSION DATA***---------------------------------
' For sectors
  !step_1=0
  For %sec  {%list_sec}
    !step_2=0

    For %ems  {%list_com_E_CO2}
      call create_series("EMS_SEC_"+%ems+"_"+%sec,STEADYSTATE(2,1),EMISSION(1+!step_1,1+!step_2))

      !step_2=!step_2+1
    next
    !step_1=!step_1+1
  next

  ' For BIOM
  !step_1=0
  For %sec {%list_sec}
    call create_series("EMS_SEC_BIOM_"+%sec,STEADYSTATE(2,1),EMISSION(1+!step_1,3))
    !step_1=!step_1+1
  next
  
  '----------------------------EMISSIONS From Households-----------------------------------------


' For Households
  !step_1=0
  For %hh {%list_household}
    !step_2=0
    For %ems  {%list_com_E_CO2}
      call create_series("EMS_HH_"+%ems+"_"+%hh,STEADYSTATE(2,1),EMISSION(26,1+!step_2))

      !step_2=!step_2+1
    next
    !step_1=!step_1+1
  next

  ' For BIOMASS
  !step_1=0
  For %hh {%list_household}
   
    call create_series("EMS_HH_BIOM_"+%hh,STEADYSTATE(2,1),EMISSION(26,3))
    !step_1=!step_1+1
   next

  '---------------------------***LOAD ENERGY CONSUMPTION DATA***---------------------------------
' For sectors
  !step_1=0
  For %sec {%list_sec}
     !step_2=0
     For %ce  {%list_com_E}
       call create_series("EN_SEC_"+%ce+"_"+%sec,STEADYSTATE(2,1),ENERGY(1+!step_1,1+!step_2))

       !step_2=!step_2+1
     next
    !step_1=!step_1+1
   next

' For BIOMASS
  !step_1=0
  For %sec {%list_sec}
    call create_series("EN_SEC_BIOM_"+%sec,STEADYSTATE(2,1),ENERGY(1+!step_1,4))
    !step_1=!step_1+1
  next


  '----------------------------ENERGY CONSUMPTION From Households------------------------------------------

' For Households
   !step_1=0
  For %hh {%list_household}
     !step_2=0
    For %ce  {%list_com_E}
      call create_series("EN_HH_"+%ce+"_"+%hh,STEADYSTATE(2,1),ENERGY(37,1+!step_2))

      !step_2=!step_2+1
     next
     !step_1=!step_1+1
   next

  ' For BIOMASS
  !step_1=0
  For %hh {%list_household}
   
    call create_series("EN_HH_BIOM_"+%hh,STEADYSTATE(2,1),ENERGY(37,4))
    !step_1=!step_1+1
   next
  

  '---------------------------***DEMOGRAPHY***---------------------------------
  !step_2=0
  For %sex {%list_sex}
      !step_1=0
      For %age {%list_age}
        
        call create_series("Empl_"+%sex+"_"+%age,STEADYSTATE(3,1),DEMOGRAPHY(1+!step_1+!step_2,1))
        call create_series("LF_"+%sex+"_"+%age,STEADYSTATE(3,1),DEMOGRAPHY(1+!step_1+!step_2,2))
        call create_series("WAPop_"+%sex+"_"+%age,STEADYSTATE(3,1),DEMOGRAPHY(1+!step_1+!step_2,3))
        'call create_series("UnR_"+%sex+"_"+%age,0,DEMOGRAPHY(1+!step_1+!step_2,5))
        call create_series("PARTR_"+%sex+"_"+%age,0,DEMOGRAPHY(1+!step_1+!step_2,6))
        call create_series("betaEmp_"+%sex+"_"+%age,0,DEMOGRAPHY(1+!step_1+!step_2,7))
    
      !step_1=!step_1+1 
      next

      !step_2=!step_2+2 
  next

  call create_series("Pop_TOT",STEADYSTATE(3,1),household(51,1))

  '------------------------GOVERNMENT------------------------------------'

  !step_1=0
  For %com {%list_com}
    call create_series("EXPGD_"+%com,STEADYSTATE(2,1),SUPPLY_USE_DOM(1+!step_1, (NELEMSET(1,1)+1)+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+2))
    call create_series("EXPGM_"+%com,STEADYSTATE(2,1),SUPPLY_USE_FOREIGN(1+!step_1, 1+NELEMSET(5,1)+NELEMSET(7,1)+NELEMSET(1,1)+2))
    !step_1=!step_1+1
  next

  call create_series("R_DIR",0,STEADYSTATE(17,1))
  call create_series("R",0,STEADYSTATE(17,1))

  call create_series("infl_ZE_target",0,STEADYSTATE(39,1))
  call create_series("infl_FR",0,STEADYSTATE(15,1))
  call create_series("infl_HFR",0,STEADYSTATE(43,1))

  call create_series("UnR_ZE_target",0,STEADYSTATE(40,1))
  call create_series("UnR_HFR",0,STEADYSTATE(44,1))

  !step_2=!step_HH
  For %hous {%list_household}
    call create_series("PHI_TCO_"+%hous,0,household(2,1+!step_2))
    !step_2= !step_2+1
  next

  !step_1=0
  For %com {%list_com}
    !step_2=!step_HH
    For %hous {%list_household}
      call create_series("EXP_"+%com+"_"+%hous,STEADYSTATE(2,1),household(3+!step_1,1+!step_2))
      !step_2= !step_2+1
    next
    !step_1= !step_1+1
  next

  !step_1=!step_HH
  For %hous {%list_household}
    call create_series("AIC_VAL_"+%hous,STEADYSTATE(1,1),household(64,1+!step_1))
    call create_series("IR_VAL_"+%hous,STEADYSTATE(1,1),household(63,1+!step_1))
    !step_1= !step_1+1
  next

  call create_series("DEBT_G_VAL",STEADYSTATE(1,1),OTH_VARIABLE(7,1))
  call create_series("INC_GOV_OTH_net",STEADYSTATE(1,1),OTH_VARIABLE(4,1))  
endsub
