; Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
;    File: generic.ncl
; Created: Tuesday, July 24 2012
; License: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>
;

;; define exit_codes
coerce_error = 2
arg_error = 4
resource_error = 8

;_____________________________________________________________________________
; procedure: announce
; Doc: just announces stdout what ever given with print statement. This uses
;      system function "echo".
;_____________________________________________________________________________
undef("announce")
procedure announce(var_in:string)

begin
  system("echo ")
  system("echo ___________________________________________________________")
  system("echo " + var_in)
  system("echo ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯")
  system("echo ")
end

;_____________________________________________________________________________
; procedure: print_fatal
; Doc:
;_____________________________________________________________________________
undef("print_fatal")
procedure print_fatal(ferror)
local ferror

begin
  system("echo ")
  system("echo " + "*FATAL: " + ferror)
  system("echo ")
  return
end


;_____________________________________________________________________________
; Function: rank_of
; Doc: return number of dimensions of a given variable.
;_____________________________________________________________________________
undef("rank_of")
function rank_of(var)
local dims
begin
  dims=dimsizes(var)
  return(dimsizes(dims))
end

;_____________________________________________________________________________
; Function: dim_len
; Doc: return the length of a given dimension(dim) of a variable.
;_____________________________________________________________________________
undef("dim_len")
function dim_len(var,dim)
local dims,length

begin
  dims = dimsizes(var)

  if ( dim + 1  .gt. rank_of(var) )  then
    print("Fatal: Given variable has less dimesions than query!")
    return
  end if

  length = dims(dim)
  return(length)
end

;_____________________________________________________________________________
; Function: dim_len0
; Doc: return zeroth dimesion lenth of variable
;_____________________________________________________________________________
undef("dim_len0")
function dim_len0(var)
begin
  return(dim_len(var,0))
end

;_____________________________________________________________________________
; Function: dim_len1
; Doc: return first dimesion lenth of variable
;_____________________________________________________________________________
undef("dim_len1")
function dim_len1(var)
begin
  return(dim_len(var,1))
end

;_____________________________________________________________________________
; Function: dim_len2
; Doc: return first dimesion lenth of variable
;_____________________________________________________________________________
undef("dim_len2")
function dim_len2(var)
begin
  return(dim_len(var,2))
end

;_____________________________________________________________________________
; Function: rank_of_file_var
; Doc: returns rank of a file variable.
;
;_____________________________________________________________________________
undef("rank_of_file_var")
function rank_of_file_var(file_in:file,var:string)
local nd,dims

begin
  dims = filevardimsizes(file_in,var)
  nd = dimsizes(dims)
  return(nd)
end

;_____________________________________________________________________________
; procedure: pp
; Doc:
;_____________________________________________________________________________
undef("pp")
procedure pp(str:string)

begin
  print(""+str)
  return
end

;_____________________________________________________________________________
; Function: angle_with_horizontal
; Doc: find angle between horizontal axis and line joining with given points in
;      the domain.
;_____________________________________________________________________________
undef("angle_with_horizontal")
function angle_with_horizontal(x1:numeric,x2:numeric,y1:numeric,y2:numeric)
local ang,x_proj,y_proj, x1_f, x2_f, y1_f, y2_f

begin

  ;; make sure they are floats
  x1_f = tofloat(x1)
  x2_f = tofloat(x2)
  y1_f = tofloat(y1)
  y2_f = tofloat(y2)

  x_proj = x2_f-x1_f
  y_proj = y2_f-y1_f

  ang = atan2(y_proj,x_proj)

  return(ang)
end

;---------------------------------------------------------------------
; Function: set_inputfile
; Doc:
;
;---------------------------------------------------------------------
undef("set_inputfile")
function set_inputfile()
local env,fh
begin
  env = "NCL_FIN"
  fname = getenv(env)
  if ( .not. ismissing(fname) ) then
    fh = addfile(fname,"r")
    else
      print_fatal("NCL_FIN environment is not set.")
     exit
  end if

  return fh
end

;_____________________________________________________________________________
; function: find_edge
; Doc: find next index of fillvalue/nonfillvalue
;_____________________________________________________________________________
undef("find_edge")
function find_edge(arr:logical,strt:integer,fin:integer)
local i,arr_t,truth_val
begin
  edge = strt
  truth_val = arr(strt)

  if ( truth_val  ) then
    arr_t = arr
  else
    arr_t = .not.(arr)
  end if

  if ( strt .eq. fin ) then     ; reached to end?
    return strt
  end if

  do i = strt+1 , fin, 1
    if ( arr_t(i) ) then
      continue
    else
      return i - 1
    end if
  end do
  return fin
end

;_____________________________________________________________________________
; Function : set_res_value_keep
;                res:logical
;                att_list
; Doc: Mass version of inbuilt get_res_value_keep. TODO: mixed type
;_____________________________________________________________________________
undef("set_res_value_keep")
function set_res_value_keep(res:logical,att_list)
begin
  do it = 0, dimsizes(att_list) -1 ,  2
    res@$att_list(it)$ = get_res_value_keep(res,att_list(it),att_list(it+1))
  end do
  return(res)
end

;_____________________________________________________________________________
; procedure: print_res_att
; Doc: print res attributes
;_____________________________________________________________________________
undef("print_res_att")
procedure print_res_att(res:logical)
local attr
begin
  attr = getvaratts(res)
  print ("START Printing attributes ===>")
  do it = 0 ,dim_len0(attr) - 1
    if ( isnumstring(res@$attr(it)$ ) ) then
      print(attr(it) + " => " + stringtofloat_or_int(res@$attr(it)$))
    else
      print(attr(it) + " => " + res@$attr(it)$)
    end if
  end do
  print ("<=== END")
  return
end

;;; generic.ncl ends here
