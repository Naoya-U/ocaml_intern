let rec spower : int -> int code -> int code = fun n x ->
  if n = 1 then x
  else if n mod 2 = 0 then .<square .~(spower (n / 2) x)>.
  else .<.~x * .~(spower (n-1) x)>.;;