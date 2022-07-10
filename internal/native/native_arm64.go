package native

/*
#cgo CFLAGS: -I../../native/include
#cgo linux LDFLAGS: -L../../native/build/aarch64-linux -lnative
#include "native.h"
*/
import "C"

const a = 3
