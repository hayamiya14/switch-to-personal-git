# Switch-ToPersonalGit

## Overview

This PowerShell script switches the local Git profile to a personal account.

## Installation

1. **Place the Script**

   - Save the `Switch-ToPersonalGit.psm1` file in a directory of your choice.
   - Optionally, you can install it as a module by placing both `Switch-ToPersonalGit.psm1` and `Switch-ToPersonalGit.psd1` under a folder named `Switch-ToPersonalGit` in one of your PowerShell module paths (e.g., `C:\Program Files\WindowsPowerShell\Modules\Switch-ToPersonalGit\`).

2. **Import the Module**

   ```powershell
   Import-Module Switch-ToPersonalGit
   ```

3. **Create a `.env` File**

   Create a `.env` file in the same directory as the script, with the following format:

   ```env
   # Lines starting with `#` are treated as comments
   GIT_NAME=Your Name
   GIT_EMAIL=your.name@example.com
   ```

## Parameters

- `EnvFile <string>`
  Path to the .env file. Defaults to the .env file located in the module directory.

- `Check`
  Compares the values in .env with the current local Git config (user.name and user.email).

  - If all match, displays a success message.
  - If they differ, shows the differences without modifying Git config.

## Usage

```powershell
# 1. Switch local Git profile to values in .env (default behavior)
Switch-ToPersonalGit

# 2. Run in "check" mode (just compare, do not apply)
Switch-ToPersonalGit -Check

# 3. Use a custom path for .env
Switch-ToPersonalGit -EnvFile 'C:\path\to\project\.env'

# 4. Combine both parameters if you want to compare against a custom .env
Switch-ToPersonalGit -EnvFile 'C:\path\to\project\.env' -Check
```

## Error Cases

| Situation               | Message                             | Solution                                    |
| ----------------------- | ----------------------------------- | ------------------------------------------- |
| Git is not installed    | `git command not found`             | Install Git and ensure it's in your PATH    |
| Not in a Git repository | `Not inside a Git repository`       | Run the script from a Git project root      |
| `.env` file is missing  | `.env file not found`               | Create the `.env` file                      |
| Variables not defined   | `GIT_NAME or GIT_EMAIL not defined` | Ensure both variables are defined in `.env` |
