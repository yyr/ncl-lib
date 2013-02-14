; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
; Created: Thursday, February 14 2013
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>

;_____________________________________________________________________________
; Function: isodd
; Doc: self discriptive.
;    argument should be integer.
;_____________________________________________________________________________
undef("isodd")
function isodd(number:integer)

begin
  if ( number % 2 .ne. 0 ) then
    return(True)
  else
    return(False)
  end if
end

;_____________________________________________________________________________
; Function: iseven
; Doc: self discriptive.
;    argument should be integer.
;_____________________________________________________________________________
undef("iseven")
function iseven(number:integer)

begin
  return(.not.isodd(number))
end
