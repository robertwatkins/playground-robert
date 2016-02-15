import subprocess
import time
import sys
from Queue import Queue, Empty
from threading  import Thread

def enqueue_output(out, queue):
    for line in iter(out.readline, b''):
        queue.put(line)
    out.close()

#Start process we want to listen to
pPing = subprocess.Popen('ping.py', 
    shell=True,
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    )
    
q = Queue()
t = Thread(target=enqueue_output, args=(pPing.stdout, q))
t.daemon = True
t.start()

#make sure it's started  
print ("get the first line")
try:
    line = q.get()
except Empty:
    pass
else:
    print line.strip()

#look for the 'magic' output
print("empty the queue")
while not q.empty():
    line = q.get_nowait().strip()
    if (line == "3"):
        print("got it!")
        sys.exit()
    else:
        print("not yet")


