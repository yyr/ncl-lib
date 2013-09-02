import("WRFUserARW")

;__________________ I/O ________________________________________

;_____________________________________________________________________________
; Function: no_of_levels
;      Doc: Spitsout number of levels in varailbe
;_____________________________________________________________________________
undef("no_of_levels")
function no_of_levels( f:file,varname:string)
local var
begin
  var = f->$varname$
  dims = dimsizes(var)

  if ( Leng(dims).le.2) then

  end if

end

;_____________________________________________________________________________
; wrf_user_getvar_weighted_sum:
;          Calculate weight of the layer will be calculated using
;          hydrostatic equation.
;_____________________________________________________________________________
undef("wrf_user_getvar_weighted_sum")
function wrf_user_getvar_weighted_sum(file_handle,var_in:string, time:integer)
local var, var, ph,phb,pres,gh,dim, wgt_var, noflevels, \
lay_var,dgh,dp, lay_wgt, lay_wgt_var, wgt_var,time,g

begin
  g = 9.8                       ; gravity
  noflevels = 14

; check the file handle is okay
  if(typeof(file_handle).eq."file") then
    ISFILE = True
    nc_file = file_handle
  else
    print("wrf_user_getvar: error: the first argument must be" + \
          "a file or a list of files opened with addfile or addfiles")
    return
  end if

; get var we need to return
  if ( dim_len0(var_in) .eq. 1) then
    var = wrf_user_getvar(nc_file,var_in,time)
  else
    var = wrf_user_getvar(nc_file,var_in(0),time)
    do it = 1, dim_len0(var_in) - 1, 1
      var = var + wrf_user_getvar(nc_file,var_in(0),time)
    end do
  end if

  ph = wrf_user_getvar(nc_file,"PH",time)
  phb = wrf_user_getvar(nc_file,"PHB",time)
  pres = wrf_user_getvar(nc_file,"pressure",time)
  gh = ph + phb               ;geo potential height

  dim = dimsizes(var)
  wgt_var = new((/ dim(1),dim(2) /),typeof(var))

  wgt_var = 0                   ;intialize
  do z = 0, noflevels, 1   ; z level
    lay_var = (var(z+1,:,:) + var(z,:,:)) / 2. ; mean var

    dgh = gh(z+1,:,:) - gh(z,:,:) ; 𝑑𝑧
    dp = pres(z+1,:,:) - pres(z,:,:) ; 𝑑𝑝
    lay_wgt = -1 * (dp/dgh) / g    ;  𝜚 = - 𝑑𝑝/𝑑𝑧 / 𝑔
    lay_wgt_var = lay_var * lay_wgt
    wgt_var = wgt_var + lay_wgt_var
  end do
  return(wgt_var)
end

;_____________________________________________________________________________
; Function: wrf_my_getvar
; Doc: a wrapper function of in built wrf_my_getvar to retrieve diagnosis
;      variables from wrf output file
;_____________________________________________________________________________

undef("wrf_my_getvar")
function wrf_my_getvar(file_handle:file,var_in:string,t_in:integer)
local test,fh,var,T,tin,qv,ql,my_get_vars

begin
  my_get_vars = (/"th_v", "tc"/)

  fh = file_handle
  var = var_in
  tin = t_in

  if ( .not.any(var .eq. my_get_vars)) then
    ;; call the wrf_user_getvar if asked data cannot be handled in this
    ;; function.

    return(wrf_user_getvar(fh,var,tin))

  else
    ;; start obtaining variables from file for given string

    if ( var .eq. "th_v" ) then
      T = wrf_user_getvar(fh,"T",tin)
      T = T + 300

      qv = wrf_user_getvar(fh,"QVAPOR",tin)
      ql = wrf_user_getvar(fh,"QCLOUD",tin)

      ;; virtual portential temperature formula
      ;; th_v = th (1 + 0.61 * r - r_L)
      ;; th_v : virt pot temp
      ;; th   : potential temp
      ;; r    : mixing ratio of water vapor
      ;; r_L  : mixing ratio of liquid water

      th_v = T * ( 1 + 0.61 * qv - ql)
      copy_VarAtts(T,th_v)
      th_v@description = "Virtual Potential Temperature"
      return(th_v)
    end if

    if ( var .eq. "tc" ) then
      return
    end if

  end if                        ; outer if
  return
