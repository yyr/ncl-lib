;    File: wps.ncl
; Created: 月曜日, 8月 20 2012

import("WRFUserARW")


;_____________________________________________________________________________
; Function: wps_parse_namelist_for_domain
; Doc: parse namelist.wps and set domain specific resources.
;
;_____________________________________________________________________________
undef("wps_parse_namelist_for_domain")
function wps_parse_namelist_for_domain(wpsFileName:string,res_in:logical)
local res_out,parent_id, parent_grid_ratio,j_parent_start,e_sn,e_we,test

begin
  res_out = res_in

  res_out@max_dom   = stringtoint  (systemfunc("grep max_dom    " +wpsFileName+ " | cut -f2 -d'=' | cut -f1 -d','" ) )
  res_out@dx        = stringtofloat(systemfunc("grep dx         " +wpsFileName+ " | cut -f2 -d'=' | cut -f1 -d','" ) )
  res_out@dy        = stringtofloat(systemfunc("grep dy         " +wpsFileName+ " | cut -f2 -d'=' | cut -f1 -d','" ) )
  res_out@ref_lat   = stringtofloat(systemfunc("grep ref_lat    " +wpsFileName+ " | cut -f2 -d'=' | cut -f1 -d','" ) )
  res_out@ref_lon   = stringtofloat(systemfunc("grep ref_lon    " +wpsFileName+ " | cut -f2 -d'=' | cut -f1 -d','" ) )
  test = systemfunc("grep truelat1 " +wpsFileName )

  if ( .not. ismissing(test) )
    res_out@truelat1  = stringtofloat(systemfunc("grep truelat1   " +wpsFileName+ " | cut -f2 -d'=' | cut -f1 -d','" ) )
  else
    res_out@truelat1  = 0.0
  end if
  test = systemfunc("grep truelat2 " +wpsFileName )
  if ( .not. ismissing(test) )
    res_out@truelat2  = stringtofloat(systemfunc("grep truelat2   " +wpsFileName+ " | cut -f2 -d'=' | cut -f1 -d','" ) )
  else
    res_out@truelat2  = 0.0
  end if
  res_out@stand_lon = stringtofloat(systemfunc("grep stand_lon  " +wpsFileName+ " | cut -f2 -d'=' | cut -f1 -d','" ) )

  test = systemfunc("grep lambert " +wpsFileName )
  if ( .not. ismissing(test) )
    res_out@map_proj          = "lambert"
  end if
  test = systemfunc("grep mercator " +wpsFileName )
  if ( .not. ismissing(test) )
    res_out@map_proj          = "mercator"
  end if
  test = systemfunc("grep polar " +wpsFileName )
  if ( .not. ismissing(test) )
    res_out@map_proj          = "polar"
  end if
  testa = systemfunc("grep 'lat-lon' " +wpsFileName )
  if ( .not. ismissing(testa) )
    res_out@map_proj          = "lat-lon"
    res_out@pole_lat = stringtofloat(systemfunc("grep pole_lat  " +wpsFileName+ " | cut -f2 -d'=' | cut -f1 -d','" ) )
    res_out@pole_lon = stringtofloat(systemfunc("grep pole_lon  " +wpsFileName+ " | cut -f2 -d'=' | cut -f1 -d','" ) )
  end if

  parent_id         = new ( res_out@max_dom , integer )
  parent_grid_ratio = new ( res_out@max_dom , integer )
  i_parent_start    = new ( res_out@max_dom , integer )
  j_parent_start    = new ( res_out@max_dom , integer )
  e_we              = new ( res_out@max_dom , integer )
  e_sn              = new ( res_out@max_dom , integer )

  do n = 1, res_out@max_dom

    n0 = n - 1
    parent_id(n0)         = stringtoint(systemfunc("grep parent_id         " +wpsFileName+ " | cut -f2 -d'=' | cut -f"+n+" -d','" ) )
    parent_grid_ratio(n0) = stringtoint(systemfunc("grep parent_grid_ratio " +wpsFileName+ " | cut -f2 -d'=' | cut -f"+n+" -d','" ) )
    i_parent_start(n0)    = stringtoint(systemfunc("grep i_parent_start    " +wpsFileName+ " | cut -f2 -d'=' | cut -f"+n+" -d','" ) )
    j_parent_start(n0)    = stringtoint(systemfunc("grep j_parent_start    " +wpsFileName+ " | cut -f2 -d'=' | cut -f"+n+" -d','" ) )
    e_we(n0)              = stringtoint(systemfunc("grep e_we              " +wpsFileName+ " | cut -f2 -d'=' | cut -f"+n+" -d','" ) )
    e_sn(n0)              = stringtoint(systemfunc("grep e_sn              " +wpsFileName+ " | cut -f2 -d'=' | cut -f"+n+" -d','" ) )

  end do

  res_out@parent_id         = parent_id
  res_out@parent_grid_ratio = parent_grid_ratio
  res_out@i_parent_start    = i_parent_start
  res_out@j_parent_start    = j_parent_start
  res_out@e_we              = e_we
  res_out@e_sn              = e_sn

  return(res_out)
