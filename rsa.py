#!/usr/bin/env python3
""" RSA helper func
"""

n = 899
e = 37
d = 613

def md5_RSA(md5):
	def enc(x):
	    return pow(x, e, n)
	def dec(x):
	    return pow(x, d, n)

	# 1 -> 4
	# 方便用struct.pack
	l = []
	s = ''

	for i in range(16):
	    p = md5[2*i:2*i+2]
	    
	    tmp = '%8x' %enc(int(p, 16))
	    tmp = tmp.replace(' ', '0')
	    s += tmp
	    l.append(int(tmp, 16))
	return s, l

# TODO: Actually gen the key
def genKey():
	return d, n