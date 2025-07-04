let kmp_table_meta : (string -> int array) = fun w ->
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
  table;;

let table_to_func: int array -> ((int -> int) code) =
fun x -> 
  let len = Array.length x in 
  .<fun j ->
  .~(let rec build i =
    if i >= len then .<-1>.
    else
      let vi = x.(i) in 
      let rest = build (i + 1) in 
      .<if .~(.<j>.) = i then .~(.<vi>.) else .~rest>.
    in
    build 0)>.

(*
  input: [0, 2, 4, 5, 3]

  output: .< fun j ->
            if j = 0 then 0
            else if j = 1 then 2
            else if j = 2 then 4
            else if j = 3 then 5
            else if j = 4 then 3
            else -1 >.
*)


let kmp_search_meta: string -> (string -> int) code =
  fun w ->
  let table = kmp_table_meta w in
  let len_w = String.length w in 
  .<fun s ->
    let len_s = String.length s in 
    let out = ref len_s in 
    let m = ref 0 in
    let i = ref 0 in 
    while ((!m + 1 < len_s) && (!i < len_w)) do (
      if ((String.get w !i) = String.get s (!m + !i)) then (
        i := !i + 1;
        if (!i = len_w) then
          out := !m 
      )  
      else (
        m := !m + !i - (.~(table_to_func table) !i);
        if (!i > 0) then
          (* if table = [0, 2, 4, 5, 3], what code we want to generate? *)
          (* i := table.(!i) *)
          i := .~(table_to_func table) !i
      )
    )
    done;
    !out>.;; 