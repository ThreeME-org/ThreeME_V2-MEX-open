
' ============================================================================
' Series of subroutines used to run the model

' Additional user defined run subroutines in the file "run_extra.prg"
' Here only the basic run subroutine!
' ============================================================================

'============================================================================
' +++++++++++++++++++
' Subroutine "Run"
' +++++++++++++++++++
' Called from eviews by the program main
' Performs a complete model run:
' - loads the data calibration specified
' - loads the specification of the model
' - run scenario(s)

subroutine run(string %data_calibration, string %data_shocks_local)

  ' ***********************
  ' Create the Workfile
  %wfname = "./../../"+%modelname+"_"+%DC+"_"+%DS
  wfcreate(wf=%wfname, page=%modelname) {%freq} {%firstdate} {%lastdate}

  call create_lists


  ' ******************
  ' Load the model

  if %load="new"  then

    'Give a name to the Model
    model {%modelname}

    ' Load calibration data from the Excel file
    call load_calibration

    'Export all variables to a csv file (used by the external compiler)
    call export_all_to_csv

    ' Create the series using the dependencies (add-ins "series")
    {%modelname}.series round1 round2 demography government household Mex_exceptions ghg carbon_tax prices

    if %hybrid_household="yes"  then 'Load if "yes" in the main
      call load_data_hybrid
    endif

    ' Export all variables to a csv file (used by the external compiler)
    call export_all_to_csv

    ' Load the model specification from the model/ folder
    {%modelname}.load blocks
    '{%modelname}.load lists Input_Output Producer Consumer government price 'Adjustments demography 'GHG

    'save the worfile'
    wfsave {%wfname}


    ' Put add factors to all equations
    ' {%modelname}.addassign @all
    ' ' Set add factor values so that the equation has no residual when evaluated at actuals
    ' {%modelname}.addinit(v=n) @all
    ' 'Show all add factors
    ' group a_addfactors *_a
    ' show a_addfactors

  else

    ' If the data are already initailized as a Workfile with the option  %load = ""
    ' Load the data
    wfopen {%wfname}    ' Load workfile if already created
  endif

  smpl @all

  'to run de track that adjust some given exogenous variablesso that a single endogenous variable follows a predefined trajectory'
  'call init_tracker

  '************************************************
  '*********** SOLVE SCENARIOS ********************
  '************************************************


  ' ***************************************
  ' Call here the subroutine you want to use to solve the shock

  !scenario = 1

  ' ***************************************
  ' Just run the baseline if not shock at all
  if %run_shock = "" then

    ' Run the baseline scenario
    call run_scenario("baseline")

    '================================================================================

    '************************************'
    'track_objectives'

    '************************************'
    'series objectives_gdp = 0

    'objectives_gdp.fill(o=2008) 0.0282,0.0183768,0.0183768,0.0183768,0.0183768,0.0183768,0.0189,0.0200,0.0203,0.0210,0.0221,0.0233,0.0248,0.0263,0.0278,0.0293,0.0307,0.0320,0.0332,0.0342,0.0351,0.0357,0.0362,0.0365,0.0366,0.0366,0.0364,0.0361,0.0356,0.0351,0.0345,0.0338,0.0332,0.0325,0.0318,0.0311,0.0305,0.0300,0.0295,0.0291,0.0288,0.0286,0.0284

    'call load_data_shocks(".\..\..\data\shocks\Objectives_gdp.xls")
    'call track_objectives(objectives_gdp, "GDP", "ADD_EXPORTS ADD_EXPG", "0.7 0.3")
    'call load_data_shocks(".\..\..\data\shocks\Target_track.xls")
    'call solve_for_target("ADD_EXPORTS ADD_EXPG ADD_IMPORTS", "GDP M X", 2008, 2050)

    '================================================================================
  endif

  ' ***************************************
  ' Run the shock scenario if requested

  if %run_shock="yes" then

    ' Run the baseline scenario
    call run_scenario("baseline")

    call run_scenario("shock")
  endif

  ' ***************************************
  ' Run the standar shock scenarios if requested (shock have prepared in standard_shocks.prg)

  if %run_shock ="standard" then

    wfopen {%wfname}

    ' Run the baseline scenario
    call run_scenario("baseline")

    call run_standard("IAPU")
  endif

  ' ***************************************
  ' Call (eventually) here the subroutine you want to use to analyse the results

  ' call additional_outputs
  ' call output_template(%scenario_name)


  ' *******************
  ' Error reporting

  string a_errors="Number of errors: "+@str(@errorcount)

  !error_count = @errorcount
  if !error_count > 0 then
    logmode all
    logsave errors
  endif


  ' **********************
  ' Saving and cleanup

  if %savewf = "yes" then
    Wfsave(c) output_{%DC}\{%DS}.wf1
  endif

  if %close = "yes" then
    close @all
  endif

endsub

' ============================================================================
' ************************************************

' +++++++++++++++++++++++++++
' Subroutine "run_scenario"
' +++++++++++++++++++++++++++

' This subroutine runs an individual scenario, baseline or shock
' Pass in "baseline" as the %scenario_name for the baseline scenario

subroutine run_scenario(string %scenario_name)

  if %scenario_name = "baseline" then

    ' Load a realistic reference scenario if requested (in configuration.prg)
    if %ref="realist" then
      call load_realist
    else

      if %hybrid_household<>"yes" then
        ''    {%modelname}.addassign(i) @all
        ''    {%modelname}.addinit(v=n) @all
      endif

    endif

  else

    ' Create a new scenario that can be compared with the baseline
    !scenario = !scenario + 1
    {%modelname}.scenario(n) {%scenario_name}

    ' Load data for the shock to be simulated
    call load_data_shocks(%data_shocks_local)
  endif

  call solvemodel(%solveopt)

endsub

' ************************************************

' +++++++++++++++++++++++++++
' Subroutine "run_standard"
' +++++++++++++++++++++++++++

subroutine run_standard(string %scenario_list)

  call standard_backup

  !scenario_count = 1

  for %scenario {%scenario_list}
    %index = @str(@wfind(%scenario_list, %scenario))
    %scenario_name = "Scenario" + %scenario

    {%modelname}.scenario(n, a=!scenario_count) %scenario_name
    call standard_shock(%scenario)
    call solvemodel(%solveopt)
    %grp = "Results" + %scenario

    !scenario_count = !scenario_count + 1
  next

endsub

' ************************************************

''  call create_seriesresults(%graphopt)
'call graph(%graphopt)   ' Call GRAPH subroutine
'' call tables(%tabopt)    ' Call TABLES subroutine
