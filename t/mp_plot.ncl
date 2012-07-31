load "$lib_dir/yagUtils.ncl"
load "$lib_dir/WRFUserARW.ncl"

begin

  a = wrf_input_file("wrfout")
  wks = gsn_open_wks("png","mp_plot")

  mp_res = wrf_map_resources(a,True)  ; set all map res
  mp_res = set_high_res_coast(mp_res) ; high resultion

  mp  = wrf_map(wks,a,mp_res)

  draw(wks)
  frame(wks)

end
