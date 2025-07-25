let kmp_table : (string -> int array) = fun w ->
  let len_w = String.length w in
  let table = Array.make len_w 0 in 
  let i = ref 2 in
  let j = ref 0 in 
  table.(0) <- -1;
  while (!i < len_w) do
    if ((String.get w (!i - 1)) = String.get w !j) then (
      table.(!i) <- !j + 1;
      i := !i + 1;
      j := !j + 1
    )
    else if (!j > 0) then 
      j := table.(!j)
    else (
      table.(!i) <- 0;
      i := !i + 1
    )
  done;
  table;;

let kmp_search : (string -> string -> int) = fun w s ->
  let len_s = String.length s in 
  let len_w = String.length w in 
  let out = ref len_s in 
  let m = ref 0 in
  let i = ref 0 in 
  let table = kmp_table w in 
  while ((!m + 1 < len_s) && (!i < len_w)) do (
    if ((String.get w !i) = String.get s (!m + !i)) then (
      i := !i + 1;
      if (!i = len_w) then
        out := !m 
    )  
    else (
      m := !m + !i - table.(!i);
      if (!i > 0) then
        i := table.(!i)
    )
  )
  done;
  !out;;

  (*
  s: abcdcaa
  w: abcdab
  *)