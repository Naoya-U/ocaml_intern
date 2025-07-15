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
    let skmp_fn0 = perf (fun () ->
      for i = 1 to 99 do ignore(Runcode.run (Kmp_meta0.kmp_search_meta w)) done;
      Runcode.run (Kmp_meta0.kmp_search_meta w)) in 
    Printf.printf "Specialized kmp search0: %d\n"
        (perf (fun () -> for i = 1 to count do ignore (skmp_fn0 s) done;
        skmp_fn0 s));

    Printf.printf "\nGenerating and compiling the specilized code (100 times)";

    let skmp_fn1 = perf (fun () ->
      for i = 1 to 99 do ignore(Runcode.run (Kmp_meta1.kmp_search_meta w)) done;
      Runcode.run (Kmp_meta1.kmp_search_meta w)) in 
    Printf.printf "Specialized kmp search1: %d\n"
        (perf (fun () -> for i = 1 to count do ignore (skmp_fn1 s) done;
        skmp_fn1 s));

    Printf.printf "\nGenerating and compiling the specilized code (100 times)";

    let skmp_fn2 = perf (fun () ->
      for i = 1 to 99 do ignore(Runcode.run (Kmp_meta2.kmp_search_meta w)) done;
      Runcode.run (Kmp_meta2.kmp_search_meta w)) in 
    Printf.printf "Specialized kmp search2: %d\n"
        (perf (fun () -> for i = 1 to count do ignore (skmp_fn2 s) done;
        skmp_fn2 s))

    in 
    go 10000000 "abababc" "babbbabcbaababbacccabababcbbaaab";;
