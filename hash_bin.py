#!/usr/bin/env python3
""" Hash kernel.bin.
"""

import struct
import os
import hashlib

import rsa

kernel_bin = './build/kernel.bin'
kernel_hash = './build/kernel_hash.bin'
size = os.path.getsize(kernel_bin)
md5 = None

with open(kernel_bin, 'rb') as f:
    md5 = hashlib.md5(f.read()).hexdigest()

print('Size for kernel.bin: {}'.format(size))
print('MD5 for kernel.bin: {}'.format(md5))

s, l = rsa.md5_RSA(md5)
print('Encrypted MD5: {}'.format(s))
print(l)
print('--------------------------------------------------------------------')

with open(kernel_hash, 'wb') as f:
    f.write(struct.pack('<I', size))
    for i in l:
    	f.write(struct.pack('<I', i))
    f.write(struct.pack('<I', rsa.d)) # write d
    f.write(struct.pack('<I', rsa.n)) # write n

    # for i in range(4):
    #     f.write(struct.pack('>I', int(md5[8*i:8*i+8], 16)))

# with open('key.inc', 'w') as f:
# 	# Add description
# 	f.write('KERNEL_SIGN_D equ {}'.format(rsa.d))
# 	f.write('KERNEL_SIGN_N equ {}'.format(rsa.n))

print('Code signed')