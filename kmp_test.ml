open OUnit2

let test1 test_ctx = assert_equal 4 (Kmp.kmp_search "a" "bbbbabbbbb")
let test2 test_ctx = assert_equal 0 (Kmp.kmp_search "a" "abbbb")
let test3 test_ctx = assert_equal 5 (Kmp.kmp_search "a" "bbbbb")
let test4 test_ctx = assert_equal 0 (Kmp.kmp_search "aaaaa" "aaaaaaaaaa")
let test5 test_ctx = assert_equal 5 (Kmp.kmp_search "aaaaa" "aaabbaaaaaaaaaa")
let test6 test_ctx = assert_equal 6 (Kmp.kmp_search "aaaaa" "bbbbbb")



let suite =
  "suite" >:::
  ["test1">:: test1;
    "test2">:: test2;
    "test3">:: test3;
    "test4">:: test4;
    "test5">:: test5;
    "test6">:: test6;]

let _ = run_test_tt_main suite