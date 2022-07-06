#include "go_asm.h"
#include "funcdata.h"
#include "textflag.h"

// we need to know stack size.

#define direct_subr_stack_sz 0

// direct_subr(b []byte) uint64
TEXT ·Direct_subr(SB), NOSPLIT | NOFRAME, $0 - 16
    NO_LOCAL_POINTERS

_entry:
    // MOVQ (TLS), R14
    // LEAQ direct_subr_stack_sz(SP), R12
    // JBE _more_stack

_subr:
    // ** MS x64 **
    // Integer Arguments 1-4:          RCX, RDX, R8, R9
    // Floating Point Arguments:       XMM0 - XMM3
    // Excess Arguments:               Stack
    // Routine result:                 RAX
    // ** SystemV amd64 **
    // Integer Arguments 1-6:          RDI, RSI, RDX, RCX, R8, R9
    // Floating Point Arguments 1-8:   XMM0 - XMM7
    // Excess Arguments:               Stack
    // Static chain pointer:           R10
    // Routine result:                 RAX
    MOVQ b+0(FP), DI
    
    CALL subr(SB) // from cgo import
    
    MOVQ AX, ret+8(FP)
    RET

_more_stack:
    CALL runtime·morestack_noctxt<>(SB)
	JMP _entry
