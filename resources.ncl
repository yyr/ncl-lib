; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
;    File: resources.ncl
; Created: Tuesday, July 24 2012
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>
;

; Description:
; my dumb ncl functions/procedures

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
;_____________________________________________________________________________
; Function: set_res_no_frame
; Doc: add gsnDraw and gsnFrame to false and maxmize plot to True and return it
;_____________________________________________________________________________
undef("set_res_no_frame")
function set_res_no_frame(res_in:logical)
local res_in, res_attr
begin
  res_attr = (/"gsnMaximize"    , "True"  , \
               "gsnPaperMargin" , "0.0"   , \ ; no margins
               "gsnDraw"        , "False" , \ ; Do not draw plot
               "gsnFrame"       , "False"   \ ; Do not advance frame
               /)

  return(set_res_value_keep(res_in,res_attr))
end

;_____________________________________________________________________________
; Function: set_res_tm_size
; Doc: set tickmark size bit visible, useful escipially in the panel plot
;_____________________________________________________________________________
undef("set_res_tm_size")
function set_res_tm_size(res_in:logical)
local res_in, res_attr

begin
  res_attr = (/"tmXBLabelFontHeightF" , "0.014" , \
               "tmYLLabelFontHeightF" , "0.014"   \
               /)
  return(set_res_value_keep(res_in,res_attr))
end

;_____________________________________________________________________________
; Function: set_res_wrf_no_headers
; Doc: Disable set ugly wrf resorces.
;_____________________________________________________________________________
undef("set_res_wrf_no_headers")
function set_res_wrf_no_headers(res_in:logical)
local res_in, res_attr

begin
  res_attr = (/"InitTime"       , "False" , \
               "NoHeaderFooter" , "True"  , \
               "NoTitles"       , "True"  , \
               "ValidTime"      , "False" , \
               "FramePlot"      , "False" , \
               "PanelPlot"      , "False" , \
               "MainTitlePos"   , "False"   \
               /)

  return(set_res_value_keep(res_in,res_attr))
end

;_____________________________________________________________________________
; Function: set_res_highres_coast
; Doc: self descriptive
;_____________________________________________________________________________
undef("set_res_highres_coast")
function set_res_highres_coast(res_in:logical)
local res_in, res_attr

begin
  res_attr = (/"mpDataBaseVersion"           , "HighRes" , \
               "mpGeophysicalLineColor"      , "Black"   , \
               "mpGeophysicalLineThicknessF" , "2"         \
               /)
  return(set_res_value_keep(res_in,res_attr))
end

;_____________________________________________________________________________
; Function: set_res_cn
; Doc: self descriptive.
;_____________________________________________________________________________
undef("set_res_cn")
function set_res_cn(res_in:logical)
local res, res_in, res_attr
begin
  res = res_in
  res_attr = (/"cnFillColor" , "True",        \
               "gsnSpreadColors"   , "True",  \
               "cnFillOn"          , "True",  \
               "cnInfoLabelOn"     , "False", \
               "cnLineLabelsOn"    , "False"  \
               /)
  return(set_res_value_keep(res,res_attr))
end

;_____________________________________________________________________________
; procedure: set_res_cn_limits
; Doc: self descriptive
;_____________________________________________________________________________
undef("set_res_cn_limits")
procedure set_res_cn_limits(res_in:logical,minn:numeric,maxx:numeric,interval:numeric)
local res_in
begin
  res_in@cnLevelSelectionMode = "ManualLevels"
  res_in@cnMinLevelValF = minn
  res_in@cnMaxLevelValF = maxx
  res_in@cnLevelSpacingF = interval
  return
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
; procedure: set_res_aspectratio_manual
; Doc:
;_____________________________________________________________________________
undef("set_res_aspectratio_manual")
procedure set_res_aspectratio_manual(res:logical,width:numeric,height:numeric)
begin
  res@mpShapeMode = "FreeAspect"
  res@vpWidthF = 0.8
  res@vpHeightF = 0.4
end

