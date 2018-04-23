' This files contains 3 subroutines:
' 1. MAIN SUBROUTINE: hypotheses and simulation of the scenarios
' 2. MODEL SPECIFICATION SUBROUTINE: compile the model and simulate the baseline scenario
' 3. SOLVEMODEL  SUBROUTINE: solvel the model


' Creates a series for the all sample from the base year data defined in a matrix scalar
subroutine create_series(string %seriesname, scalar !growthrate, scalar !matrixcel)

  smpl @first  @first
  !power = {%baseyear} - {%firstdate}
  series {%seriesname} = (@abs(!matrixcel)>!round0)*!matrixcel/(1+!growthrate)^!power
  smpl @first+1  @last
  {%seriesname} = {%seriesname}(-1)*(1+!growthrate)

  smpl @all

endsub


' *******************************************************************************************************************************
' ***************************************************** CREATE SERIES AGGREGATE ENERGY SUBROUTINE*****************************
'******************************************************************************************************************************
'subroutine create_series_aggr_nrj(string %var) ' This subroutine aggregate the energy subsectors. Ex: for sector 22 make the sum of the 6 subsectors.


  '%data = %var+"_20"

 '' %equation = %var+"_20 = 0"
  'For %subsec 01 02
  ''  %equation = %equation+" + "+%var+"_20"+%subsec
  'next
 '' series {%equation}



 '' %data = %var+"_21"

  '%equation = %var+"_21 = 0"
  'For %subsec 01 02 03 04 05 06 07 08
   '' %equation = %equation+" + "+%var+"_23"+%subsec
 '' next
  'series {%equation}



  '%data = %var+"_22"


  '%equation = %var+"_22 = 0"
  'For %subsec 01 02 03 04 05 06
    '%equation = %equation+" + "+%var+"_24"+%subsec
  'next
  'series {%equation}


'endsub


subroutine create_lists

  %list_sec = "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22" '[s]
  %list_sec_Market = "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 21 22"
  %list_sec_E = "20 21 22" '[se]

  %list_com = "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22" '[c]
  %list_com_MAT = "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19" '[cm]
  %list_com_E = "20 21 22" '[ce]
  %list_com_E_CO2 = "20 21" '[ce2]
  %list_com_EN = "OIL_COAL GAS ELEC BIOM" '[en]

  %list_trsp = "12 13 14 15 16 17" '[trsp]
  %list_trsp_travel = "12 13 16"

  %list_com_oth =  "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19" '[co]

  %list_age = "15 " '[age]
  %list_sex = "W " '[sex]

  %list_household = "H01" '' H02 H03 H04 H05" '[h]
  if %list_household="H01" then
    !step_HH = 0
  else
    !step_HH = 1
  endif

  %list_ener_class = "cA cB cC cD cE cF cG" '[ecl]

  ' Matrix of column numbers of elasticities of substitution
  ' for transport margins
  ' +----+----+----+----+----+----+----+----+
  ' |    | 12 | 13 | 14 | 15 | 16 | 17 |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 12 |    | 1  | 2  | 3  |  4 | 5  |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 13 | 1  |    | 6  | 7  |  8 | 9  |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 14 | 2  |  6 |    | 10 | 11 | 12 |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 15 | 3  |  7 | 10 |    | 13 | 14 |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 16 | 4  |  8 | 11 | 13 |    | 15 |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 17 | 5  |  9 | 12 | 14 | 15 |    |    |
  ' +----+----+----+----+----+----+----+----+
  ' |    |    |    |    |    |    |    |    |
  ' +----+----+----+----+----+----+----+----+
 
  matrix(17, 17) cols_trsp
  cols_trsp.fill(o = 200) 1, 2, 3, 4, 5              '(17*12 - 4)
  cols_trsp.fill(o = 216) 1, 0, 6, 7, 8, 9           '(17*13 - 5)'
  cols_trsp.fill(o = 233) 2, 6, 0, 10, 11, 12        '(17*14 - 5)'
  cols_trsp.fill(o = 250) 3, 7, 10, 0, 13, 14        '(17*15 - 5)'
  cols_trsp.fill(o = 267) 4, 8, 11, 13, 0, 15        '(17*16 - 5)'
  cols_trsp.fill(o = 284) 5, 9, 12, 14, 15, 0        '(17*17 - 5)'
 
  ' Matrix of column numbers of elasticities of substitution
  ' for energy consumptions
  ' +----+----+----+----+
  ' |    | 20 | 21 | 22 |
  ' +----+----+----+----+
  ' | 20 |    | 1  |  2 |
  ' +----+----+----+----+
  ' | 21 | 1  |    |  3 |
  ' +----+----+----+----+
  ' | 22 | 2  | 3  |    |
  ' +----+----+----+----+
  
  
  matrix(22, 22) cols_ce
  cols_ce.fill(o = 439) 1, 2     '(22*20 - 1)'
  cols_ce.fill(o = 460) 1, 0, 3  '(22*21 - 2)'
  cols_ce.fill(o = 482) 2, 3, 0  '(22*22 - 2)'
  

  ' Matrix of column numbers of elasticities of substitution
  ' for transport of intermediary consumptions
  
  ' +----+----+----+----+----+----+----+----+
  ' |    | 12 | 13 | 14 | 15 | 16 | 17 |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 12 |    | 1  | 2  | 3  |  4 | 5  |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 13 | 1  |    | 6  | 7  |  8 | 9  |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 14 | 2  |  6 |    | 10 | 11 | 12 |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 15 | 3  |  7 | 10 |    | 13 | 14 |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 16 | 4  |  8 | 11 | 13 |    | 15 |    |
  ' +----+----+----+----+----+----+----+----+
  ' | 17 | 5  |  9 | 12 | 14 | 15 |    |    |
  ' +----+----+----+----+----+----+----+----+
  ' |    |    |    |    |    |    |    |    |
  ' +----+----+----+----+----+----+----+----+ 

  ' HACK: some transport sectors can't be substituted to each other
  ' it can disabled manually in the susbtitution equation

  matrix(17, 17) cols_mat
  cols_mat.fill(o = 200) 1, 2, 3, 4, 5              '(17*12 - 4)
  cols_mat.fill(o = 216) 1, 0, 6, 7, 8, 9           '(17*13 - 5)'
  cols_mat.fill(o = 233) 2, 6, 0, 10, 11, 12        '(17*14 - 5)'
  cols_mat.fill(o = 250) 3, 7, 10, 0, 13, 14        '(17*15 - 5)'
  cols_mat.fill(o = 267) 4, 8, 11, 13, 0, 15        '(17*16 - 5)'
  cols_mat.fill(o = 284) 5, 9, 12, 14, 15, 0        '(17*17 - 5)'

endsub
