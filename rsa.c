typedef unsigned int size_t;
typedef int int32_t;
typedef unsigned int uint32_t;

uint32_t powMod(uint32_t b, uint32_t e, uint32_t m)
{
    uint32_t acc = 1;
    for(size_t i = 0; i < e; i++)
    {
        acc *= b;
        if(acc >= m)
            acc %= m;
    }
    return acc;
}

// small key for testing
static const uint32_t n = 899;
static const uint32_t d = 613; // decrypt key
// enc key e = 37

// 32-bit RSA
void rsaDecrypt(uint32_t p[], uint32_t d, uint32_t len)
{
	for(size_t i = 0; i < len; i++)
		p[i] = powMod(p[i], d, n);
}