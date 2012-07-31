; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
;    File: resources.ncl
; Created: Tuesday, July 24 2012
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>
;

; Description:
; my dumb ncl functions/procedures

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
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

;_____________________________________________________________________________
; Fuction: set_cn_resorces
; Doc:
;
;_____________________________________________________________________________
undef("set_cn_resorces")
function set_cn_resorces(opts_in:logical)
local opts_out

begin
  opts_out = opts_in
  opts_out@gsnSpreadColors = True
  opts_out@cnFillOn = True
  opts_out@cnLinesOn = True
  return(opts_out)
end

;_____________________________________________________________________________
; Fuction: set_colormap
; Doc: set colormap based on the HGT, these are personal choice, one should be
;  over ride these from the configuration file
;_____________________________________________________________________________
undef("set_colormap")
procedure set_colormap(ws:graphic,var:string)
local colormap
begin
;  load $nsc/gen_conf.ncl

  ;; colormap resources
  colormap = True
  colormap@hgt = "OceanLakeLandSnow"

  if ( var .eq. "hgt" .or. var .eq. "HGT" ) then
    gsn_define_colormap(ws, colormap@$var$)
  end if

  return
end
