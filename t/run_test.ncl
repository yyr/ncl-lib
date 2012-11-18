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


;;; run_test.ncl ends here