end

;---------------------------------------------------------------------
; Function: draw_cs_line
; Doc:
;
;---------------------------------------------------------------------
undef("draw_cs_line")
function draw_cs_line(plane_in,opts:logical)
local t

begin

  return False
end

;---------------------------------------------------------------------
; Function: last
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
    fh = fh_in
  else
    print("last: first argument is not a file handle")
    return
  end if

  dims = filevardimsizes(fh,varname)
  last_ind = dims(dim) - 1
  return last_ind

end

;---------------------------------------------------------------------
; Function: wv_wrf_ll_to_ij
; Doc:
;
;---------------------------------------------------------------------
undef("wv_wrf_ll_to_ij")
function wv_wrf_ll_to_ij(fh_in,lonin:float, latin:float)
local fh,opt,loc

begin

  if ( typeof(fh_in) .eq. "file" ) then
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

;_____________________________________________________________________________
; Function: set_zoom_in
; Doc:
;
;_____________________________________________________________________________
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

;_____________________________________________________________________________
; Function: hgt_contour
; Doc:
;    wks:
;    nc_file:
;    opt_args:
;
;_____________________________________________________________________________
undef("hgt_contour")
function hgt_contour(nc_file[1]:file,wks:graphic,opt_args[1]:logical)
local opt_args

begin

  Z = nc_file->HGT(0,:,:)

  lat_wrf = nc_file->XLAT(0,:,:)
  lon_wrf = nc_file->XLONG(0,:,:)

  set_colormap(wks,"hgt")

  opt_args = set_res_no_frame(opt_args)
  opt_args = set_res_cn(opt_args)
  opt_args = set_high_res_coast(opt_args)

  opt_args@gsnPaperMargin = 1.
  opt_args@gsnAddCyclic = False
  opt_args@gsnLeftString = ""
  opt_args@gsnRightString = ""

  opt_args@sfXArray = lon_wrf
  opt_args@sfYArray = lat_wrf
  opt_args@cnLevelSelectionMode = "ExplicitLevels"
  opt_args@cnLevels = (/1.,100.,200.,400.,800.,1600.,2400./)

  opt_args = wrf_map_resources(nc_file,opt_args)
  opt_args@mpGridLineColor       =  1       ; Turn off grid lat/lon lines
  opt_args@mpGridAndLimbOn       =  True
  opt_args@pmLabelBarHeightF = 0.1

  opt_args@tiMainString = "Model Domain"
  plot = gsn_csm_contour_map(wks, Z, opt_args)

  return(plot)
end

;_____________________________________________________________________________
; Function: wrf_attach_coords
; Doc:
;_____________________________________________________________________________
undef("wrf_attach_coords")
function wrf_attach_coords(in_file:file,arg_in:logical)
local arg_in

begin


  return(arg_out)
end

;_____________________________________________________________________________
; procedure: draw_time_string
; Doc:
;_____________________________________________________________________________
undef("draw_time_string")
procedure draw_time_string(cn[1]:graphic,res:logical)

begin

  anno = NhlAddAnnotation(cn,txt0)
  setvalues anno
    "amZone"           : 3
    "amSide"           : "Top"
    "amJust"           : res@MainTitlePos
    "amParallelPosF"   : res@MainTitlePosF
    "amOrthogonalPosF" : MTOPosF
    "amResizeNotify"   : False
  end setvalues

  return
end

