; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
;    File: anno.ncl
; Created: 金曜日, 11月 30 2012

; Description:
; Annotation library.

;_____________________________________________________________________________
; procedure: anno_top_left
; Doc:
;_____________________________________________________________________________
undef("anno_top_left")
procedure anno_top_left(wk:graphic,plot:graphic,txtstring)
local txt

begin

  txt = create "map_titles" textItemClass wk
    "txString"      : txtstring
    "txFontHeightF" : 0.02
    ;"txFontColor"   : font_color
  end create
  anno = NhlAddAnnotation(plot,txt)
  setvalues anno
    "amZone"           : 3
    "amJust"           : "BottomLeft"
    "amSide"           : "Top"
    "amParallelPosF"   : 0.005
    "amOrthogonalPosF" : 0.03
    "amResizeNotify"   : False
  end setvalues

  return
end

;;; anno.ncl ends here
