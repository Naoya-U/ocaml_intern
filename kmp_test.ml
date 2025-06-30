let test_kmp =
  let test1 = (4 = (Kmp.kmp_search "a" "bbbbabbbbb")) in
  let test2 = (0 = (Kmp.kmp_search "a" "abbbb")) in
  let test3 =  (5 = (Kmp.kmp_search "a" "bbbbb")) in
  let test4 =  (0 = (Kmp.kmp_search "aaaaa" "aaaaaaaaaa")) in
  let test5 =  (5 = (Kmp.kmp_search "aaaaa" "aaabbaaaaaaaaaa")) in
  let test6 =  (6 = (Kmp.kmp_search "aaaaa" "bbbbbb")) in
  if (test1 && test2 && test3 && test4 && test5 && test6) then
    Printf.printf "Unspecialized kmp: test passed\n"
  else
    Printf.printf "Unspecialized kmp: test failed\n"

let test_kmp_meta =
  let test1 = (4 = (Runcode.run (Kmp_meta.kmp_search_meta "a") "bbbbabbbbb")) in
  let test2 = (0 = (Runcode.run (Kmp_meta.kmp_search_meta "a") "abbbb")) in
  let test3 =  (5 = (Runcode.run (Kmp_meta.kmp_search_meta "a") "bbbbb")) in
  let test4 =  (0 = (Runcode.run (Kmp_meta.kmp_search_meta "aaaaa") "aaaaaaaaaa")) in
  let test5 =  (5 = (Runcode.run (Kmp_meta.kmp_search_meta "aaaaa") "aaabbaaaaaaaaaa")) in
  let test6 =  (6 = (Runcode.run (Kmp_meta.kmp_search_meta "aaaaa") "bbbbbb")) in
  if (test1 && test2 && test3 && test4 && test5 && test6) then
    Printf.printf "Specialized kmp: test passed\n"
  else
    Printf.printf "Specialized kmp: test failed\n"


let _ =
  test_kmp;
  test_kmp_meta
