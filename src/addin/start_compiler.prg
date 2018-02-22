' Addin subroutine to start the compiler

%compilerpath = "start /d" + @linepath + " " + @linepath + "compiler.exe"
shell {%compilerpath}
' Wait 1 second for the compiler to start
sleep 1000
