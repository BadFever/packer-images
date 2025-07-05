$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'

#region cleanup temp folders
Write-Host "Removing temp folders"
$TempFolders = @("C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:\Documents and Settings\*\Local Settings\temp\*", "C:\Users\*\Appdata\Local\Temp\*")
Remove-Item $TempFolders -ErrorAction SilentlyContinue -Force -Recurse
#endregion cleanup temp folders

#region cleanup windows updates
Write-Host "Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase"
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
Write-Host "Finished dism"

exit 0