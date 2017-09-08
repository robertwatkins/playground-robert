#!/usr/bin/python

import unittest,sys,fib

class TestFib(unittest.TestCase):

    def test_valid(self):
        self.assertEqual(fib.fib(2),1, "Expected 1 but got:"+str(fib.fib(2)))
        self.assertEqual(fib.fib(10),55, "Expected 55 but got:"+str(fib.fib(10)))
    
    def test_invalid(self):
        with self.assertRaises(TypeError):
            fib.fib(0.5)
        with self.assertRaises(TypeError):
            fib.fib('a')
        with self.assertRaises(TypeError):
            fib.fib('.')



if __name__ == '__main__':
    unittest.main()
    
    
