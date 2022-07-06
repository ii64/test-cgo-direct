package native

/*
#cgo CFLAGS: -I../../native/include
#cgo amd64 linux LDFLAGS: -L../../native/build/x86_64-linux -lnative
#include "native.h"
*/
import "C"
import (
	"unsafe"

	"github.com/ii64/test-cgo-direct/internal/native/stub"
)

var Noop = 1

func Init() {

}

func Subr(b *[]byte) uint64 {
	ptr := uintptr(unsafe.Pointer(b))
	uptr := unsafe.Pointer(ptr)
	// return uint64(uintptr(uptr))
	return subr(uptr)
}

func subr(b unsafe.Pointer) uint64 {
	return uint64(C.subr((*C.GoSlice)(b)))
}

func DirectSubr(b *[]byte) uint64 {
	return stub.Direct_subr(b)
}
