import subprocess
import urllib
import urllib2

addr = "http://127.0.0.1:4000"

pEcho = subprocess.Popen('echo.py', 
    shell=True,
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    )
    
pPing = subprocess.Popen('ping.py', 
    shell=True,
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    )

for i in range(10):
    msg = "http://127.0.0.1:3000"
    print("Sending: "+msg)
    req = urllib2.Request(addr, data=msg)
    response = urllib2.urlopen(req)
    echoOutput = pEcho.stdout.readline()
    pingOutput = pPing.stdout.readline()
    print "Echo: " + echoOutput.rstrip() + " - Ping: " + pingOutput.rstrip()


