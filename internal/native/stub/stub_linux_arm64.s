
#include "go_asm.h"
#include "funcdata.h"
#include "textflag.h"

// we need to know stack size.

#define direct_subr_stack_sz 0

#define inst

/*
Workaround:
Read imm of B instruction
*/
TEXT ·Offset_subr(SB), NOSPLIT | NOFRAME, $0 - 8
    NO_LOCAL_POINTERS

    B _main    //
    B subr(SB) // we are gonna read the Imm (PC-rel)
_main:
    // !! cannot resolved in link time.
    // !! -> missing section for subr
    // MOVD runtime·tls_g(SB), R0
    // MOVD ·subr(SB), R0
    // MOVD subr(SB), R0
    // MOVD $subr(SB), R0
    // MOVD R0, ret+0(FP)
    // RET

    MOVD $·Offset_subr(SB), R1 // base fn
    MOVD R1, R0 // copy to R0

    MOVD 4(R1), R1 // 2nd instr of fn

    // reg scratch R2, ...
    // get imm of B/BL instruction, see `ExpBLDecoding`
    // REVW R1, R1
    UBFIZ $2, R1, $26, R2 // R2 = imm value

    // calc B addr
    ADD $4*1, R0, R3

    // B addr + imm value
    ADD R3, R2, R0

    MOVD R0, ret+0(FP)
    RET
    

// need FRAME
TEXT ·Direct_subr(SB), NOSPLIT, $0 - 16
    NO_LOCAL_POINTERS

    // arg
    MOVD b+0(FP), R0

    MOVD RSP, R6
nosave:
    MOVD RSP, R13
    SUB $16, R13
    MOVD R13, RSP

    MOVD R6, 8(RSP) // save original rsp to stack

    BL subr(SB)

    MOVD 8(RSP), R6 // put back original rsp
    MOVD R6, RSP

    // ret
    MOVD R0, ret+8(FP)
    RET
