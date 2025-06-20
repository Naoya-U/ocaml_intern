let rec spowerf : int -> float code -> float code = fun n x ->
  if n = 1 then x
  else if n mod 2 = 0 then .<squaref .~(spowerf (n / 2) x)>.
  else .<.~x *. .~(spowerf (n-1) x)>.;;