#https://brilliant.org/wiki/extended-euclidean-algorithm/
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

#For PaperCoin, pick p,q primes and pick e as 3
keypair(2,5,3)
keypair(2,11,3)
keypair(2,13,3)
keypair(2,17,3)
keypair(3,5,3)
