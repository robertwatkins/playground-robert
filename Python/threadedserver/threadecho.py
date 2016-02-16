#Simple echo program
#listens on port 3000 and returns anything posted by http to that port

#installing required libraries
#download/install Microsoft Visual C++ 9.0 for Python
#https://www.microsoft.com/en-us/download/details.aspx?id=44266
#pip install greenlet
#pip install gevent

import sys
import threading
import urllib
import urllib2
import time
import traceback
from gevent.pywsgi import WSGIServer, WSGIHandler
from gevent import socket

server = ""

def request_error(start_response):
    global server
    # Send error to atm - must provide start_response
    start_response('500', [])
    #server.stop()
    return ['']
    
def handle_transaction(env, start_response):
    global server
    try:
        result = env['wsgi.input'].read()
        print("Received: " + result)
        sys.stdout.flush()
        start_response('200 OK', [])
        if (result.lower()=="exit"):
            #server.stop()
            return result
        else:
            return result
    except:
        return request_error(start_response)
        
class ErrorCapturingWSGIHandler(WSGIHandler):
    def read_requestline(self):
        result = None
        try:
            result = WSGIHandler.read_requestline(self)
        except:
            protocol_error()
            raise # re-raise error, to not change WSGIHandler functionality
        return result

class ErrorCapturingWSGIServer(WSGIServer):
    handler_class = ErrorCapturingWSGIHandler
    
def start_server():
    global server
    server = ErrorCapturingWSGIServer(
    ('', 3000), handle_transaction, log=None)

    server.serve_forever()

def main():
    global server
    
    #start server on it's own thread
    print("Echoing...")
    commandServerThread = threading.Thread(target=start_server)
    commandServerThread.start()
    
    #now that the server is started, send data
    req = urllib2.Request("http://127.0.0.1:3000", data='ping')
    response = urllib2.urlopen(req)
    reply = response.read()
    print(reply)
    
    #take a look at the threading info
    print(threading.active_count())
    
    #try to exit
    req = urllib2.Request("http://127.0.0.1:3000", data='exit')
    response = urllib2.urlopen(req)
    reply = response.read()
    print(reply)
    
    #Now that I'm done, exit
    #sys.exit(0)
    return    
        
if __name__ == '__main__':
    main()
    
