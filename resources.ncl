; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
;    File: resources.ncl
; Created: Tuesday, July 24 2012
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>
;

; Description:
; my dumb ncl functions/procedures

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
;_____________________________________________________________________________
; Function: set_no_frame_res
; Doc: add gsnDraw and gsnFrame to false and maxmize plot to True and return it
;_____________________________________________________________________________
undef("set_no_frame_res")
function set_no_frame_res(res_in:logical)
local res_in, res_out

begin

  res_out          = res_in
  res_out@gsnMaximize = True
  res_out@gsnPaperMargin  = 0.0         ; no margins
  res_out@gsnDraw  = False              ; Do not draw plot
  res_out@gsnFrame = False              ; Do not advance frame

  return(res_out)

end


;_____________________________________________________________________________
; Function: set_tm_size_res
; Doc: set tickmark size bit visible, useful escipially in the panel plot
;_____________________________________________________________________________
undef("set_tm_size_res")
function set_tm_size_res(res_in:logical)
local res_in, res_out

begin

  res_out          = res_in
  res_out@tmXBLabelFontHeightF = 0.014
  res_out@tmYLLabelFontHeightF = 0.014

  return(res_out)
end



;_____________________________________________________________________________
; Fuction: set_wrf_no_headers
; Doc:
;
;_____________________________________________________________________________
undef("set_wrf_no_headers")
function set_wrf_no_headers(res_in:logical)
local res_in, res_out

begin

  res_out          = res_in
  res_out@InitTime = False
  res_out@NoHeaderFooter  = True
  res_out@NoTitles = True
  res_out@ValidTime = False              ; Do not draw plot
  res_out@PanelPlot = True
  res_out@FramePlot = False
  res_out@MainTitlePos= False

  return(res_out)
end


;_____________________________________________________________________________
; Function: set_high_res_coast
; Doc:
;
;_____________________________________________________________________________
undef("set_high_res_coast")
function set_high_res_coast(mp_res_in:logical)
local mp_res_out

begin
  mp_res_out = mp_res_in
  mp_res_out@mpDataBaseVersion    = "HighRes"
  mp_res_out@mpGeophysicalLineColor = "Black"
  mp_res_out@mpGeophysicalLineThicknessF = 1.5
  return(mp_res_out)
end


;_____________________________________________________________________________
; Function: set_cn_resorces
; Doc:
;
;_____________________________________________________________________________
undef("set_cn_resorces")
function set_cn_resorces(opts_in:logical)
local opts_out

begin
  opts_out = opts_in
  opts_out@cnFillColor = True
  opts_out@gsnSpreadColors = True
  opts_out@cnFillOn = True
  opts_out@cnInfoLabelOn = False

  return(opts_out)
end

;_____________________________________________________________________________
; procedure: set_colormap
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
    gsn_define_colormap(ws, colormap@hgt)
  end if

  return
end

;_____________________________________________________________________________
; Function: set_vc_res
; Doc: set some common vector resources. (fair defaults)
;
;_____________________________________________________________________________
undef("set_vc_res")
function set_vc_res(res_in:logical)
local res_out

begin

  res_out  = res_in

  res_out@vcMonoLineArrowColor = True
  res_out@vcGlyphStyle        = "CurlyVector"    ; turn on curly vectors
  res_out@vcMinDistanceF = 0.03

  res_out@vcRefMagnitudeF = 20.
  res_out@vcRefLengthF = 0.02
  res_out@vcRefAnnoOrthogonalPosF   = -1    ; Move reference into plot.
  res_out@vcRefAnnoArrowUseVecColor = False    ; Allow us to change ref vec color
  res_out@vcRefAnnoArrowLineColor   = "black"  ; Black ref vector

  return(res_out)
end
