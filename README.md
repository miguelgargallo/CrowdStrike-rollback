<p align="center">
  <img src=".assets/icon.png" alt="icon" width="100"/>
</p>

<p align="center">
  <a href="https://github.com/miguelgargallo/CrowdStrike-rollback">
    <img alt="GitHub stars" src="https://img.shields.io/github/stars/miguelgargallo/CrowdStrike-rollback?style=social">
  </a>
  <a href="https://github.com/miguelgargallo/CrowdStrike-rollback">
    <img alt="GitHub forks" src="https://img.shields.io/github/forks/miguelgargallo/CrowdStrike-rollback?style=social">
  </a>
</p>

# CrowdStrike-rollback
## Description
CrowdStrike-rollback.ps1 is a PowerShell script designed to automate the removal of a specific file related to CrowdStrike that may be causing issues on your Windows system. This script should be executed in Safe Mode or the Windows Recovery Environment.

## Issue with CrowdStrike
CrowdStrike is a security solution that protects endpoints against threats. However, certain CrowdStrike files may become corrupted or cause issues that prevent the system from functioning correctly. Specifically, a file named `C-00000291*.sys` in the `C:\Windows\System32\drivers\CrowdStrike` directory needs to be removed to resolve the problem.

## Usage Instructions

### Step 1: Preparation
- Ensure you have administrator permissions on the system where the script will be run.
- Save the script as `CrowdStrike-rollback.ps1`.

### Step 2: Boot into Safe Mode
1. Restart the system and enter Safe Mode or the Windows Recovery Environment.
2. To enter Safe Mode, hold down the **Shift** key while clicking "Restart" and then select:
   - "Troubleshoot"
   - "Advanced options"
   - "Startup Settings"
   - "Restart"
   - Select the option for Safe Mode.
3. To enter the Windows Recovery Environment, follow a similar process and select:
   - "Troubleshoot"
   - "Advanced options"
   - "Command Prompt".

### Step 3: Run the Script
1. Open PowerShell with administrator privileges.
2. Navigate to the directory where the script was saved.
3. Execute the script with the following command:

   ```powershell
   .\CrowdStrike-rollback.ps1
   ```

This should help automate the process of resolving the issue.
