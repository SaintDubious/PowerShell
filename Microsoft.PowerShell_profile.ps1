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
Set-PSReadlineOption -TokenKind None      -BackgroundColor White -ForegroundColor Black
Set-PSReadlineOption -TokenKind Comment   -BackgroundColor White -ForegroundColor Black
Set-PSReadlineOption -TokenKind Keyword   -BackgroundColor White -ForegroundColor Black
Set-PSReadlineOption -TokenKind String    -BackgroundColor White -ForegroundColor Black
Set-PSReadlineOption -TokenKind Operator  -BackgroundColor White -ForegroundColor Black
Set-PSReadlineOption -TokenKind Variable  -BackgroundColor White -ForegroundColor Black
Set-PSReadlineOption -TokenKind Command   -BackgroundColor White -ForegroundColor Black
Set-PSReadlineOption -TokenKind Parameter -BackgroundColor White -ForegroundColor Black
Set-PSReadlineOption -TokenKind Type      -BackgroundColor White -ForegroundColor Black
Set-PSReadlineOption -TokenKind Number    -BackgroundColor White -ForegroundColor Black
Set-PSReadlineOption -TokenKind Member    -BackgroundColor White -ForegroundColor Black

(Get-Host).PrivateData.ErrorBackgroundColor = "White"
(Get-Host).PrivateData.WarningForegroundColor = "Black"
(Get-Host).PrivateData.WarningBackgroundColor = "White"

. "$PSScriptRoot\Get-ChildItem-Color.ps1"

Remove-Item Alias:ls
Set-Alias ls Get-ChildItem-Color
Set-Alias less more
