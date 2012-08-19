; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
;    File: generic.ncl
; Created: Tuesday, July 24 2012
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>
;

;; define exit_codes
coerce_error = 2
arg_error = 4
resource_error = 8

;_____________________________________________________________________________
; Fuction: announce
; Doc: just announces stdout what ever given with print statement. This uses
;      system function "echo".
;_____________________________________________________________________________
undef("announce")
procedure announce(var_in:string)

begin
  system("echo ")
  system("echo ___________________________________________________________")
  system("echo " + var_in)
  system("echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯")
  system("echo ")
end

;_____________________________________________________________________________
; Fuction: rank_of
; Doc: return number of dimensions of a given variable.
;
;_____________________________________________________________________________
undef("rank_of")
function rank_of(var)
local dims
begin
  dims=dimsizes(var)
  return(dimsizes(dims))
end

;_____________________________________________________________________________
; Fuction: rank_of_file_var
; Doc: returns rank of a file variable.
;
;_____________________________________________________________________________
undef("rank_of_file_var")
function rank_of_file_var(file_in:file,var:string)
local nd,dims

begin
  dims = filevardimsizes(file_in,var)
  nd = dimsizes(dims)
  return(nd)
end

;_____________________________________________________________________________
; procedure: pp
; Doc:
;_____________________________________________________________________________
undef("pp")
procedure pp(str:string)

begin
  print(""+str)
  return
end


;;; generic.ncl ends here