end


;_____________________________________________________________________________
; Function: wps_resolve_domain_type
; Doc:
;
;_____________________________________________________________________________
undef("wps_resolve_domain_type")
function wps_resolve_domain_type(res:logical,mpres:logical)

begin

  res@DX = mpres@dx
  res@DY = mpres@dy
  res@LATINC = 0.0
  res@LONINC = 0.0

  if ( mpres@map_proj .eq. "lambert") then
    mpres@map_proj = 1
    res@MAP_PROJ = 1
  end if

  if ( mpres@map_proj .eq. "polar") then
    mpres@map_proj = 2
    res@MAP_PROJ = 2
  end if

  if ( mpres@map_proj .eq. "mercator") then
    mpres@map_proj = 3
    res@MAP_PROJ = 3
  end if

  if ( mpres@map_proj .eq. "lat-lon") then
    mpres@map_proj = 6
    res@MAP_PROJ = 6
    res@LATINC = mpres@dy
    res@LONINC = mpres@dx
  end if

  res@TRUELAT1 = mpres@truelat1
  res@TRUELAT2 = mpres@truelat2
  res@STAND_LON = mpres@stand_lon

  res@REF_LAT = mpres@ref_lat
  res@REF_LON = mpres@ref_lon
  if ( isatt(mpres,"ref_x") ) then
    res@KNOWNI = mpres@ref_x
  else
    res@KNOWNI = int2flt(mpres@e_we(0))/2.
  end if
  if ( isatt(mpres,"ref_y") ) then
    res@KNOWNJ = mpres@ref_y
  else
    res@KNOWNJ = int2flt(mpres@e_sn(0))/2.
  end if

  if ( isatt(mpres,"pole_lat") ) then
    res@POLE_LAT = mpres@pole_lat
  else
    res@POLE_LAT = 90.0
  end if
  if ( isatt(mpres,"pole_lon") ) then
    res@POLE_LON = mpres@pole_lon
  else
    res@POLE_LON = 0.0
  end if

  return(res)
end

;_____________________________________________________________________________
; Function: wrf_wps_dom
; Doc:
;
;_____________________________________________________________________________
undef("wrf_wps_dom")
function wrf_wps_dom(wks[1]:graphic,mp:graphic,opt_args[1]:logical,lnres[1]:logical,txres[1]:logical)

