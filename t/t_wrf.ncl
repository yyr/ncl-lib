; Description:
;


load "./run_test.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$nsc/WRFUserARW.ncl"
load "$nsc/wrf.ncl"

begin

  a = wrf_input_file("wrfout")
  xy = wrf_line_coords_between_pts(a,(/2,6,2,8/))

  print(xy)


end
;;; t_wrf.ncl ends here
