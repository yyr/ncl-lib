
; this takes plots and arranges as panels
undef("panelize_2col")
function panelize_2col(var:numeric)

begin
  wks = "test"
  pres                = True              ; mod panel plot
  pres@lbLabelStride  = 7             ; skip every other label
  pres@gsnPanelBottom = 0.05              ; add some space at bottom
  pres@gsnPanelLabelBar = True                   ; add common colorbar

  pres@txString         = "Skin Temperature "      ; add common title
;;  gsn_panel(wks,plot,(/noft/2 , 2/),pres)        ; create panel plot

  return (pres)

end
;;; generic_plot.ncl ends here
