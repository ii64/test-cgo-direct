package stub

import (
	"fmt"
	"testing"
)

func TestX(t *testing.T) {
	type test struct {
		b   [8]byte
		exp uint32
	}
	ts := []test{
		{[8]byte{0x14, 0x00, 0x00, 0x02}, 8},
		{[8]byte{0x14, 0x00, 0x03, 0xba}, 0xee8},
		{[8]byte{0x14, 0x00, 0x03, 0xbe}, 0xef8},
		{[8]byte{0x14, 0x00, 0x03, 0xc6}, 0xf18},
	}
	for _, tc := range ts {
		act := ExpBLDecoding(tc.b)
		if act != tc.exp {
			fmt.Printf("act: %+#v exp: %+#v\n", act, tc.exp)
			t.Fail()
		}
	}
}
