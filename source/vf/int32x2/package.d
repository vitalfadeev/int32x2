module vf.int32x2;

version (SSE_4_2)
    version = int32x2_SSE_4_2;
else
version (SSE_4_1)
    version = int32x2_SSE_4_1;
else
version (SSE_3)
    version = int32x2_SSE_3;
else
version (SSE_2)
    version = int32x2_SSE_4_2;
else
version (SSE)
    version = int32x2_SSE;
else
version (MMX)
    version = int32x2_MMX;
else
    version = int32x2_BASIC;

public import vf.int32x2.sse_4_2;
public import vf.int32x2.sse_4_1;
public import vf.int32x2.sse_3;
public import vf.int32x2.sse_2;
public import vf.int32x2.sse;
public import vf.int32x2.mmx;
public import vf.int32x2.basic;
