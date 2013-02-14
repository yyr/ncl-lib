; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
; Created: Thursday, February 14 2013
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>

load "$nsc/yagUtils.ncl"

begin
  res = True
  a = (/  "b" , "c",    \
          "d",  "89",   \
          "f",  "True", \
          "f",  "89.9"  \
          /)

  res = set_res_value_keep(res,a)
end
