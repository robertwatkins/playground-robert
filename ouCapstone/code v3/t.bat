echo off
REM The pattern of the tests below is this:
REM Run the program, search the output for the expected result listed as a string
REM If no match is found, then the test failed.
REM
REM Notes: The | sends output to the next command
REM        an errorlevel of 1 means that the previous command was not successful
REM

echo Simple test
fib 3 | find "fib(3) = 2" > nul
if errorlevel 1 ( echo "Failed" ) else echo "Success"

echo Smallest int
fib 0 | find "fib(0) = 1" > nul
if errorlevel 1 ( echo "Failed" ) else echo "Success"

echo non-numeric value
fib a | find "fib(a) = 1" > nul
if errorlevel 1 ( echo "Failed" ) else echo "Success"

echo negative value
fib -1 | find "fib(-1) = 1" > nul
if errorlevel 1 ( echo "Failed" ) else echo "Success"

echo negative value
fib a | find "fib(-2) = -1" > nul
if errorlevel 1 ( echo "Failed" ) else echo "Success"

echo output is greater than signed max int
fib 47 | find "fib(47) = 2971215073" > nul
if errorlevel 1 ( echo "Failed" ) else echo "Success"

echo floating point values
fib 1.0 | find "fib(1.0) = 1" > nul
if errorlevel 1 ( echo "Failed" ) else echo "Success"

echo floating point values
fib 1.5 | find "fib(1.5) = 1" > nul
if errorlevel 1 ( echo "Failed" ) else echo "Success"


echo Done
pause
