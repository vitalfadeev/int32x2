module vf.int32x2.sse;


version (int32x2_SSE):
// SSE
struct
int32x2 {
    int32[2] a;  // signed integer. XY coordinates. -32768..+32767

    int32x2 add    (int32x2 b)            { return _add (a,b); }
    int32x2 sub    (int32x2 b)            { return _sub (a,b); }
    int32x2 mul    (int32x2 b)            { return _mul (a,b); }
    int32x2 div    (int32x2 b)            { return _div (a,b); }
    int32x2 muladd (int32x2 b, int32x2 c) { return (a*b)+c; }
    int32x2 mulsub (int32x2 b, int32x2 c) { return (a*b)-c; }
    int32x2 muldiv (int32x2 b, int32x2 c) { return (a*b)/c; }
    int32x2 min    (int32x2 b)            { return _min (a,b); }
    int32x2 max    (int32x2 b)            { return _max (a,b); }
    int32x2 abs    ()                     { return _abs (a);   }
}

pragma (inline,true)
int32x2 
_add (int32x2 b) {
    return int32x2 (a[0] + b[0], a[1] + b[1]);
}

pragma (inline,true)
int32x2 
_sub (int32x2 b) {
    return int32x2 (a[0] - b[0], a[1] - b[1]);
}

pragma (inline,true)
int32x2 
_mul (int32x2 b) {
    return int32x2 (a[0] * b[0], a[1] * b[1]);
}

pragma (inline,true)
int32x2 
_div (int32x2 b) {
    return int32x2 (a[0] / b[0], a[1] / b[1]);
}


pragma (inline,true)
int32x2 
_min (int32x2 b) {
    return int32x2 (
        (a[0] < b[0]) ? a[0] : b[0], 
        (a[1] < b[1]) ? a[1] : b[1]
    );
}

pragma (inline,true)
int32x2 
_max (int32x2 b) {
    return int32x2 (
        (a[0] > b[0]) ? a[0] : b[0], 
        (a[1] > b[1]) ? a[1] : b[1]
    );
}

pragma (inline,true)
int32x2 
_abs () {
    return int32x2 (
        (a[0] < 0) ? -a[0] : a[0], 
        (a[1] < 0) ? -a[1] : a[1]
    );
}

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

