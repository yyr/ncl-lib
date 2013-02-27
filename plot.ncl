import("gsn_code")
import("gsn_csm")

;_____________________________________________________________________________
; procedure: panelize
; Doc:
;_____________________________________________________________________________
undef("panelize")
procedure panelize(wks:graphic,plot:graphic,view_port_dim:integer,pres:logical)
local res_attr

begin
  res_attr = (/ "lbLabelStride" , "3",       \
          "gsnPanelBottom"      , "0.05",    \
          "gsnPanelLabelBar"    , "True",    \
          "gsnMaximize"         , "True",    \
          "lbOrientation"       , "vertical" \
  /)
  pres = set_res_value_keep(pres,res_attr)
  gsn_panel(wks,plot,view_port_dim,pres)
  return
end

; this takes plots and arranges as panels
undef("panelize_2col")
procedure panelize_2col(wks:graphic,plot:graphic,pres:logical)
begin
  psize = dim_len0(plot)
  panelize(wks,plot,(/ (psize / 2) ,2/),pres)
  return
end

;_____________________________________________________________________________
; procedure: panelize_3col
; Doc:
;_____________________________________________________________________________
undef("panelize_3col")
procedure panelize_3col(wks:graphic,plot:graphic,pres:logical)

begin
  psize = dim_len0(plot)
  panelize(wks,plot,(/ (psize / 3) ,3/),pres)
  return
end
;;; generic_plot.ncl ends here
