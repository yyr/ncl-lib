; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
;    File: resources.ncl
; Created: Tuesday, July 24 2012
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>
;

; Description:
; my dumb ncl functions/procedures

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

load "$nsc/generic.ncl"
;_____________________________________________________________________________
; procedure: true
; Doc: put True "s" a property of resource "r"
;_____________________________________________________________________________
undef("true")
procedure true(r:logical, s:string)
local r, s
begin
  r@$s$ = True
  return
end

;_____________________________________________________________________________
; procedure: false
; Doc:
;_____________________________________________________________________________
undef("false")
procedure false(r:logical, s:string)
local r, s
begin
  r@$s$ = False
  return
end



;_____________________________________________________________________________
; Function: set_res_no_frame
; Doc: add gsnDraw and gsnFrame to false and maxmize plot to True and return it
;_____________________________________________________________________________
undef("set_res_no_frame")
function set_res_no_frame(res_in:logical)
local res_in, res_attr
begin
  res_attr = (/"gsnDraw"        , "False" , \ ; Do not draw plot
               "gsnFrame"       , "False"   \ ; Do not advance frame
               /)

  return(set_res_value_keep(res_in,res_attr))
end

;_____________________________________________________________________________
; Function: set_res_no_margin
; Doc:
;_____________________________________________________________________________
undef("set_res_no_margin")
function set_res_no_margin(res_in:logical)
local res_in, res_attr