begin

  mpres = opt_args

  res = True
  res = wps_resolve_domain_type(res,mpres)

  xx = 1.0
  yy = 1.0
  loc = wrf_ij_to_ll (xx,yy,res)
  start_lon = loc(0)
  start_lat = loc(1)
  xx = int2flt(mpres@e_we(0))
  yy = int2flt(mpres@e_sn(0))
  loc = wrf_ij_to_ll (xx,yy,res)
  end_lon = loc(0)
  end_lat = loc(1)

  mpres@start_lat   = start_lat
  mpres@start_lon   = start_lon
  mpres@end_lat     = end_lat
  mpres@end_lon     = end_lon

  ; mp = wrf_wps_map(wks,mpres)
  ; draw(mp)

  if ( mpres@max_dom .gt. 1 ) then

    numLineColors = 0
    if ( isatt(lnres,"domLineColors") ) then
      numLineColors = dimsizes(lnres@domLineColors)
    end if

    do idom = 1,mpres@max_dom-1

      if ( numLineColors .gt. 0 ) then
        if ( numLineColors .ge. idom ) then
          lnres@gsLineColor = lnres@domLineColors(idom-1)
          txres@txFontColor = lnres@domLineColors(idom-1)
        else
          lnres@gsLineColor = lnres@domLineColors(numLineColors-1)
          txres@txFontColor = lnres@domLineColors(numLineColors-1)
        end if
      end if


      ; nest start and end points in large domain space
      if ( mpres@parent_id(idom) .eq. 1) then
        ; corner value
        i_start = mpres@i_parent_start(idom)
        j_start = mpres@j_parent_start(idom)
        ; end point
        i_end = (mpres@e_we(idom)-1)/mpres@parent_grid_ratio(idom) + i_start
        j_end = (mpres@e_sn(idom)-1)/mpres@parent_grid_ratio(idom) + j_start
      end if
      if ( mpres@parent_id(idom) .ge. 2) then
        ; corner value
        nd = mpres@parent_id(idom)
        i_points = ((mpres@e_we(idom)-1)/mpres@parent_grid_ratio(idom))
        j_points = ((mpres@e_sn(idom)-1)/mpres@parent_grid_ratio(idom))
        ai_start = mpres@i_parent_start(idom)*1.0
        aj_start = mpres@j_parent_start(idom)*1.0
        do while ( nd .gt. 1)
          ai_start = ai_start/mpres@parent_grid_ratio(nd-1) + mpres@i_parent_start(nd-1)
          aj_start = aj_start/mpres@parent_grid_ratio(nd-1) + mpres@j_parent_start(nd-1)
          i_points = (i_points/mpres@parent_grid_ratio(nd-1))
          j_points = (j_points/mpres@parent_grid_ratio(nd-1))
          ;nd = nd - 1
          nd = mpres@parent_id(nd-1)
        end do
        i_start = tointeger(ai_start + .5 )
        j_start = tointeger(aj_start + .5 )
        ; end point
        i_end = i_points + i_start + 1
        j_end = j_points + j_start + 1
      end if

      ; get the four corners

      xx = int2flt(i_start)
      yy = int2flt(j_start)
      loc = wrf_ij_to_ll (xx,yy,res)
      lon_SW = loc(0)
      lat_SW = loc(1)

      xx = int2flt(i_end)
      yy = int2flt(j_start)
      loc = wrf_ij_to_ll (xx,yy,res)
      lon_SE = loc(0)
      lat_SE = loc(1)

      xx = int2flt(i_start)
      yy = int2flt(j_end)
      loc = wrf_ij_to_ll (xx,yy,res)
      lon_NW = loc(0)
      lat_NW = loc(1)

      xx = int2flt(i_end)
      yy = int2flt(j_end)
      loc = wrf_ij_to_ll (xx,yy,res)
      lon_NE = loc(0)
      lat_NE = loc(1)

      xbox = (/lon_SW, lon_SE, lon_NE, lon_NW, lon_SW /)
      ybox = (/lat_SW, lat_SE, lat_NE, lat_NW, lat_SW /)
      x_out = new(dimsizes(xbox),typeof(xbox))
      y_out = new(dimsizes(ybox),typeof(ybox))
      datatondc(mp, xbox, ybox, x_out, y_out)
      gsn_polyline_ndc(wks, x_out, y_out, lnres)

      idd = idom + 1
      dom_text = "d0"+idd
      if ( txres@txJust .eq. "BottomLeft" ) then
        gsn_text(wks,mp,dom_text,lon_NW,lat_NW,txres)
      else
        gsn_text_ndc(wks,dom_text,x_out(3)+0.01,y_out(3)-0.01,txres)
      end if

    end do

  end if
  return(mp)
end
;;; wps.ncl ends here
