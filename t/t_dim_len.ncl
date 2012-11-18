load "$nsc/t/run_test.ncl"
load "$nsc/generic.ncl"

begin

  var = new((/2,4,8,10/),integer)

  print(dim_len(var,0))
  print(dim_len(var,1))
  print(dim_len(var,2))
  print(dim_len(var,3))
  print(dim_len(var,4))         ; this should be fatal

  print(dim_len0(var))
  print(dim_len1(var))
  print(dim_len2(var))

end
