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
    print "Public Key:", p*q, " Private Key:", egcd(phi,e)

keypair(5,11,7)