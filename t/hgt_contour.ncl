load "$lib_dir/yagUtils.ncl"

begin

  a = wrf_input_file("wrfout")
  wks = gsn_open_wks("png","contour_hgt")
  hgt = hgt_contour(a,wks,True)

  draw(wks)
  frame(wks)

end
