let square x = x * x

let rec power : int -> int -> int = fun n x ->
  if n = 0 then 1
  else if n mod 2 = 0 then square (power (n / 2) x)
  else x * (power (n-1) x)
;;