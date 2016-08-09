# PowerShell

I've found an awful lot of links about how to make your ls look colorful like in bash, but none of them produce very satisfying results 
(usually the entire line is colored as opposed to just the directory name). After I solved that I hacked a bit to see what other
ways I could make ls look "correct." I got it to support wide and long mode, and I changed the behavior of .files so that they act
like hidden files (ie they only show up if you do ls -a). I also changed how the switch parsing works so you can do "ls -al" 
instead of the more PowerShell-ish "ls -a -l"
