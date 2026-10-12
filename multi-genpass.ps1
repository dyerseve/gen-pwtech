<#
multi-genpass.ps1
pellis@cmitsolutions.com
2025.12.02.001

Changelog: first version

Prompts for password count and generates multiple passwords to insert into the clipboard

#>


Add-Type -AssemblyName Microsoft.VisualBasic

# Prompt user for number of passwords
$numInput = [Microsoft.VisualBasic.Interaction]::InputBox(
    "Enter the number of passwords to generate:",
    "Password Generator",
    "13"
)

# Validate input
try {
    [int]$num = [int]$numInput
    if ($num -le 0) { throw "non-positive" }
} catch {
    Write-Host "Invalid number entered. Exiting."
    exit 1
}

$cmd  = "C:\Programs\PwTech\pwtech.com"
$args = @("-profile", "Passphrase", "-gen", $num, "-readonly", "-silent")

# Execute pwtech
$output = & $cmd $args

if (-not $?) {
    Write-Host "Command execution failed."
    exit 1
}

# Split into lines and filter non-empty
$lines = $output -split "`r?`n" | Where-Object { $_.Trim().Length -gt 0 }

# Take the last N lines as passwords (avoids header/metadata off-by-one issues)
$passwords = $lines | Select-Object -Last $num

if (-not $passwords -or $passwords.Count -lt $num) {
    Write-Host "Warning: Expected $num passwords, found $($passwords.Count). Output format may have changed."
}

# Copy newline-separated passwords to clipboard
Set-Clipboard -Value ($passwords -join [Environment]::NewLine)

Write-Host "Generated $($passwords.Count) passwords and copied them to the clipboard."
