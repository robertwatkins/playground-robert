def egcd(a, b):
    phi = a
    x,y, u,v = 0,1, 1,0
    while a != 0:
        q, r = b//a, b%a
        m, n = x-u*q, y-v*q
        b,a, x,y, u,v = a,r, u,v, m,n
    gcd = b
    return  max(x % phi, y % phi)

e = 7

#phi = 40
#print egcd(phi,e)

def keypair(p,q,e):
    phi = (p-1)*(q-1)
    print "Public Key:n=", hex(p*q), "e=" ,e ," Private Key:", hex(egcd(phi,e))

#keypair(5,11,7)
#For PaperCoin, pick p,q primes less than 255 and pick e as 3,5 or 7
keypair(163,61,7)
keypair(223,29,5)
keypair(103,31,7)
keypair(191,149,3)
keypair(127,67,5)
keypair(101,83,7)
keypair(73,31,7)
keypair(59,97,7)