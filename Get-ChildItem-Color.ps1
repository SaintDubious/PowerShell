# This is my attempt to create an 'ls' command that looks like the default ls
# in a linux system. It treats .files as hidden
# It understands some colors:
#   - directories are blue
#   - executables are green
#   - everything else is black
# It understands some switches (which can be combined)
#   - l shows you the long format
#   - a shows you everything (including .files)
# 
function Get-ChildItem-Color
{
    # I do my own argument parsing because I couldn't figure out how to use params()
    # with combined switches, like -al
    $Filter  = ""
    $Long    = $false
    $All     = $false
    $args | Foreach-Object {        
        if ($_.StartsWith('-')) {
            if ($_.Contains('l')) {
                $Long = $true
            }
            if ($_.Contains('a')) {
                $All = $true
            }
        }
        else {
            $Filter = $_
        }
    }

    # Actually get the contents of the folder and sort them. Directories come up top
    # and everything else is case-insensitive alphanumeric sort
    $Items = Get-ChildItem $Filter -Force:$All `
        | Sort-Object -Property @{Expression={$_ -is [System.IO.DirectoryInfo] };Ascending=$false},name

    # If we're not using $Long then we want wide. For that we'd want to figure out 
    # the console width and how many columns we're dealing with
    if (!$Long) {
        $MaxItemWidth = 0
        $Items | Foreach-Object {
            if ($_.Name.Length -gt $MaxItemWidth) {
                $MaxItemWidth = $_.name.Length
            }
        }
        $Pad = 2
        $ColumnCount = [math]::Floor( ((Get-Host).UI.RawUI.WindowSize.Width / ($MaxItemWidth+$Pad)) )
        $ColumnWidth = [math]::Floor( ((Get-Host).UI.RawUI.WindowSize.Width / $ColumnCount) )
    }

    $i = 0
    $NoNewline = $true
    $Items | Foreach-Object {
        # Filter out files that start with '.' like in bash
        if (!$All -and $_.Name.StartsWith(".")) {
            return
        }

        # Handle the colors
        $Color = 'black'
        if ($_ -is [System.IO.DirectoryInfo]) {
            $Color = 'blue'
        }
        elseif ($_.Extension -like ".exe") {
            $Color = 'green'
        }

        if ($Long) {
            if ($_ -is [System.IO.DirectoryInfo]) {
                Write-Host( "           {0} " -f $_.LastWriteTime.ToString("MMM dd HH:mm")) -NoNewline
            }
            elseif ($_ -is [System.IO.FileInfo]) {
                Write-Host( "{0,10:D} {1} " -f $_.length, $_.LastWriteTime.ToString("MMM dd HH:mm")) -NoNewline
            }
            Write-Host( $_.name ) -ForegroundColor $Color
        }
        else {
            $NoNewline = $true
            $i++
            if ($i -eq $ColumnCount) {
                $NoNewline = $false
                $i = 0
            }        
            Write-Host( $_.name.PadRight($ColumnWidth-1, ' ') ) -ForegroundColor $Color -NoNewline:$NoNewline
        }
    }
    # In wide mode we can end up with the prompt in the middle of the line. This just puts
    # an extra newline at the end to bring us back to the leftmost position
    if (!$Long -and $NoNewline) {
        Write-Host ""
    }
}

