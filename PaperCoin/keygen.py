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

#keypair(5,11,7)
#For PaperCoin, pick p,q primes less than 64 and pick e as 3
keypair(23,29,3)
keypair(23,53,3)
keypair(29,5,3)
keypair(59,53,3)
keypair(17,47,3)
keypair(41,59,3)
keypair(23,41,3)
keypair(3,59,3)