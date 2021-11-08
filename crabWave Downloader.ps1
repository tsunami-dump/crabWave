$source = 'https://github.com/tsunami-dump/crabWave/raw/main/crabWave.dll'
$destination = '.\MelonLoader\mods\crabWave.dll'
$bepinex = '.\BepInEx\core\BepInEx.Core.dll'
$dlbepinex = 'https://github.com/tsunami-dump/crabWave/raw/main/bepinex.zip'
$dlmelon = 'https://github.com/tsunami-dump/crabWave/raw/main/bepinexmelon.zip'
$melon = '.\BepInEx\plugins\BepInEx.MelonLoader.Loader\MelonLoader.dll'
$crabgame = '.\Crab Game.exe'
$dlbepinextemp = '.\crabWave-temp\bepinex.zip'
$dlmelontemp = '.\crabWave-temp\melon.zip'
$currentfolder = '.\'
$temp = '.\crabWave-temp'

function Download {
   if ([System.IO.File]::Exists($crabgame)) {
      if ([System.IO.File]::Exists($bepinex)) { 
         if ([System.IO.File]::Exists($melon)) { 
            Write-Host "Downloading latest version of crabWave..." -fore blue
            Invoke-WebRequest -Uri $source -OutFile $destination
            Write-Host "Download crabWave done." -fore green
         }
         else { 
            Write-Host "BepInExMelonLoader not found." -fore red
            Write-Host "Downloading BepInExMelonLoader..." -fore blue
            New-Item -ItemType Directory -Force -Path $temp > $null
            Invoke-WebRequest -Uri $dlmelon -OutFile $dlmelontemp
            Write-Host "Download BepInExMelonLoader done." -fore green
            Write-Host "Extracting BepInExMelonLoader..." -fore blue
            Expand-Archive $dlmelontemp -DestinationPath $currentfolder -Force
            Write-Host "Extract BepInExMelonLoader done." -fore green
            Download
         }
      }
      else {
         Write-Host "BepInEx not found." -fore red
         Write-Host "Downloading BepInEx..." -fore blue
         New-Item -ItemType Directory -Force -Path $temp > $null
         Invoke-WebRequest -Uri $dlbepinex -OutFile $dlbepinextemp
         Write-Host "Download BepInEx done." -fore green
         Write-Host "Extracting BepInEx..." -fore blue
         Expand-Archive $dlbepinextemp -DestinationPath $currentfolder -Force
         Write-Host "Extract BepInEx done." -fore green
         Download
      }
   }
   else {
      Write-Host "Crab Game not found. Make sure you run this in the Crab Game folder." -fore red
   }
}

$host.UI.RawUI.WindowTitle = "crabWave by tsunami"
Download
Remove-Item $temp -Recurse -ErrorAction Ignore > $null
cmd /c 'echo.'
cmd /c 'pause'