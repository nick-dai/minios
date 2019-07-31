#!/usr/bin/env python3
""" Hash kernel.bin.
"""

import struct
import os
import hashlib

kernel_bin = './build/kernel.bin'
kernel_hash = './build/kernel_hash.bin'
size = os.path.getsize(kernel_bin)
md5 = None

with open(kernel_bin, 'rb') as f:
    md5 = hashlib.md5(f.read()).hexdigest()

print('MD5 for kernel.bin: {}'.format(md5))
with open(kernel_hash, 'wb') as f:
    f.write(struct.pack('<I', size))
    for i in range(4):
        f.write(struct.pack('>I', int(md5[8*i:8*i+8], 16)))
        