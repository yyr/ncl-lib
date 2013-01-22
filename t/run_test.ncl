; test initilization script load be loaded in each test file

load "$nsc/generic.ncl"

;_____________________________________________________________________________
; Function: wrf_input_file
; Doc: look environment varible for wrf input file and return edited file
;_____________________________________________________________________________
undef("wrf_input_file")
function wrf_input_file(env_name:string)
local infile_name,wrf_in

begin
  infile_name = getenv(env_name)

  if ( isstring(infile_name) ) then
    wrf_in = addfile(infile_name, "r")
  else
    announce("Fatal: wrfout environment variable is not set ")
    exit
  end if
  return(wrf_in)
end

;_____________________________________________________________________________
; procedure: pass
; Doc: similar to python pass function, should just pass/exit the scope
;_____________________________________________________________________________
undef("pass")
procedure pass(a)
local a

begin

  return
end

;_____________________________________________________________________________
; Function: ncl_deftest
; Doc: primitive function for test definition.
;      execute the body line by line and returns success.
;      body may use one or more of the funciton `should',
;      `should-not', `should-error'.
;_____________________________________________________________________________
undef("ncl_deftest")
function ncl_deftest(name:string,fun:string)

begin
  pass("a")
  return
end

;;; run_test.ncl ends here
