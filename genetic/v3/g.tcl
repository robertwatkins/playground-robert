proc referenceValue { angle } {
  return [expr {sin($angle*3.14159265/180)}];
}

proc geneticFunctionValue { a b c d e angle } {
  return [expr { $a * $angle * $angle * $angle * $angle + $b * $angle * $angle * $angle + $c * $angle * $angle + $d * $angle + $e}];
}

proc geneticFunctionScore { a b c d e } {

  set diff 0;
  set i -180;
  #puts $e;
  set diff [ expr {[geneticFunctionValue $a $b $c $d $e $i] - [referenceValue $i]}]  ;
  
  while { $i <= 180 } {
    #puts $e;
    incr i 5;
    set temp [ expr {abs([geneticFunctionValue $a $b $c $d $e $i] - [referenceValue $i])}]  ;
    #puts $temp;
    if {$temp > $diff} {
        set diff $temp;
    }
  }
  set diff [ expr {abs($diff)}];
  return $diff;
}

proc mutate {value} {

    return [ expr {$value + (rand()-.5)/1000}];
}

proc geneticEval { a0 b0 c0 d0 e0 } {

  set generation 1;
  set aLast $a0;
  set bLast $b0;
  set cLast $c0;
  set dLast $d0;
  set eLast $e0;
  set scoreLast [ expr {[geneticFunctionScore $a0 $b0 $c0 $d0 $e0]}];
  
  set filename "generations.txt";
  set fileId [open $filename "w"];
  
  while {$generation < 10000 } {
    set randomize [ expr { round(rand()*5)}];
    #puts $randomize;
    switch  $randomize {
        1 {
            set aNext [ expr {[mutate $aLast]}];
            set bNext $bLast;
            set cNext $cLast;
            set dNext $dLast;
            set eNext $eLast;
        }
        2 {
            set aNext $aLast
            set bNext [ expr {[mutate $bLast]}];
            set cNext $cLast;
            set dNext $dLast;
            set eNext $eLast;
        }
        3 {
            set aNext $aLast;
            set bNext $bLast;
            set cNext [ expr {[mutate $cLast]}];
            set dNext $dLast;
            set eNext $eLast;
        }
        4 {
            set aNext $aLast;
            set bNext $bLast;
            set cNext $cLast;
            set dNext [ expr {[mutate $dLast]}];
            set eNext $eLast;
        }
        default {
            set aNext $aLast;
            set bNext $bLast;
            set cNext $cLast;
            set dNext $dLast;
            set eNext [ expr {[mutate $eLast]}];
        }
    }
    set scoreNext [ expr {[geneticFunctionScore $aNext $bNext $cNext $dNext $eNext]}];

    if { $scoreNext < $scoreLast} {
        set data "$aLast * x*x*x*x + $bLast * x*x*x + $cLast * x*x + $dLast * x + $eLast";
        set gnuPlotCommand "set title 'Genetic Programming - Generation $generation';set terminal png size 400,300 ;set output 'data//output$generation.png';f(x) = sin(x/180*pi);g$generation\(x\) = $aLast * x*x*x*x + $bLast * x*x*x + -$cLast * x*x + $dLast * x + $eLast;plot \[x = -180 : 180\] f(x) title 'sin(x)' with lines linestyle 0,   g$generation\(x\) title 'G$generation' with lines linestyle 1"
        puts $gnuPlotCommand'
        exec gnuplot -e $gnuPlotCommand;
        puts $fileId $data;
        flush $fileId;
        puts "Generation:$generation Current Fit:$scoreLast Genetic Fit:$scoreNext";
        puts $data;
        incr generation 1;
        set aLast $aNext;
        set bLast $bNext;
        set cLast $cNext;
        set dLast $dNext;
        set eLast $eNext;
        set scoreLast $scoreNext;
    }
   #puts $scoreNext;
   #puts "$aLast * x^4 + $bLast * x^3 + $cLast * x^2 + $dLast * x + $eLast";
   }
   close $fileId;
   puts "$aLast * x^4 + $bLast * x^3 + $cLast * x^2 + $dLast * x + $eLast";
}
# if { [catch {referenceValue 90} temp]} {
    # puts "after bad proc call: ErrorCode: $errorCode";
    # puts "ERRORINFO:\n$errorInfo\n";
# } else {
    # puts "Test Value for a 45 degrees launch should be 1: test value = $temp";
# }

# if { [catch {geneticFunctionValue 0 0 .01 .01 .01 90} temp]} {
    # puts "after bad proc call: ErrorCode: $errorCode";
    # puts "ERRORINFO:\n$errorInfo\n";
# } else {
    # puts "test value = $temp";
# }

# if { [catch {geneticFunctionScore 0 0 .01 .01 .01 } temp]} {
    # puts "after bad proc call: ErrorCode: $errorCode";
    # puts "ERRORINFO:\n$errorInfo\n";
# } else {
    # puts "test value = $temp";
# }


set b [ expr {[geneticFunctionScore 0 0.000000001 0 0 0]}];
puts $b;


# set a [ expr {[mutate 1.1]}];
# puts $a;

# geneticEval 0.0 -.01 0 .01 .01;

geneticEval  0 -0.000001 0 0 0;

# set i 0;
# while { $i <= 10 } {
    # set a [ expr { round(rand()*5)}];
    # puts $a;
    # incr i;
# }