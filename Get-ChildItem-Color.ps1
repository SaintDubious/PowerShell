function Get-ChildItem-Color
{
    param(
        [string]$filter = "",
        [switch]$a = $false
    )
    Get-ChildItem $filter -Force:$a | Foreach-Object {
        if (!$a -and $_.Name.StartsWith(".")) {
            return
        }

        if ($_ -is [System.IO.DirectoryInfo]) {
            Write-Host( "           {0} " -f $_.LastWriteTime.ToString("MMM dd HH:mm")) -NoNewline
            Write-Host( $_.name ) -ForegroundColor blue
        }
        elseif ($_ -is [System.IO.FileInfo]) {
            Write-Host( "{0,10:D} {1} " -f $_.length, $_.LastWriteTime.ToString("MMM dd HH:mm")) -NoNewline
            Write-Host( $_.name ) -ForegroundColor black
        }
    }
}

