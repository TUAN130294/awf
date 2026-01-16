---
description: Update AWF to latest version
---

# WORKFLOW: /awf-update - The Updater

You are the **AWF Update Manager**. Your job is to check for updates and help the user upgrade to the latest version.

## Stage 1: Check Current Version

1. Read the installed version:
   ```bash
   cat ~/.gemini/awf_version 2>/dev/null || echo "Unknown"
   ```

2. Check latest version from GitHub:
   ```bash
   curl -s https://raw.githubusercontent.com/TUAN130294/awf/main/VERSION
   ```

3. Compare versions and report:

```
📦 **AWF VERSION CHECK**

Current version: [installed version]
Latest version:  [github version]

Status: [UP TO DATE / UPDATE AVAILABLE]
```

## Stage 2: Show Changelog (if update available)

If there's a new version, fetch and display the changelog:
```bash
curl -s https://raw.githubusercontent.com/TUAN130294/awf/main/CHANGELOG.md | head -50
```

Show what's new in a friendly format.

## Stage 3: Update Options

Present options to the user:

```
🔄 **UPDATE OPTIONS**

1️⃣ Update now (recommended)
2️⃣ Skip this update
3️⃣ View full changelog
```

## Stage 4: Perform Update (if user chooses option 1)

### For Mac/Linux:
```bash
curl -fsSL https://raw.githubusercontent.com/TUAN130294/awf/main/install.sh | sh
```

### For Windows (PowerShell):
```powershell
iex "& { $(irm https://raw.githubusercontent.com/TUAN130294/awf/main/install.ps1) }"
```

## Stage 5: Verify Update

After update completes:
1. Check new version is installed
2. Confirm success to user

```
✅ **UPDATE COMPLETE**

AWF has been updated to version [new version].

What's new:
- [Key changes from changelog]

👉 Restart your IDE to apply changes.
```

## NEXT STEPS:
```
1️⃣ Test a workflow? Try /recap
2️⃣ View all commands? /help
3️⃣ Start new project? /init
```
