#!/usr/bin/python

import sys, getopt

def main(argv):
   num = ''
   try:
      opts, args = getopt.getopt(sys.argv[1:],"h:n:",["number="])
      if not opts:
         num = int(raw_input("Which fibonacci number do you wish to see? "))
      else:
         numtemp = int(raw_input("Which fibonnacci number do you wish to see? [" + sys.argv[2] + "] ") or sys.argv[2])
   except getopt.GetoptError:
      print 'fib.py -n <number>'
      sys.exit(2)        
   for opt, arg in opts:
      if opt == '-h':
         print 'fib.py -n <number>'
         sys.exit()
      elif opt in ("-n", "--number"):
         num = int(arg)
   print fib(num)

def fib(n):
 a,b = 1,1
 for i in range(n-1):
  a,b = b,a+b
 return a

if __name__ == "__main__":
   main(sys.argv[1:])
   raw_input("Press [RETURN] to continue")