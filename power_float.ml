let squaref x = x *. x

let rec powerf : int -> float -> float = fun n x ->
  if n = 1 then x
  else if n mod 2 = 0 then squaref (powerf (n / 2) x)
  else x *. (powerf (n-1) x)
;;