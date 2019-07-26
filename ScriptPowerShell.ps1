mount-diskimage -imagepath $PSScriptRoot\Programas\SW_DVD5_Office_Professional_Plus_2016_64Bit_Spanish_MLF_X20-42457.ISO -storagetype iso -passthru | Get-Volume
$driveLetter = (Get-DiskImage $PSScriptRoot\Programas\SW_DVD5_Office_Professional_Plus_2016_64Bit_Spanish_MLF_X20-42457.ISO | Get-Volume).DriveLetter
invoke-item "$($driveLetter):\install.exe"
