int pow(int b, int e)
{
	int acc = b;
	for(int i = 1; i < e; i++)
		acc *= b;
	return acc;
}