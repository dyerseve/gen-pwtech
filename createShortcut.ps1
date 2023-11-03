# Define the command and the "Start in" directory
$Command = "cmd.exe"
$CommandArguments = "/c `"$PSScriptRoot\genpass.bat`""  # Use backticks to escape the inner double quotes
$StartInDirectory = $PSScriptRoot  # Adjust this to the directory you want as the "Start in" field
$IconFile = "$PSScriptRoot\lock.ico"

# Create a shortcut object
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\genpass.lnk")

# Set the target command, "Start in" field, and custom icon (if needed)
$Shortcut.TargetPath = $Command
$Shortcut.Arguments = $CommandArguments
$Shortcut.WorkingDirectory = $StartInDirectory
$Shortcut.IconLocation = $IconFile  # Set custom icon if needed
$Shortcut.WindowStyle = 7  # 7 corresponds to "Minimized"

# Save the shortcut
$Shortcut.Save()

Write-Host "Shortcut created with the specified command and 'Start in' field."

# Clean up
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Shortcut) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($WshShell) | Out-Null
