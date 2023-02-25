$VerbosePreference = 'Continue'

# Handling Profile creation
try
{
    # If a Profile already exists, rename it to $PROFILE.old
    Write-Verbose "Testing if $PROFILE exists"
    if(Test-Path -Path $PROFILE)
    {
        Write-Verbose "$PROFILE found"
        Move-Item -Path $PROFILE -Destination "$PROFILE.old"
        Write-Verbose "Moved $PROFILE to $PROFILE.old"
    }

    # Creating a symlink to the new Profile
    New-Item -Name $PROFILE -ItemType SymbolicLink -Target .\Microsoft.PowerShell_profile.ps1
    Write-Verbose "Created symlink at $PROFILE"

    # Installing OhMyPosh for the prompt style
    winget install --id JanDeDobbeleer.OhMyPosh -e

    # Installing Terminal Icons
    Install-Module -Name Terminal-Icons -Repository PSGallery
}
catch
{
    Write-Host $_.Exception.Message -ForegroundColor Red
}