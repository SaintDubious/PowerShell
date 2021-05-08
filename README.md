# PowerShell

I've found an awful lot of links about how to make your ls look colorful like in bash, but none of them produce very satisfying results 
(usually the entire line is colored as opposed to just the directory name). After I solved that I hacked a bit to see what other
ways I could make ls look "correct." I got it to support wide and long mode, and I changed the behavior of .files so that they act
like hidden files (ie they only show up if you do ls -a). I also changed how the switch parsing works so you can do "ls -al" 
instead of the more PowerShell-ish "ls -a -l"


## Usage

Learn about "Execution Policies" from Microsoft. By default you can't run unsigned scripts, even ones you copy in yourself. This means that in order to use these you will need to set your Execution Policy to `unrestricted` which is dangerous and you shouldn't do it unless you're comfortable with that.

Assuming you're okay to continue, you'll need to install some PowerShell modules:
- [PSReadLine](https://docs.microsoft.com/en-us/powershell/module/psreadline/?view=powershell-7.1) - `Install-Module -Name PSReadLine -RequiredVersion 2.1.0 -Scope CurrentUser`

- Make a directory in your `Documents` folder called `WindowsPowerShell` and copy these files in there.