;_____________________________________________________________________________
; Function: set_aspectratio
; Doc: Stright from WRFUserARW.ncl.
;_____________________________________________________________________________
undef("set_aspectratio")
function set_aspectratio(data:numeric,opts_in:logical)
local data, opts_in, opts

begin
  opts = opts_in

  dims  = dimsizes(data)
  ratio = 1.*dims(0)/dims(1)

  if(ratio .gt. 1.2) then
    ratio = 1.2
  end if
  if(ratio .lt. 0.6667) then
    ratio = 0.6667
  end if

  if(ratio .gt. 1)
    width  = 0.65 * 1.0/ratio
    height = 0.65
  else
    width  = 0.85
    height = 0.85 * ratio
  end if

  opts@vpWidthF = width
  opts@vpHeightF = height
  return(opts)
end


;_____________________________________________________________________________
; Function: set_res_vc
; Doc: set some common vector resources. (fair defaults)
;_____________________________________________________________________________
undef("set_res_vc")
function set_res_vc(res_in:logical)
local res_in, res_attr

begin
  res_attr = (/ "vcMonoLineArrowColor"     , "True"        , \
               "vcMinDistanceF"            , "0.03"        , \
               "vcRefMagnitudeF"           , "10."         , \
               "vcWindBarbTickLengthF"     , "0.1"         , \
               "vcRefLengthF"              , "0.02"        , \
               "vcRefAnnoOn"               , "True"        , \
               "vcLineArrowThicknessF"     , "1.5"         , \
               "vcRefAnnoOrthogonalPosF"   , "-1"          , \ ; Move reference into plot.
               "vcRefAnnoArrowUseVecColor" , "False"       , \ ; Allow us to change ref vec color
               "vcRefAnnoArrowLineColor"   , "Black"         \ ; Black ref vector
               /)

  return(set_res_value_keep(res_in,res_attr))
end

;_____________________________________________________________________________
; Function: set_res_mp_latlon
; Doc: set zoom resources in of a plot
;_____________________________________________________________________________
undef("set_res_mp_latlon")
function set_res_mp_latlon(res_in:logical,lonL:float,lonR:float, \
                            latB:float,latU:float)
local res_in,res_attr

begin
  res_out  = res_in
  res_out@mpLimitMode = "Corners"
  res_out@mpLeftCornerLatF      = latB
  res_out@mpRightCornerLatF     = latU
  res_out@mpLeftCornerLonF      = lonL
  res_out@mpRightCornerLonF     = lonR
  return(res_out)
end

;_____________________________________________________________________________
; Function: set_panel_resources
; Doc:
;_____________________________________________________________________________
undef("set_panel_resources")
function set_panel_resources(res:logical)
begin
  res_attr = (/ "lbLabelStride"   , "3"        , \
               "gsnPanelBottom"   , "0.03"     , \
               "gsnPanelLabelBar" , "True"     , \
               "gsnMaximize"      , "True"     , \
               "lbOrientation"    , "vertical" , \
               "amJust"           , "TopLeft"    \
               /)
  res@gsnPanelFigureStrings = (/"a", "b", "c", "d", "e", "f", "g", "h"/)
  res = set_res_value_keep(res,res_attr)
  return(res)
end

;_____________________________________________________________________________
; Function: set_lb_res
; Doc: slick version of WRFUserARW.ncl's set_lb_resources
;_____________________________________________________________________________
undef("set_lb_res")
function set_lb_res(res:logical)
local res_out

begin
  res_out                    = res
  res_attr = (/ "lbAutoManage"       ,"False"         , \
               "lbOrientation"      , "Horizontal"   , \
               "lbPerimOn"          , "False"        , \
               "lbLabelJust"        , "BottomCenter" , \
               "lbLabelAutoStride"  ,"True"          , \
               "lbBoxMinorExtentF"  , "0.13"         , \
               "lbTitleFontHeightF" , "0.015"        , \
               "lbLabelFontHeightF" , "0.015"        , \
               "lbTitleJust"        , "BottomCenter" , \
               "lbTitleOn"          , "False"        , \
               "lbTitleOffsetF"     , "-0.5"          \
               /)
  res_out = set_res_value_keep(res_out,res_attr)
  return(res_out)
end
