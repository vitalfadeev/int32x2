module vf.int32x2.basic;


version (int32x2_BASIC):
alias int32 = int;

// BASIC
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
    // 
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

// MMX
//   MM0  int64x1  int32x2  int16x4  int8x8
//   MM1  int64x1  int32x2  int16x4  int8x8
//   MM2  int64x1  int32x2  int16x4  int8x8
//   MM3  int64x1  int32x2  int16x4  int8x8
//   MM4  int64x1  int32x2  int16x4  int8x8
//   MM5  int64x1  int32x2  int16x4  int8x8
//   MM6  int64x1  int32x2  int16x4  int8x8
//   MM7  int64x1  int32x2  int16x4  int8x8

//        - +    32 16  8
//       [s us] [ d  w  b]
// p add
// p sub
// p mul  s       d
// p mad
//
// p and
// p andn
// p or
// p xor
//
// p cmpeq
// p cmpgt [b w d]
//
// p sllw
// p slld
// p srl
// p srad
//
// mov d
// mov q
//
// pack ss w b
// pack ss d w
//
