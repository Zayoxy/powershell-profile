# Aliases

# Refresh this file in the current PowerShell terminal
function refreshProfile { & $PROFILE }

function ll { Get-ChildItem }

function df { Get-Volume }

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# oh-my-posh prompt
oh-my-posh init pwsh --config "$HOME\AppData\Local\Programs\oh-my-posh\themes\lambdageneration.omp.json" | Invoke-Expression

# Terminal icons (Need to be installed beforehand)
Import-Module -Name Terminal-Icons
