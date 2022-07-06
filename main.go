package main

import (
	"fmt"

	"github.com/ii64/test-cgo-direct/internal/native"
)

var _ = native.Noop

func main() {
	var (
		a = make([]byte, 32)
		b = make([]byte, 32)
	)

	ret1 := native.Subr(&a)
	fmt.Printf("ret1: %+#v\n", ret1)
	fmt.Printf("a_str: %q\n", string(a))
	fmt.Printf("a: %+#v\n", a)

	fmt.Println()

	ret2 := native.DirectSubr(&b)
	fmt.Printf("ret2: %+#v\n", ret2)
	fmt.Printf("b_str: %q\n", string(b))
	fmt.Printf("b: %+#v\n", b)
}
