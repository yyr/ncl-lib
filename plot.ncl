import("gsn_code")
import("gsn_csm")

;_____________________________________________________________________________
undef("panelize")
procedure panelize(wks:graphic,plot:graphic,view_port_dim:integer,pres:logical)
local res_attr
begin
  gsn_panel(wks,plot,view_port_dim,pres)
  return
end

;_____________________________________________________________________________
; this takes plots and arranges as 2 column panels
undef("panelize_2col")
procedure panelize_2col(wks:graphic,plot:graphic,pres:logical)
begin
  psize = dim_len0(plot)
  panelize(wks,plot,(/ (psize / 2) ,2/),pres)
  return
end

;_____________________________________________________________________________
; this takes plots and arranges as 1 column panels
undef("panelize_1col")
procedure panelize_1col(wks:graphic,plot:graphic,pres:logical)
begin
  psize = dim_len0(plot)
  panelize(wks,plot,(/ psize , 1/),pres)
  return
end

;_____________________________________________________________________________
; this takes plots and arranges as 3 column panels
undef("panelize_3col")
procedure panelize_3col(wks:graphic,plot:graphic,pres:logical)

begin
  psize = dim_len0(plot)
  panelize(wks,plot,(/ (psize / 3) ,3/),pres)
  return
end
;;; generic_plot.ncl ends here
