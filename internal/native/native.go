package native

/*
#cgo CFLAGS: -I../../native/include
#include "native.h"
*/
import "C"

import (
	"unsafe"

	"github.com/ii64/test-cgo-direct/internal/native/stub"
)

var Noop = 1

func Init() {
	Noop = 2
	stub.ExpBLDecoding([8]byte{})
}

func Subr(b *[]byte) uint64 {
	ptr := uintptr(unsafe.Pointer(b)) // !! breaking: possible misuse unsafe
	return subr(unsafe.Pointer(ptr))
}

func subr(b unsafe.Pointer) uint64 {
	return uint64(C.subr((*C.GoSlice)(b)))
}

func DirectSubr(b *[]byte) uint64 {
	return stub.Direct_subr(b)
}

func OffsetSubr() unsafe.Pointer {
	return stub.Offset_subr()
}