begin
  res_attr = (/"gsnPaperMargin" , "0.1"   , \ ; no margins
               "gsnMaximize"    , "True"    \ ; crop almost
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
  res_attr = (/"tmXBLabelFontHeightF" , "0.015" , \
               "tmYLLabelFontHeightF" , "0.015"   \
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
  res_attr = (/"mpDataBaseVersion"           , "MediumRes" , \
               "mpGeophysicalLineColor"      , "Black"   , \
               "mpGeophysicalLineThicknessF" , "1"         \
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
  res_attr = (/"cnFillColor"       , "True",  \
               "cnSmoothingOn"     , "True",  \
               "cnFillOn"          , "True",  \
               "cnLinesOn"         , "False",   \
               "cnInfoLabelOn"     , "False", \
               "cnLineLabelsOn"    , "False", \
               "gsnSpreadColors"   , "True"   \
               /)
  return(set_res_value_keep(res,res_attr))
end

;_____________________________________________________________________________
; Function: set_res_cn_lines
; Doc: self descriptive.
;_____________________________________________________________________________
undef("set_res_cn_lines")
function set_res_cn_lines(res_in:logical)
local res, res_in, res_attr
begin
  res = res_in
  res_attr = (/"cnFillColor" , "False",        \
               "cnSmoothingOn"     , "True",   \
               "cnFillOn"          , "False",  \
               "cnLinesOn"         , "True",   \
               "cnInfoLabelOn"     , "False",  \
               "cnLineLabelsOn"    , "True",   \
               "gsnSpreadColors"   , "False"   \
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
; procedure: set_res_cn_limits
; Doc: self descriptive
;_____________________________________________________________________________
undef("set_res_cn_limits_explicit")
procedure set_res_cn_limits_explicit(res_in:logical,levs:numeric)
local res_in
begin
  res_in@cnLevelSelectionMode = "ExplicitLevels"
  res_in@cnLevels = levs
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
function set_res_aspectratio_manual(res:logical,width:numeric,height:numeric)
local res, width, height

begin
  ; res@mpShapeMode = "FreeAspect"
  res@vpWidthF = width
  res@vpHeightF = height
  return(res)
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
; Function: set_res_vc_anno
; Doc:
;_____________________________________________________________________________
undef("set_res_vc_anno")
function set_res_vc_anno(res:logical)
begin
    res@vcRefAnnoString2 = ""
    res@vcRefAnnoString1 = "10 m/s"
    res@vcRefAnnoZone = 1
    res@vcRefAnnoOrthogonalPosF = 1
  return(res)
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
; Function: set_res_mp_lon_limits
; Doc: set lon limits to horizontal plot
;_____________________________________________________________________________
undef("set_res_mp_lon_limits")
function set_res_mp_lon_limits(res_in:logical, lonB:float, lonU:float)
local res_in,res_attr

begin
  res_out  = res_in
  res_out@mpLimitMode = "LatLon"
  res_out@mpMinLonF      = lonB
  res_out@mpMaxLonF = lonU
  return(res_out)
end

;_____________________________________________________________________________
; Function: set_res_mp_lat_limits
; Doc: set lat limits to horizontal plot
;_____________________________________________________________________________
undef("set_res_mp_lat_limits")
function set_res_mp_lat_limits(res_in:logical, latB:float, latU:float)
local res_in,res_attr

begin
  res_out  = res_in
  res_out@mpLimitMode = "LatLon"
  res_out@mpMinLatF      = latB
  res_out@mpMaxLatF = latU
  return(res_out)
end

;_____________________________________________________________________________
; Function: set_res_panel
; Doc:
;_____________________________________________________________________________
undef("set_res_panel")
function set_res_panel(res:logical)
begin
  res_attr = (/ "lbLabelStride"   , "3"        , \
               "gsnPanelBottom"   , "0.03"     , \
               "gsnPanelLabelBar" , "True"     , \
               "gsnMaximize"      , "True"     , \
               "lbOrientation"    , "vertical" , \
               "gsnPanelFigureStringsFontHeightF", "0.01", \
               "amJust"           , "TopLeft",   \
               "lbAutoManage"     , "True"       \
               /)
  res@gsnPanelFigureStrings = get_res_value_keep(res, "gsnPanelFigureStrings", (/"a", "b", "c", "d", "e", "f", "g", "h"/))
  res = set_res_value_keep(res,res_attr)
  return(res)
end

;_____________________________________________________________________________
; Function: set_res_lb
; Doc: slick version of WRFUserARW.ncl's set_lb_resources
;_____________________________________________________________________________
undef("set_res_lb")
function set_res_lb(res:logical)
local res_out

begin
  res_out                    = res
  res_attr = (/ "lbAutoManage"       ,"False"         , \
               "lbOrientation"      , "Horizontal"   , \
               "lbPerimOn"          , "False"        , \
               "lbLabelJust"        , "BottomCenter" , \
               "lbLabelAutoStride"  , "True"          , \
               "lbTitleString"      , ""         , \
               "lbBoxMinorExtentF"  , "0.13"         , \
               "lbTitleFontHeightF" , "0.015"        , \
               "lbLabelFontHeightF" , "0.01"        , \
               "lbTitleJust"        , "BottomCenter" , \
               "lbTitleOn"          , "True"        , \
               "lbTitleOffsetF"     , "-.5"          \
               /)
  res_out = set_res_value_keep(res_out,res_attr)
  return(res_out)
end

;_____________________________________________________________________________
; Function: set_res_vp_21_upper
; Doc:
;_____________________________________________________________________________
undef("set_res_vp_21_upper")
function set_res_vp_21_upper(res_in)
local res_out
begin
  res_out = res_in
  res_attr = (/"vpYF"      , "0.99" , \
               "vpHeightF" , "0.49"  \
               /)
  res_out = set_res_value_keep(res_out,res_attr)
  return(res_out)
end

;_____________________________________________________________________________
; Function: set_res_vp_21_lower
; Doc:
;_____________________________________________________________________________
undef("set_res_vp_21_lower")
function set_res_vp_21_lower(res_in)
local res_out
begin
  res_out = res_in
  res_attr = (/"vpYF"      , "0.49" , \
               "vpHeightF" , "0.49"   \
  /)
  res_out = set_res_value_keep(res_out,res_attr)
  return(res_out)
end

;_____________________________________________________________________________
; Function: month_name
; Doc:
;_____________________________________________________________________________
undef("month_name")
function month_name(n:integer)
local n, month_names

begin
  month_names = (/"JAN", "FEB", "MAR", "APR", "MAY", \
                  "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"/)
  if ( n .le. 11 ) then
    return(month_names(n))
  else
    print_info("WRONG MONTH SUBSCRIPT", "warn")
    return("WRONG MONTH SUBSCRIPT")
  end if
end

;_____________________________________________________________________________
; Function: set_res_legend
; Doc:
;_____________________________________________________________________________
undef("set_res_legend")
function set_res_legend(res:logical)
local res_out

begin
  res_out                    = res
  res_attr = (/"pmLegendDisplayMode"    , "Always", \ ; turn on legend
               "pmLegendSide"           , "Top",    \ ; Change location of
               "pmLegendParallelPosF"   , ".9",     \ ; move units right
               "pmLegendOrthogonalPosF" , "-0.2",   \ ; move units down
               "pmLegendWidthF"         , "0.05",   \ ; Change width and
               "pmLegendHeightF"        , "0.08",   \ ; height of legend.
               "lgPerimOn"              , "False",  \ ; turn off box around
               "lgLabelFontHeightF"     , ".02"     \ ; label font height
  /)
  res_out = set_res_value_keep(res_out,res_attr)
  return(res_out)
end

;_____________________________________________________________________________
; Function: set_res_xy
; Doc:
;_____________________________________________________________________________
undef("set_res_xy")
function set_res_xy(res)
local res

begin
  res@xyLineThicknesses = (/3.0, 3.0, 3.0, 3.0/) ; make second line thicker
  res@xyDashPattern  = 0                         ; Make curves all solid
  return(res)
end


;_____________________________________________________________________________
; Function: set_res_centered_pacific
; Doc:
;_____________________________________________________________________________
undef("set_res_centered_pacific")
function set_res_centered_pacific(res:logical)
local res

begin
  res@mpMinLonF=0
  res@mpMaxLonF=360
  res@mpCenterLonF=180
  return(res)
end

;_____________________________________________________________________________
; Function: set_res_tix_limits
; Doc:
;_____________________________________________________________________________
undef("set_res_tix_limits")
function set_res_tix_limits(res, minv:numeric, maxv:numeric)
local res, minv, maxv

begin
  res@trXMinF = minv
  res@trXMaxF = maxv
  return(res)
end

;_____________________________________________________________________________
; Function: set_res_tiy_limits
; Doc:
;_____________________________________________________________________________
undef("set_res_tiy_limits")
function set_res_tiy_limits(res, minv:numeric, maxv:numeric)
local res, minv, maxv

begin
  res@trYMinF = minv
  res@trYMaxF = maxv
  return(res)
end

;_____________________________________________________________________________
; Function: set_res_tmxb_manual
; Doc:
;_____________________________________________________________________________
undef("set_res_tmxb_manual")
function set_res_tmxb_manual(res:logical, strt, endd, spacing)
local  res, strt, endd, spacing

begin
  res@tmXBMode        = "Manual"
  res@tmXBTickStartF  = strt
  res@tmXBTickEndF    = endd
  res@tmXBTickSpacingF= spacing
  return(res)
end

;_____________________________________________________________________________
; Function: set_res_tmyl_manual
; Doc:
;_____________________________________________________________________________
undef("set_res_tmyl_manual")
function set_res_tmyl_manual(res:logical, strt, endd)
local  res, strt, endd, spacing

begin
  res@tmYLMode        = "Manual"
  res@tmYLTickStartF  = strt
  res@tmYLTickEndF    = endd
  ; res@tmYLTickSpacingF= spacing
  return(res)
end



;_____________________________________________________________________________
; Function: set_res_tmxb_explicit
; Doc:
;_____________________________________________________________________________
undef("set_res_tmxb_explicit")
function set_res_tmxb_explicit(res:logical, vals, labls)
local  res, vals, labls

begin
  res@tmXBMode        = "Explicit"
  if (isatt(res,"tmXBValues") ) then
    delete(res@tmXBValues)
  end if
  res@tmXBValues      = vals

  if (isatt(res,"tmXBLabels") ) then
    delete(res@tmXBLabels)
  end if
  res@tmXBLabels      = labls
  return(res)
end

;_____________________________________________________________________________
; Function: set_res_tmyl_explicit
; Doc:
;_____________________________________________________________________________
undef("set_res_tmyl_explicit")
function set_res_tmyl_explicit(res:logical, vals, labls)
local  res, vals, labls

begin
  res@tmYLMode        = "Explicit"
  if (isatt(res,"tmYLValues") ) then
    delete(res@tmYLValues)
  end if
  res@tmYLValues      = vals

  if (isatt(res,"tmYLLabels") ) then
    delete(res@tmYLLabels)
  end if
    res@tmYLLabels      = labls
  return(res)
end

;_____________________________________________________________________________
; Function: reassign_viewport
; Doc:
;_____________________________________________________________________________
undef("reassign_viewport")
function reassign_viewport(plot, res)
local res

begin

  getvalues plot
    "vpXF"      : vpxf
    "vpYF"      : vpyf
    "vpHeightF" : vpheightf
    "vpWidthF"  : vpwidthf
  end getvalues

  res@vpXF      = vpxf
  res@vpYF      = vpyf
  res@vpHeightF = vpheightf
  res@vpWidthF  = vpwidthf
  return(res)
end

;_____________________________________________________________________________
; Function: res_unset_titles
; Doc:
;_____________________________________________________________________________
undef("res_unset_titles")
function res_unset_titles(res)
local res
begin
  if (isatt(res,"tiMainString") ) then
    delete(res@tiMainString)
  end if

  if (isatt(res,"gsnCenterString")) then
    delete(res@gsnCenterString)
  end if

  if (isatt(res,"gsnLeftString")) then
    delete(res@gsnLeftString)
  end if

  if (isatt(res,"gsnRightString")) then
    delete(res@gsnRightString)
  end if

  return(res)
end

;_____________________________________________________________________________
; Function: set_res_tmtr_off
; Doc:
;_____________________________________________________________________________
undef("set_res_tmtr_off")
function set_res_tmtr_off(res)
local res

begin
    res@tmXTOn = False
    res@tmYROn = False
  return(res)
end