;_____________________________________________________________________________
; Function: wrf_line_coords_between_pts
; Doc:
;_____________________________________________________________________________
undef("wrf_line_coords_between_pts")
function wrf_line_coords_between_pts(in_file:file,pts:numeric)
local xlat,xlon, lon,lat

begin
  xlat = in_file->XLAT(0,:,:)
  xlon = in_file->XLONG(0,:,:)

  if ( dim_len0(pts) .ne. 4 ) then
    announce("fatal:points should be 4 values")
    return
  end if
  lat = wrf_user_intrp2d(xlat,pts,0.,True)
  lon = wrf_user_intrp2d(xlon,pts,0.,True)

  return((/lon,lat/))
end


;_____________________________________________________________________________
; Function: wrf_div
; Doc: calculate and return divergence
;_____________________________________________________________________________
undef("wrf_div")
function wrf_div(u:numeric,v:numeric,dx:numeric,dy:numeric, \
                 msft:numeric)
local div, dx ,dy, m2, i, j, nx, ny, dux, duy, dudx, dudy

begin

  ; divergence: m^2 * [ d/dx(A/m) + d/dy(B/m) ]
  ; curl: m^2 * [ d/dx(B/m) - d/dy(A/m) ],
  ; m = map factor,
  ; A, B components of vector field.

  ny = dim_len0(u)
  nx = dim_len1(u)

  div = new((/ny,nx/),float)

  do j = 0, ny - 1, 1
    jp1 = min((/j+1,ny-1/))
    jm1 = max((/j-1,0/))
    do i = 0, dim_len1(u) - 1 , 1
      ip1 = min((/i+1,nx - 1/))
      im1 = max((/i-1,0/))

      dsx = (ip1-im1)*dx
      dsy = (jp1-jm1)*dy
      mm = msft(j,i) * msft(j,i)

      dudx = (u(j,i)/msft(j,ip1) - u(j,im1)/msft(j,im1)) / dsx
      dudy = (v(jp1,i)/msft(jp1,i) - v(jm1,i)/msft(jm1,i)) / dsy
      dudx = dudx * mm
      dudy = dudy * mm

      div(j,i) = dudx + dudy

    end do
  end do
  div!0 = "south_north"
  div!1 = "west_east"
  div@description = "divergence"

  return(div)
end

;_____________________________________________________________________________
; Function: wrf_div2
; Doc: calculate and return divergence
;_____________________________________________________________________________
undef("wrf_div2")
function wrf_div2(u:numeric,v:numeric,dx:numeric,dy:numeric, \
                  msft:numeric, mu:numeric,mv:numeric)
local div, dx ,dy, m2, i, j, nx, ny, dux, duy, dudx, dudy

begin

  ; divergence: m^2 * [ d/dx(A/m) + d/dy(B/m) ]
  ; curl: m^2 * [ d/dx(B/m) - d/dy(A/m) ],
  ; m = map factor,
  ; A, B components of vector field.

  ny = dim_len0(u)
  nx = dim_len1(u)

  div = new((/ny,nx/),float)

  do j = 0, ny - 1, 1
    jp1 = min((/j+1,ny-1/))
    jm1 = max((/j-1,0/))
    do i = 0, dim_len1(u) - 1 , 1
      ip1 = min((/i+1,nx - 1/))
      im1 = max((/i-1,0/))

      dsx = (ip1-im1)*dx
      dsy = (jp1-jm1)*dy
      mm = msft(j,i) * msft(j,i)
      mu_l = mu(j,ip1)
      mu_r = mu(j,im1)

      dudx = (u(j,i)/mu_l - u(j,im1)/mu_r) / dsx
      dudy = (v(jp1,i)/mv(jp1,i) - v(jm1,i)/mv(jm1,i)) / dsy
      dudx = dudx * mm
      dudy = dudy * mm

      div(j,i) = dudx + dudy
    end do
  end do
  div!0 = "south_north"
  div!1 = "west_east"
  div@description = "divergence"
  return(div)
end

;;; wrf.ncl ends here
