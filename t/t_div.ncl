load "./run_test.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$nsc/WRFUserARW.ncl"
load "$nsc/resources.ncl"
load "$nsc/wrf.ncl"

begin
  a = wrf_input_file("wrfout")
  it = 10

  u = wrf_user_getvar(a,"U10",10)
  v = wrf_user_getvar(a,"V10",10)
  mx = wrf_user_getvar(a,"MAPFAC_M",10)
  dx = 1500
  dy = dx

  div = wrf_div(u,v,dx,dy,mx)

end
;;; t_div.ncl ends here
