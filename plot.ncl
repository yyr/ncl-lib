;_____________________________________________________________________________
; procedure: panelize
; Doc:
;_____________________________________________________________________________
undef("panelize")
procedure panelize(wks:graphic,plot:graphic,view_port_dim:integer,pres:logical)

begin
  pres@lbLabelStride  = 3                 ; skip every other label
  pres@gsnPanelBottom = 0.05              ; add some space at bottom
  pres@gsnPanelLabelBar = True            ; add common colorbar
  pres@gsnMaximize = True

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
