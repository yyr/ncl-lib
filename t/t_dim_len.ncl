load "$nsc/yagUtils.ncl"

begin

  var = new((/2,4,8,10/),integer)

  print(dim_len(var,0))
  print(dim_len(var,1))
  print(dim_len(var,2))
  print(dim_len(var,3))
  print(dim_len(var,4))         ; this should be fatal

end
