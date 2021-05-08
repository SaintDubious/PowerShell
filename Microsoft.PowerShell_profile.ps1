echo "Running Startup Script"
Set-PSReadlineOption -EditMode Emacs

function prompt 
{
    "$PWD $ "
}

# Clipboard interaction is bound by default in Windows mode, but not Emacs mode.
Set-PSReadlineKeyHandler -Key Shift+Ctrl+C -Function Copy
Set-PSReadlineKeyHandler -Key Ctrl+V -Function Paste

# setup colors
Set-PSReadlineOption -Colors @{
  Command            = 'Black'
  Number             = 'Black'
  Member             = 'Black'
  Operator           = 'Black'
  Type               = 'Black'
  Variable           = 'Black'
  Error           = 'Black'
  Parameter          = 'Black'
  ContinuationPrompt = 'Black'
  Default            = 'Black'    
}

. "$PSScriptRoot\Get-ChildItem-Color.ps1"

Remove-Item Alias:ls
Set-Alias ls Get-ChildItem-Color
Set-Alias less more
