; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
;    File: yagUtils.ncl
; Created: Wednesday, September 21 2011
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>
;

; Description:
; This one script is needed to load.


if ( .not. isdefined("import") ) then
  print("Fatal: NCL-import is not loaded, See README")
  exit
end if

import("generic")
import("is")
import("resources")
import("anno")
import("plot")
import("wrf")
import("wps")
