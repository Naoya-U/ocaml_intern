open Square

let rec power : int -> int -> int = fun n x ->
  if n = 0 then 1
  else if n mod 2 = 0 then square (power (n / 2) x)
  else x * (power (n-1) x)

let rec spower : int -> int code -> int code = fun n x ->
  if n = 1 then x
  else if n mod 2 = 0 then .<square .~(spower (n / 2) x)>.
  else .<.~x * .~(spower (n-1) x)>.

let spowern : int -> (int -> int) code =
  fun n -> .<fun x -> .~(spower n .<x>.)>.

let perf : (unit -> 'a) -> 'a = fun th ->
  let start_time = Sys.time () in 
  let r = th () in 
  let elapsed_time = Sys.time () -. start_time in 
  Printf.printf "\nit took %g secs\n" elapsed_time;
  r 

let _ =
  let go count n x =
    let power_fn = power n in 
    Printf.printf "Unspecialized power %d ^ %d is %d\n"
    x n (perf (fun () -> for i = 1 to count do ignore (power_fn x) done;
    power_fn x));
    Printf.printf "\nGenerating and compiling the specilized code (100 times)";
    let spower_fn = perf (fun () ->
      for i = 1 to 99 do ignore(Runnative.run (spowern n)) done;
      Runnative.run (spowern n)) in 
    Printf.printf "Specialized power %d ^ %d is %d\n"
        x n (perf (fun () -> for i = 1 to count do ignore (spower_fn x) done;
        spower_fn x))
    in 
    go 100000000 20 2;;
