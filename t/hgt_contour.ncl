load "$lib_dir/yagUtils.ncl"
load "$lib_dir/WRFUserARW.ncl"

begin

  a = wrf_input_file("wrfout")

  wks = gsn_open_wks("png","hgt_cont")

  opts = True
  pl = hgt_contour(a,wks,opts)
  hgt = wrf_map_overlays(a,wks,(/pl/),True,True)
end
