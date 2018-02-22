wfcreate u 1

delete(noerr) addin_ini

shell(h, t=1000, out=ini_path_table) "echo %APPDATA%"

' Define location of ProgReg.ini filename based on default Eviews version.
if @vernum = 8 then
    %ini_path = ini_path_table(1, 1) + "/ihs eviews/Eviews/ProgReg.ini"
else 
    %ini_path = ini_path_table(1, 1) + "\Quantitative Micro Software\EViews\ProgReg.ini"
endif

subroutine check_if_installed(text _addin_ini, string _proc_name, scalar _is_installed)
  _is_installed = 0
  for !j = 2 to _addin_ini.@linecount
    if @instr(_addin_ini.@line(!j), _proc_name) > 0 then
      _is_installed = _is_installed + 1
    endif
  next
endsub

if @fileexist(%ini_path) then

  text addin_ini
  addin_ini.append(file) %ini_path

  %proc_to_install = "equation load series"

  for %proc {%proc_to_install}
    !is_installed = 0
    call check_if_installed(addin_ini, %proc, !is_installed)
    ' If the addin is not installed yet
    if !is_installed == 0 then
      addin(type=model, proc=%proc) .\{%proc}.prg
    endif
  next

else

  addin(type=model, proc="equation") .\equation.prg
  addin(type=model, proc="series") .\series.prg
  addin(type=model, proc="load") .\load.prg

endif

wfclose


