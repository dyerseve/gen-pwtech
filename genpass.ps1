$cmd = "C:\Programs\PwTech\pwtech.com"
$args =  @("-profile", "Passphrase", "-gen", 1, "-readonly", "-silent")
write-host = $cmd $args
$output = & $cmd $args

# Check if the command executed successfully
if ($?) {
    # Split the output into lines
    $outputLines = $output -split [Environment]::NewLine

    # Check if there are at least 5 lines in the output
    if ($outputLines.Length -ge 5) {
        # Get the 5th line (index 4 since arrays are 0-based)
        $lineToCopy = $outputLines[4]

        # Copy the 5th line to the clipboard
        Set-Clipboard -Value $lineToCopy
    } else {
        Write-Host "Output does not have at least 5 lines."
    }
} else {
    Write-Host "Command execution failed."
}

