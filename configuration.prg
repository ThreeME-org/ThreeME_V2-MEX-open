' ============================================================================
' This file defines the configuration options
'
' ============================================================================

' Set the begining of the sample
%firstdate = "2011"

' Input the base year used for the calibration
%baseyear = "2013"

' Set the end of the sample
%lastdate = "2050"

' Data calibrations to be used in the model run - file names are space-separated and found inside data\calibration
' Example: to run the NEW, NR_AS_G and NR_AS_G_WS calibrations, use "NEW NR_AS_G NR_AS_G_WS"
%calibrations = " MEX_BALMOREL_NEW"

' Shocks to run, filenames are space-separated and found inside data\shocks
' Example: to run the IAPU shock, use "IAPU"
%shocks = "EE"

' Set "realist" for simulating a realistic reference scenario; something else for a stationary  reference scenario
' in a realist version model run until 2090. Track_objectif find a solution until this date'
%ref = "realist"

' Set "yes" for running shock scenario (mitigation scenario)
%run_shock = "yes" 'standard

' List of model blocks to be run
%list_block = "Other"

' ********************
' Additional options

%modelname = "a_3ME"
' Set frequency ("a" : annual; "q" quarterly)
%freq = "a"
' Set "new" for loading the data and the specification of the model; something else for loading an existing workfile
%load = "new"
' Set "u0, u1,... " for user options; "d" diagnostic option; something else for default option
%solveopt = "u0"

' Set the threshold under which the value is rounded to zero.
!round0 = 1.0E-10

' ****************
' Output options

' Set to "yes" to save table & graphs
%save = ""
' Set to "" to close output windows after run
%close = ""
' Set to "yes" to save worfiles
%savewf = ""


