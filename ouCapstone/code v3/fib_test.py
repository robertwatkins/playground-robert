#!/usr/bin/python

import unittest,sys,fib

class TestFib(unittest.TestCase):

    def test_valid(self):
        self.assertEqual(fib.fib(2),1)
        self.assertEqual(fib.fib(10),55)

if __name__ == '__main__':
    unittest.main()
    
    
