#Simple echo program
#listens on port 3000 and returns anything posted by http to that port
#see 'echo' test in ProcessTesting soap ui test.

#installing required libraries
#download/install Microsoft Visual C++ 9.0 for Python
#https://www.microsoft.com/en-us/download/details.aspx?id=44266
#pip install greenlet
#pip install gevent

import sys
from gevent.pywsgi import WSGIServer, WSGIHandler
from gevent import socket

def handle_transaction(env, start_response):
    try:
        result = env['wsgi.input'].read()
        print(result)
        sys.stdout.flush()
        start_response('200 OK', [])
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
    server = ErrorCapturingWSGIServer(
        ('', 3000), handle_transaction, log=None)

    server.serve_forever()

def main():
    try:
        print("Echoing...")
        start_server()
    except:
        print("Exiting...")
        sys.exit(255)

if __name__ == '__main__':
    main()