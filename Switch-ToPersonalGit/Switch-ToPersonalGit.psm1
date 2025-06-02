<#
.SYNOPSIS
Switch Git local user profile based on a .env file.

.DESCRIPTION
Loads GIT_NAME and GIT_EMAIL from a .env file and sets the local Git config.
With -Check switch, compares the .env values with current Git settings.

.PARAMETER EnvFile
Path to the .env file containing GIT_NAME and GIT_EMAIL.
Default: the .env file in the module folder.

.PARAMETER Check
Compare values in .env with current local Git config instead of applying them.

.EXAMPLE
Switch-ToPersonalGit
# Set user.name and user.email based on .env contents

.EXAMPLE
Switch-ToPersonalGit -Check
# Compare .env with current git config and display results

.EXAMPLE
Switch-ToPersonalGit -EnvFile 'C:\path\to\.env'
# Use a custom path for .env
#>
function Switch-ToPersonalGit {
    [Alias('spgit')]
    [CmdletBinding()]
    param(
        [string]$EnvFile = (Join-Path $PSScriptRoot '.env'),
        [switch]$Check
    )

    # prerequisites
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Error 'git command not found. Please install Git and retry.'
        return
    }
    if (-not (Test-Path -Path (Join-Path (Get-Location) '.git'))) {
        Write-Error 'Not inside a Git repository (no .git folder found).'
        return
    }
    if (-not (Test-Path -Path $EnvFile)) {
        Write-Error ".env file not found at path: $EnvFile"
        return
    }

    # load .env
    $envData = Get-Content $EnvFile -Raw |
    Select-String -NotMatch '^\s*#' |
    ConvertFrom-StringData
    $gitName = $envData['GIT_NAME']
    $gitEmail = $envData['GIT_EMAIL']
    if (-not $gitName -or -not $gitEmail) {
        Write-Error "GIT_NAME or GIT_EMAIL not defined in .env"
        return
    }

    # compare mode
    if ($Check) {
        $currentName = git config --local user.name
        $currentEmail = git config --local user.email

        if ($currentName -eq $gitName -and $currentEmail -eq $gitEmail) {
            Write-Host "✅ Git local config matches .env: $currentName <$currentEmail>"
        }
        else {
            Write-Warning "⚠️ Git local config differs from .env"
            Write-Host "  .env   : $gitName <$gitEmail>"
            Write-Host "  current: $currentName <$currentEmail>"
        }
        return
    }

    # apply profile
    git config --local user.name  $gitName
    git config --local user.email $gitEmail
    Write-Host "✅ Local Git profile set: $gitName <$gitEmail>"
}

Export-ModuleMember -Function 'Switch-ToPersonalGit' -Alias 'spgit'
