# Switch-ToPersonalGit

## Overview

This PowerShell script switches the local Git profile to a personal account.

## Installation

1. **Place the Script**
   Save the `Switch-ToPersonalGit` function in a `.ps1` file of your choice, or add it directly to your PowerShell profile (`$PROFILE`).

2. **Create a `.env` File**
   Create a `.env` file in the same directory as the script, with the following format:

   ```env
   # Lines starting with `#` are treated as comments
   GIT_NAME=Your Name
   GIT_EMAIL=your.name@example.com
   ```

## Usage

```powershell
# Run this from the root directory of a Git repository
Switch-ToPersonalGit        # or use the alias 'spgit'
```

If successful, you'll see a confirmation message like the following:

```text
✅ Local Git profile set: Your Name <your.name@example.com>
```

## Error Cases

| Situation               | Message                             | Solution                                    |
| ----------------------- | ----------------------------------- | ------------------------------------------- |
| Git is not installed    | `git command not found`             | Install Git and ensure it's in your PATH    |
| Not in a Git repository | `Not inside a Git repository`       | Run the script from a Git project root      |
| `.env` file is missing  | `.env file not found`               | Create the `.env` file                      |
| Variables not defined   | `GIT_NAME or GIT_EMAIL not defined` | Ensure both variables are defined in `.env` |
