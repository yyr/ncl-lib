; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
;    File: resources.ncl
; Created: Tuesday, July 24 2012
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>
;

; Description:
; my dumb ncl functions/procedures

;_____________________________________________________________________________
; Fuction: set_no_frame_res
; Doc:
;
;_____________________________________________________________________________
undef("set_no_frame_res")
function set_no_frame_res(res_in:logical)
local res_in, res_out

begin

  res_out          = res_in
  res_out@gsnMaximize = True
  res_out@gsnDraw  = False              ; Do not draw plot
  res_out@gsnFrame = False              ; Do not advance frame
  res_out@Footer   = False

  return(res_out)

end
;- "set_no_frame_res" ends here --
