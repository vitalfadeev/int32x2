module vf.int32x2.sse_4_2;


version (int32x2_SSE_4_2):
alias int32 = int;

// SSE 4.2
struct
int32x2 {
    int32[2] s;  // signed integer. XY coordinates. -32768..+32767

    int32x2 add    (int32x2 b)            { return _add (this,b); }
    int32x2 sub    (int32x2 b)            { return _sub (this,b); }
    int32x2 mul    (int32x2 b)            { return _mul (this,b); }
    int32x2 div    (int32x2 b)            { return _div (this,b); }
    int32x2 muladd (int32x2 b, int32x2 c) { return (this*b)+c; }
    int32x2 mulsub (int32x2 b, int32x2 c) { return (this*b)-c; }
    int32x2 muldiv (int32x2 b, int32x2 c) { return _muldiv (this,b,c); }
    int32x2 min    (int32x2 b)            { return _min (this,b); }
    int32x2 max    (int32x2 b)            { return _max (this,b); }
    int32x2 abs    ()                     { return _abs (this);   }

    int32x2 opBinary (string op : "+") (int32x2 b) { return add (b); }
    int32x2 opBinary (string op : "-") (int32x2 b) { return sub (b); }
    int32x2 opBinary (string op : "*") (int32x2 b) { return mul (b); }
    int32x2 opBinary (string op : "/") (int32x2 b) { return div (b); }
}

pragma (inline,true)
int32x2 
_add (int32x2 a, int32x2 b) {
    return int32x2 ([a.s[0] + b.s[0], a.s[1] + b.s[1]]);
}

pragma (inline,true)
int32x2 
_sub (int32x2 a, int32x2 b) {
    return int32x2 ([a.s[0] - b.s[0], a.s[1] - b.s[1]]);
}

pragma (inline,true)
int32x2 
_mul (int32x2 a, int32x2 b) {
    return int32x2 ([a.s[0] * b.s[0], a.s[1] * b.s[1]]);
}

pragma (inline,true)
int32x2 
_div (int32x2 a, int32x2 b) {
    return int32x2 ([a.s[0] / b.s[0], a.s[1] / b.s[1]]);
}

pragma (inline,true)
int32x2 
_muldiv (int32x2 a, int32x2 b, int32x2 c) {
    // load a,b
    //   mov q        xmm1, &a               // SSE2
    //   mov q        xmm2, &b               // SSE2
    // convert to float
    //   cvt dq 2 ps  xmm1, xmm1             // SSE2
    //   cvt dq 2 ps  xmm2, xmm2             // SSE2
    // mul
    //   mulps        xmm1, xmm2             // SSE
    // load c, convert to float
    //   mov q        xmm2, &c               // SSE2
    //   cvt dq 2 ps  xmm2, xmm2             // SSE2
    // div
    //   div ps       xmm1, xmm2             // SSE
    // convert float to i32, store RESULT
    //   cvt ps 2 dq  xmm1, xmm1             // SSE2
    //   mov q        &RESULT, xmm1          // SSE2
    return int32x2 ([
        (a.s[0] * b.s[0]) / c.s[0], 
        (a.s[1] * b.s[1]) / c.s[1]
    ]);
}

pragma (inline,true)
int32x2 
_min (int32x2 a, int32x2 b) {
    return int32x2 ([
        (a.s[0] < b.s[0]) ? a.s[0] : b.s[0], 
        (a.s[1] < b.s[1]) ? a.s[1] : b.s[1]
    ]);
}

pragma (inline,true)
int32x2 
_max (int32x2 a, int32x2 b) {
    return int32x2 ([
        (a.s[0] > b.s[0]) ? a.s[0] : b.s[0], 
        (a.s[1] > b.s[1]) ? a.s[1] : b.s[1]
    ]);
}

pragma (inline,true)
int32x2 
_abs (int32x2 a) {
    return int32x2 ([
        (a.s[0] < 0) ? -a.s[0] : a.s[0], 
        (a.s[1] < 0) ? -a.s[1] : a.s[1]
    ]);
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

