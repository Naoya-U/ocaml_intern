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

let kmp_search : (string -> string -> int) = fun w -> fun s ->
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

let kmp_table_meta : (string -> int array code) = fun w ->
  .<
  let len_w = String.length w in
  let table = Array.make len_w 0 in 
  let i = ref 2 in
  let j = ref 0 in 
  table.(0) <- -1;
  while (!i < len_w) do
    if ((String.get w (!i - 1)) = String.get w !j) then (
      table.(!i) <- !j + 1;
      i := !i + 1;
      j := !j + 1;
    )
    else if (!j > 0) then 
      j := table.(!j)
    else (
      table.(!i) <- 0;
      i := !i + 1
    )
  done;
  table
  >.;;

let kmp_search_meta: string -> (string -> int) code = fun w -> .<fun s ->
  let len_s = String.length s in 
  let len_w = String.length w in 
  let out = ref len_s in 
  let m = ref 0 in
  let i = ref 0 in 
  let table = .~(kmp_table_meta w) in 
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
  !out>.;; 

let perf : (unit -> 'a) -> 'a = fun th ->
  let start_time = Sys.time () in 
  let r = th () in 
  let elapsed_time = Sys.time () -. start_time in 
  Printf.printf "\nit took %g secs\n" elapsed_time;
  r 

let _ =
  let go count w s =
    let kmp_fn = kmp_search w in 
    Printf.printf "Unspecialized kmp search: %d\n"
    (perf (fun () -> for i = 1 to count do ignore (kmp_fn s) done;
    kmp_fn s));
    Printf.printf "\nGenerating and compiling the specilized code (100 times)";
    let skmp_fn = perf (fun () ->
      for i = 1 to 99 do ignore(Runnative.run (kmp_search_meta w)) done;
      Runnative.run (kmp_search_meta w)) in 
    Printf.printf "Specialized kmp search: %d\n"
        (perf (fun () -> for i = 1 to count do ignore (skmp_fn s) done;
        skmp_fn s))
    in 
    go 100000000 "abababc" "babbbabcbaababbacccabababcbbaaab";;
