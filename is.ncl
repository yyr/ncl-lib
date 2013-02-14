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

;_____________________________________________________________________________
; Function: isnumstring
; Doc: return True if given string can be converted to numeric type.
; Examples: isnumstring("abc") => false
;     ncl 15> print("" + isnumstring("abc"))
;     (0)	False
;     ncl 16> print("" + isnumstring("123"))
;     (0)	True
;     ncl 17> print("" + isnumstring("12a"))
;     (0)	False
;     ncl 18> print("" + isnumstring("12.4"))
;     (0)	True
;_____________________________________________________________________________
undef("isnumstring")
function isnumstring(s:string)
local s, str_c , str_i
begin
  str_c = stringtochar(s)
  str_i = new(dimsizes(str_c) - 1,logical)
  do it = 0, dimsizes(str_i) - 1, 1
    str_i(it) = str_index_of_substr("0123456789.",chartostring(str_c(it)),0)
  end do
  if (any(ismissing(str_i))) then
    return(False)
  else
    return(True)
  end if
end
