;    File: wps.ncl
; Created: 月曜日, 8月 20 2012

;_____________________________________________________________________________
; Fuction: wps_parse_namelist_for_domain
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

;;; wps.ncl ends here
