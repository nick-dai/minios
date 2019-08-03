import rsa

with open('key.inc', 'w') as f:
	# Add description
	d, n = rsa.genKey()
	f.write('KERNEL_SIGN_D equ {}'.format(rsa.d))
	f.write('KERNEL_SIGN_N equ {}'.format(rsa.n))