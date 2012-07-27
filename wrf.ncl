; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
;    File: wrf.ncl
; Created: Tuesday, July 24 2012
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>
;

undef("no_of_levels")
function no_of_levels( f:file )
begin
  dims = dimsizes(var)
end

;_____________________________________________________________________________
; wrf_user_getvar_weighted_sum:
;          Calculate weight of the layer will be calculated using
;          hydrostatic equation.
undef("wrf_user_getvar_weighted_sum")
function wrf_user_getvar_weighted_sum(file_handle,var_in:string,time_in:integer)
local var,varname, var, ph,phb,pres,gh,dim, wgt_var, noflevels, \
lay_var,dgh,dp, lay_wgt, lay_wgt_var, wgt_var,time,g

begin
  g = 9.8                       ; gravity

; check the file handle is okay
  if(typeof(file_handle).eq."file") then
    ISFILE = True
    nc_file = file_handle
  else
    print("wrf_user_getvar: error: the first argument must be a file or a list of files opened with addfile or addfiles")
    return
  end if

; get var we need to return
  varname=var_in(0)
  time = time_in(0)

  var = wrf_user_getvar(nc_file,varname,time)
  ph = wrf_user_getvar(nc_file,"PH",time)
  phb = wrf_user_getvar(nc_file,"PHB",time)
  pres = wrf_user_getvar(nc_file,"pressure",time)
  gh = ph + phb               ;geo potential height
;  print(gh)

  dim = dimsizes(var)
  wgt_var = new((/ dim(1),dim(2) /),typeof(var))

  wgt_var = 0                   ;intialize

  noflevels = 32
  do z = 0, noflevels, 1   ; z level

    lay_var = (var(z+1,:,:) + var(z,:,:)) ; interpolation of the variable
    lay_var = lay_var/2.

    dgh = gh(z+1,:,:) - gh(z,:,:) ; gh difference bw two layers
    dp = pres(z+1,:,:) - pres(z,:,:) ; pressure difference bw two layers

    lay_wgt = (dp/dgh)
    lay_wgt = lay_wgt * g     ;
    lay_wgt_var = lay_var * lay_wgt

    wgt_var = wgt_var + lay_wgt_var ;* 1/mean_levels)

  end do
  wgt_var = wgt_var * -1

  return(wgt_var)

end

;;--------------------------------------------------------------------
; this takes plots and arranges as panels
undef("panelize_2col")
function panelize_2col(var:numeric)

begin
  wks = "test"
  pres                = True              ; mod panel plot
  pres@lbLabelStride  = 7             ; skip every other label
  pres@gsnPanelBottom = 0.05              ; add some space at bottom
  pres@gsnPanelLabelBar = True                   ; add common colorbar

  pres@txString         = "Skin Temperature "      ; add common title
;;  gsn_panel(wks,plot,(/noft/2 , 2/),pres)        ; create panel plot

end

;;--------------------------------------------------------------------
; function to retrieve diagnosis variable
; this is companion of wrf_user_getvar
;  T -> theta with removed offset
;  tc ->  tempereture in celcious [not yet implimented]
undef("wrf_my_getvar")
function wrf_my_getvar(file_handle,var_in:numeric,t_in:integer)
local test,fh,var,T,tin
begin
  fh = file_handle
  var = var_in(0)
  tin = t_in(0)
  if ( var .eq. "T" ) then
    T = wrf_user_getvar(fh,"T",tin)
    T = T + 300
    return(T)
  end if

  if ( var .eq. "tc" ) then
    return
  end if


end

;---------------------------------------------------------------------
; Fuction: set_inputfile
; Doc:
;
;---------------------------------------------------------------------
undef("set_inputfile")
function set_inputfile(env_in)
local env,fh
begin
  env=env_in
  if ( (env_in) ) then
    env = env_in
  else
    env = "NCL_FIN"
  end if
  fname = getenv(env)
  fh = addfile(fname,"r")
  return fh
end

;---------------------------------------------------------------------
; Fuction: draw_cs_line
; Doc:
;
;---------------------------------------------------------------------
undef("draw_cs_line")
function draw_cs_line(plane_in,opts:logical)
local t

