' IMPORTANT WARNING!! You may need to RUN E-views as administrator.
'run(1,c,q) main ' Run a program. c : run program file without display the program file window. v / q : verbose / quiet; ver4 / ver5 : Execute program in previous version script.


' ***************
' Configuration

include .\configuration.prg


' **********
' Includes

' Utility procedures
include .\src\utils\subroutines
include .\src\utils\results_outputs

' Addin: External compiler
include .\src\addin\model_addin.prg
include .\src\addin\export.prg

' Load data
include .\src\data\load_calibration
include .\src\data\load_data_shocks
include .\src\data\load_data_realist
include .\src\data\standard_shocks

' Running the model
include .\src\model\jacobian.prg
include .\src\model\tracker.prg
include .\src\model\solve
include .\src\model\run


' ***********
' Model run

For %DC {%calibrations}

  For %DS {%shocks}

    ' Relative paths
    %data_calibration = ".\..\..\data\calibrations\SAM_"+%DC+".xls"
    %data_shocks_local = ".\..\..\data\shocks\"+%DS+".xls"

    call run(%data_calibration,%data_shocks_local)

  Next

Next


