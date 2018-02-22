' Addin subroutine to stop the compiler

' The compiler watches the _compiler_in directory for changes
' When a shutdown.txt file is added there, it shuts down
'
' The shutdown.exe program creates this shutdown.txt file in the _compiler_in folder
%shutdownpath = "start /d" + @linepath + " /b " + @linepath + "shutdown.exe"
shell {%shutdownpath}