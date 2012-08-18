load "$lib_dir/yagUtils.ncl"

begin
  a = new((/2,2,4/), "integer")

  if ( rank_of(a).eq.3 ) then
    pp("test passed")
  else
    pp("test failed")
  end if

end
