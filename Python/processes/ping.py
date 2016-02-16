#Simple ping service
#listens on port 4000 for a server:port
#attempts to send a 'ping' to that server:port

#installing required libraries
#download/install Microsoft Visual C++ 9.0 for Python
#https://www.microsoft.com/en-us/download/details.aspx?id=44266
#pip install greenlet
#pip install gevent

import sys
import traceback
import urllib
import urllib2
from gevent.pywsgi import WSGIServer, WSGIHandler
from gevent import socket

def request_error(start_response):
    # Send error to atm - must provide start_response
    start_response('500', [])
    return ['']
    
def handle_transaction(env, start_response):
    try:
        addr = env['wsgi.input'].read()
        #print(addr)
        #req = urllib2.Request(addr, data=urllib.urlencode('ping'))
        req = urllib2.Request(addr, data='ping')
        response = urllib2.urlopen(req)
        reply = response.read()
        #print(reply)
        if (reply=='ping'):
            print("Ping to "+addr+ " successful.")
        else:
            print("Ping to "+addr+ " failed.")
        sys.stdout.flush()
        start_response('200 OK', [])
        return reply
    except:
        #traceback.print_exc()
        print("Ping to "+addr+ " failed.")
        return request_error(start_response)
        
class ErrorCapturingWSGIHandler(WSGIHandler):
    def read_requestline(self):
        result = None
        try:
            result = WSGIHandler.read_requestline(self)
        except:
            #traceback.print_exc()
            raise # re-raise error, to not change WSGIHandler functionality
        return result

class ErrorCapturingWSGIServer(WSGIServer):
    handler_class = ErrorCapturingWSGIHandler
    
def start_server():
    server = ErrorCapturingWSGIServer(
        ('', 4000), handle_transaction, log=None)

    server.serve_forever()

def main():
    try:
        print("Ready...")
        start_server()
    except:
        traceback.print_exc()
        print("Exiting...")
        sys.exit(255)

if __name__ == '__main__':
    main()