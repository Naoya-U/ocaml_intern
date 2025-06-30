let perf : (unit -> 'a) -> 'a = fun th ->
  let start_time = Sys.time () in 
  let r = th () in 
  let elapsed_time = Sys.time () -. start_time in 
  Printf.printf "\nit took %g secs\n" elapsed_time;
  r 

let _ =
  let go count w s =
    let kmp_fn = Kmp.kmp_search w in 
    Printf.printf "Unspecialized kmp search: %d\n"
    (perf (fun () -> for i = 1 to count do ignore (kmp_fn s) done;
    kmp_fn s));
    Printf.printf "\nGenerating and compiling the specilized code (100 times)";
    let skmp_fn = perf (fun () ->
      for i = 1 to 99 do ignore(Runcode.run (Kmp_meta.kmp_search_meta w)) done;
      Runcode.run (Kmp_meta.kmp_search_meta w)) in 
    Printf.printf "Specialized kmp search: %d\n"
        (perf (fun () -> for i = 1 to count do ignore (skmp_fn s) done;
        skmp_fn s))
    in 
    go 10000 "abababc" "babbbabcbaababbacccabababcbbaaab";;
