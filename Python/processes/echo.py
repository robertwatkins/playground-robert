from __future__ import print_function
import traceback
import random
import socket
import argparse
import threading
import signal
import json
import requests
import sys
import time
import json
import base64
import os
import shutil
import subprocess
import tempfile
from Queue import Queue
from contextlib import contextmanager
from multiprocessing import Process, Queue
from Queue import Empty
from gevent.pywsgi import WSGIServer, WSGIHandler
from gevent import socket
from datetime import datetime
from threading import Lock

def handle_transaction(env, start_response):
    try:
        if env['PATH_INFO'] == '/':
            test_nonce(env['HTTP_NONCE'])
            payload = env['wsgi.input'].read()
            payload = decrypt_payload(env, payload)


            command = json.loads(payload)

            result = perform_transaction(command)
            result = prepare_payload(result, start_response)

            return result

        elif env['PATH_INFO'] == '/nonce':
            payload = env['wsgi.input'].read()
            test_mac(env, payload)
            nonce = get_nonce()
            result = prepare_payload(nonce, start_response)

            return result

        else:
            return request_error(start_response)
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
        start_server()
    except:
		print("Exiting.")
        sys.exit(255)

if __name__ == '__main__':
    main()