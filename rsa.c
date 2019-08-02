typedef unsigned int size_t;
typedef int int32_t;
typedef unsigned int uint32_t;

// TODO: This will overflow
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

#define dec(x, d, n) powMod((x), d, n)

// small key for testing
// int n = 899;
// int e = 37;
// int d = 613;

// 64 bytes -> 16 bytes
// cipher   -> md5
void cipherToMD5(uint32_t cipher[], char md5[], uint32_t d, uint32_t n)
{
    for(int i = 0; i < 16; i++)
        md5[i] = dec(cipher[i], d, n);
}