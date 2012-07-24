; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
;    File: generic.ncl
; Created: Tuesday, July 24 2012
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>
;

;_____________________________________________________________________________
; Fuction: announce
; Doc: just announces stdout what ever given with print statement
;_____________________________________________________________________________
undef("announce")
procedure announce(var_in:string)
local str

begin
  str = var_in
  system("echo ___________________________________________________________")
  system("echo " + str)
  system("echo ___________________________________________________________")
  system("echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯")
end
;- |announce| ends here --

;;; generic.ncl ends here
