#https://docs.google.com/forms/d/e/1FAIpQLSfLB0U65q0xK92yFbd_pRKqVL6fhMX3Iw2IxNiJKgsoxDg9IQ/viewform?usp=sf_link
#check portability with epiphany web browser
#Running on different browsers with the same script
#is a bit tricky.
#
#In this case, I used the 'Epiphany' browser instead of
#Firefox. Epiphany renders checkboxes different enough that
#sikuli can't use the same image to recognize that field in 
#both browsers. In this case, I've commented it out.
#You'll also see green numbers in the upper-right corner
#of the images. These allow for a 'fuzzy' comparison ranging
#from 1 to 100.
#
#The default value is '70', reducing that results in a more
#likely match, but possibly a false match. Increasing it
#results in a less likely match, but more reliably accurate.
#
#Clicking on the image and selecting the 'matching preview'
#tab while your application is open will allow you to see 
#where you would have matches.

i=0
while i<3:
    i=i+1
    print "filling form ", i 
    type(Pattern("1503023756705.png").similar(0.60).targetOffset(-93,20), "01/01/2017")
    type(Pattern("1503023792830.png").similar(0.43).targetOffset(-69,21), "70\t\t\t\t")
    #click(Pattern("1503023876047.png").targetOffset(-16,-6)) #need to fix
    type(Pattern("1503023919535.png").targetOffset(-76,28), "1\t\t")
    type(Pattern("1503023943275.png").targetOffset(-86,21),"2\t\t" )
    type(Pattern("1503023970708.png").similar(0.53).targetOffset(-104,18), "3\t\t")
    type(Pattern("1503023986808.png").similar(0.60).targetOffset(-120,20), "4\t\t\t\t\t\t")
    #type(Pattern("1503024016342.png").targetOffset(-52,25), "5\t\t") #need to fix
    #type(Pattern("1503024030884.png").similar(0.58).targetOffset(-91,22), "6\t\t") #need to fix
    type(Pattern("1503024043405.png").similar(0.51).targetOffset(-95,21), "7\t\t")
    type(Pattern("1503024057669.png").similar(0.63).targetOffset(-86,23), "8\t\t")
    click("1503024073423.png")
    wait(Pattern("1503024695161.png").similar(0.48))
    click("1503024717564.png")
    wait("1503025412577.png")