#!/usr/bin/env python3
""" Hash kernel.bin.
"""

import struct

ff = None
with open('./build/kernel.bin', 'rb') as f:
    ff = f.read()

dump = 0

for c in ff:
    dump += c

print('hash for kernel.bin: {}'.format(dump))
with open('./build/kernel_hash.bin', 'wb') as f:
    f.write(struct.pack('<I', dump))