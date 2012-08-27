load "$lib_dir/yagUtils.ncl"

begin

    a = wrf_input_file("wrfout")

    th_v = wrf_my_getvar(a, "th_v",0) ; my_getvar handle
    th = wrf_my_getvar(a, "th",0) ; my_getvar handle
    printVarSummary(th)
    printVarSummary(th_v)

end
