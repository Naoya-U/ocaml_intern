.PHONY: runbench runtest

runbench: kmp_rts
	./kmp_rts

runtest: kmp_test
	./kmp_test

kmp_rts: kmp_meta0.ml kmp_meta1.ml kmp_meta2.ml kmp.ml kmp_rts.ml
	metaocamlc -o $@ $^

kmp_test: kmp_meta0.ml kmp_meta1.ml kmp_meta2.ml kmp.ml kmp_test.ml
	metaocamlc -o $@ $^