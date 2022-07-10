package stub

import (
	"encoding/binary"
	"unsafe"
)

func Direct_subr(b *[]byte) (ret uint64)

func Offset_subr() (ret unsafe.Pointer)

// R0 = 0x3216b0
// MOVD R0, R2
// MOVD 4(R0), R0 = 0x90000001_140003c6
// UBFIZ $2, R0, $26, R1 = 0xf08
// then just:
//   R3 = base_fn+4 + R1
//   R0 = R3 + R1    // instr addr + instr Imm

//go:noinline
func ExpBLDecoding(d [8]byte) uint32 {
	k := binary.BigEndian.Uint32(d[:4]) // use this for amd64
	// k := binary.LittleEndian.Uint32(d[:4])
	var mask uint32 = ^uint32(0) >> 6 // ignore first 6 bits
	imm := (k & mask) << 2
	return imm
}
