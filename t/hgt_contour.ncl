load "$lib_dir/yagUtils.ncl"

begin

  a = wrf_input_file("wrfout")

  wks = gsn_open_wks("png","hgt_cont")

  hgt = hgt_contour(a,wks,True)

  mp_res = wrf_map_resources(a,True)
  mp  = wrf_map(wks,a,mp_res)

  overlay(mp,hgt)

  draw(wks)
  frame(wks)

end
