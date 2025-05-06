module vf.int32x2.sse_2;


// SSE
//   XMM0  int64x2
//   XMM1  int64x2
//   XMM2  int64x2
//   XMM3  int64x2
//   XMM4  int64x2
//   XMM5  int64x2
//   XMM6  int64x2
//   XMM7  int64x2

//       [S P] S
// ADD    S    S
// SUB    S    S
// MUL    S    S
// DIV    S    S
// RCP    S    S
// MAX    S    S
// MIN    S    S
// SQRT   S    S
// RSQRT  S    S
//
// MOV     S  S
// MOV A   P  S
// MOV U   P  S
// MOV L   P  S
// MOV H   P  S
// MOV LH  P  S
// MOV HL  P  S
//
// CMP     S S
// COM  I  S S
// UCO  MI S S
// CMP     P S
//
// SHUF    P S
// UNPCKH  P S
// UNPCKL  P S
//
// CVT  S I 2 S S
// CVT  S S 2 S I
// CVTT S S 2 S I
//
// CVT  P I 2 P S
// CVT  P S 2 P I
// CVTT P S 2 P I
//
// AND  P S
// OR   P S
// XOR  P S
// ANDN P S
//
///////////////////////////////
// INTEGER
///////////////////////////////
// P MUL HU W
// P SAD B  W
// P AVG    B
// P AVG    W
// P MAX U  B
// P MIN U  B
// P MAX S  W
// P MIN S  W
//
// P EXT RW
// P INS RW
//
// P MOV MSK B
// P SHUF    W
//
// LD MX CSR
// ST MX CSR
//
// MOV NT Q
// MOV NT PS
// MASK MOV Q
// P RE FETCH 0
// P RE FETCH 1
// P RE FETCH 2
// P RE FETCH NTA
// SFENCE

// SSE 2
// p mul u d q
//
// SSE 4.1
// p mul l d

