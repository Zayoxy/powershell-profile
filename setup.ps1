$VerbosePreference = 'Continue'
$profileFile = "Microsoft.PowerShell_profile.ps1"
Clear-Host

# Handling Profile creation
try
{
    # If a Profile already exists, rename it to $PROFILE.old
    Write-Verbose "Testing if $PROFILE exists"
    if(Test-Path -Path $PROFILE)
    {
        Write-Verbose "$PROFILE found"
        Move-Item -Path $PROFILE -Destination "$($PROFILE).old"
        Write-Verbose "Moved $PROFILE to $($PROFILE).old"
    }
    else
    {
        Write-Verbose "$PROFILE not found"
    }

    # Windows PowerShell or PowerShell core
    switch ($PSVersionTable.PSEdition)
    {
        "Core"
        { 
            Write-Verbose "PowerShell core version"
            $profilePath = "PowerShell"
        }
        "Desktop"
        {
            Write-Verbose "Windows Powershell version"
            $profilePath = "WindowsPowerShell"
        }
        Default
        {
            Write-Host "Not on windows" -ForegroundColor Red
            $profilePath = $null
        }
    }
    
    # Creating a symlink to the new Profile if the path is not empty
    if ($null -ne $profilePath)
    {   
        # Checking if it's the VSCode Powershell extension profile
        if ($PROFILE.Contains("VSCode"))
        {
            $profileFile = "Microsoft.VSCode_profile.ps1"
        }
        
        New-Item -ItemType SymbolicLink -Name $profileFile -Path "$($env:USERPROFILE)\Documents\$($profilePath)" -Target "$($PWD)\Microsoft.PowerShell_profile.ps1" -ErrorAction Stop
        Write-Verbose "Created symlink at $PROFILE"
    }  
}
catch
{
    Write-Host $_.Exception.Message -ForegroundColor Red
}

try
{
    # Installing OhMyPosh for the prompt style
    winget install -e -s winget --id JanDeDobbeleer.OhMyPosh
    Write-Verbose "Installed OhMyPosh"

    # Installing Terminal Icons
    Install-Module -Name Terminal-Icons -Repository PSGallery
    Write-Verbose "Installed Terminal-Icons"
}
catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}

# Refresh the Profile
& $PROFILE