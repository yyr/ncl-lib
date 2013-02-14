; this takes plots and arranges as panels
undef("panelize_2col")
procedure panelize_2col(wks:graphic,plot:graphic,pres:logical)
begin

  pres@lbLabelStride  = 3                 ; skip every other label
  pres@gsnPanelBottom = 0.05              ; add some space at bottom
  pres@gsnPanelLabelBar = True            ; add common colorbar
  pres@gsnMaximize = True

  psize = dim_len0(plot)

  if ( isodd(psize) ) then
    gsn_panel(wks,plot,(/ (psize / 2) +1 ,2/),pres)
  else
    gsn_panel(wks,plot,(/ (psize / 2) , 2/),pres)
  end if

  ; if ( psize % 2 .gt. 0 ) then  ; check for odd number of plots
  ; else
  ; end if

  return
end

;;; generic_plot.ncl ends here