begin


  return False
end
;- |draw_cs_line| ends here --

;---------------------------------------------------------------------
; Fuction: last
; Doc: returns the last index
;
;---------------------------------------------------------------------
undef("last")
function last(fh_in,varname_in:string,dim_in:integer)
local var,fh,var_in_file,last_ind,dim
begin
  varname= varname_in
  dim = dim_in

  if ( typeof(fh_in) .eq. "file" ) then
    ISFILE = True
    fh = fh_in
  else
    print("last: first argument is not a file handle")
    return
  end if

  dims = filevardimsizes(fh,varname)
  last_ind = dims(dim) - 1
  return last_ind

end
;- |last| ends here --

;---------------------------------------------------------------------
; Fuction: wv_wrf_ll_to_ij
; Doc:
;
;---------------------------------------------------------------------
undef("wv_wrf_ll_to_ij")
function wv_wrf_ll_to_ij(fh_in,lonin:float, latin:float)
local fh,opt,loc

begin

  if ( typeof(fh_in) .eq. "file" ) then
    ISFILE = True
    fh = fh_in
  else
    print("fatal: last argument is not a file handle")
    return
  end if

  opt = True
  opt@MAP_PROJ  = fh@MAP_PROJ
  opt@TRUELAT1  = fh@TRUELAT1
  opt@TRUELAT2  = fh@TRUELAT2
  opt@STAND_LON = fh@STAND_LON
  opt@DX        = fh@DX
  opt@DY        = fh@DY

  XLAT  = fh->XLAT(0,:,:)
  XLONG = fh->XLONG(0,:,:)

  opt@REF_LAT = XLAT(0,0)
  opt@REF_LON = XLONG(0,0)
  opt@KNOWNI  = 1.0
  opt@KNOWNJ  = 1.0

  loc = wrf_ll_to_ij ( lonin, latin, opt )

  return loc
end
;- "wv_wrf_ll_to_ij" ends here --

undef("set_zoom_in")
function set_zoom_in(x1,y1,x2,y2,map_args[1]:logical)
local x1,y1,x2,y2,map_args

begin

  map_args@ZoomIn = True
  map_args@Xstart = x1
  map_args@Ystart = y1
  map_args@Xend   = x2
  map_args@Yend   = y2

  return(map_args)

end
;- "set_zoom_in" ends here --

; Fuction: hgt_contour
; Doc:
;
;---------------------------------------------------------------------
undef("hgt_contour")
function hgt_contour(nc_file[1]:file,opt_args[1]:logical)
local opt_args


begin

  opt_args = set_no_frame_res(opt_args)

  Z = nc_file->HGT(0,:,:)

  lat_wrf = nc_file->XLAT(0,:,:)
  lon_wrf = nc_file->XLONG(0,:,:)

  wks = gsn_open_wks("png", "terrain")
  gsn_define_colormap(wks, "OceanLakeLandSnow")

  opt_args = True
  opt_args@cnFillOn = True
  opt_args@cnLinesOn = True
  opt_args@gsnSpreadColors = True
  opt_args@gsnPaperMargin = 1.
  opt_args@pmTickMarkDisplayMode = "Always"
  opt_args@gsnAddCyclic = False
  opt_args@sfXArray = lon_wrf
  opt_args@sfYArray = lat_wrf
  opt_args@mpLimitMode = "LatLon"
  opt_args@cnLevelSelectionMode = "ExplicitLevels"
  opt_args@cnLevels = fspan(0.,3000., 12)
  opt_args = wrf_map_opt_argsources(wrf,opt_args)

  projection = opt_args@mpProjection
  opt_args@mpMinLatF =   opt_args@start_lat
  opt_args@mpMaxLatF =   opt_args@end_lat
  opt_args@mpMinLonF =   opt_args@start_lon
  opt_args@mpMaxLonF =   opt_args@end_lon
  opt_args@tiMainString = "Digital Elevation Model"

  opt_args = set_no_frame_res(opt_args)

  plot = gsn_csm_contour_map(wks, Z, opt_args)
  return(plot)

end
;- "hgt_contour" ends here --

;;; wrf.ncl ends here