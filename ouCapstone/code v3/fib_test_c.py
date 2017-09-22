#!/usr/bin/python

import unittest,sys,fib,subprocess

class TestFib(unittest.TestCase):

    def test_valid(self):
        self.assertEqual(subprocess.check_output(['./fib', '1']),'fib(1) = 1\n', "Expected 'fib(1) = 1' but got:"+str(subprocess.check_output(['./fib', '1'])))
 	self.assertEqual(subprocess.check_output(['./fib', '10']),'fib(10) = 55\n', "Expected 'fib(10) = 55' but got:"+str(subprocess.check_output(['./fib', '10'])))
        
    
    def test_invalid(self):
        with self.assertRaises(TypeError):
            fib.fib(0.5)
        with self.assertRaises(TypeError):
            fib.fib('a')
        with self.assertRaises(TypeError):
            fib.fib('.')



if __name__ == '__main__':
    unittest.main()
    
    
