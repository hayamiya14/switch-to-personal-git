function Switch-ToPersonalGit {
    [Alias("spgit")]
    [CmdletBinding()]
    param(
        [string]$EnvFile = (Join-Path $PSScriptRoot '.env')
    )

    #--- Checks ----------------------------------------------------------------
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Error 'git command not found. Please install Git and retry.'
        Return
    }
    if (-not (Test-Path -LiteralPath '.git')) {
        Write-Error 'Not inside a Git repository (no .git folder found).'
        Return
    }
    if (-not (Test-Path -LiteralPath $EnvFile)) {
        Write-Error ".env file not found at $EnvFile"
        Return
    }

    #--- Load .env --------------------------------------------------------------
    # Expecting in the same folder as this script a file named ".env"
    # containing lines like:
    #   GIT_NAME=test
    #   GIT_EMAIL=test@example.com

    $envData = Get-Content $EnvFile -Raw |
               Select-String -NotMatch '^\s*#' |
               ConvertFrom-StringData

    $gitName  = $envData['GIT_NAME']
    $gitEmail = $envData['GIT_EMAIL']

    if (-not $gitName -or -not $gitEmail) {
        Write-Error "GIT_NAME or GIT_EMAIL not defined in .env"
        Return
    }

    #--- Apply profile ---------------------------------------------------------
    git config --local user.name $gitName
    git config --local user.email $gitEmail

    Write-Host "✅ Local Git profile set: $gitName <$gitEmail>"
}
