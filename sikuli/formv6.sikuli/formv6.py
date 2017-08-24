#https://docs.google.com/forms/d/e/1FAIpQLSfLB0U65q0xK92yFbd_pRKqVL6fhMX3Iw2IxNiJKgsoxDg9IQ/viewform?usp=sf_link
#You can also add logging if that is useful. The python
#'print' function works well.
i=0
while i<2:
    i=i+1
    print "filling form ", i 
    type(Pattern("1503023756705.png").targetOffset(-93,20), "01/01/2017")
    type(Pattern("1503023792830.png").targetOffset(-69,21), "70\t\t")
    click(Pattern("1503023876047.png").targetOffset(-16,-6))
    type(Pattern("1503023919535.png").targetOffset(-76,28), "1\t\t")
    type(Pattern("1503023943275.png").targetOffset(-86,21),"2\t\t" )
    type(Pattern("1503023970708.png").targetOffset(-104,18), "3\t\t")
    type(Pattern("1503023986808.png").targetOffset(-120,20), "4\t\t")
    type(Pattern("1503024016342.png").targetOffset(-52,25), "5\t\t")
    type(Pattern("1503024030884.png").similar(0.83).targetOffset(-91,22), "6\t\t")
    type(Pattern("1503024043405.png").targetOffset(-95,21), "7\t\t")
    type(Pattern("1503024057669.png").targetOffset(-86,23), "8\t\t")
    click("1503024073423.png")
    wait("1503024695161.png")
    click("1503024717564.png")
    wait("1503025412577.png")