click(Pattern("1504061287913.png").similar(0.95))

wait(Pattern("1503877845868.png").similar(0.95))
click(Pattern("1503877845868.png").similar(0.95))
wait("1503877104119.png")
click("1503877104119.png")
type("www.google.com"+ Key.ENTER)
wait("1503877160410.png")
logo = find("1503877160410.png")
logo.highlight(2)
Do.popup("Google is your friend",3,logo)
search = input("What do you want to know?","Type your question here")

type("1503877308405.png",search)
wait("1503877367605.png")
click("1503877367605.png")
wait("1503877433623.png")
popup( "Now you have a variety of options that may answer your question.")



            