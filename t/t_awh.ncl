load "$lib_dir/yagUtils.ncl"

begin

  ;; .  .  .  .
  ;;
  ;; .  .  .  .
  ;;
  ;; | /.  .  .
  ;; | / /
  ;; ._ . _.  .
  ;; (0,0)

  x1 = (/0,0,0,0,0/)
  y1 = (/0,0,0,0,0/)

  x2 = (/2,2,2,1,1/)
  y2 = (/0,1,2,2,0/)

  r2d = 45.0/atan(1.0)     ; conversion factor (radians to degrees)

  do it = 0, dim_len0(x1)-1, 1
    print(r2d * angle_with_horizontal(x1(it),x2(it),y1(it),y2(it)))
  end do

end
