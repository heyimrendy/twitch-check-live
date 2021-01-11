# twitch-check-live
Check followed channels live on Twitch from terminal.

**WARNING: User OAuth token and unofficial API usage are discouraged. Use at your own risk!**

# Requirements
This script require Powershell 7 for ternary operator. If you wish to use older Powershell, edit line 34.

# Preview
![](https://i.nuuls.com/DVHPJ.png)


# Get Started
Setting up is extremely easy. Edit line 1 of `twitch-live.ps1` and add user OAuth token.

### Tips
1. By default max channels set to 50. Edit line 2 if you prefer custom. Value between 1-50 to mimic the website.
2. Custom User-Agent in line 3. Check https://www.whatismybrowser.com/guides/the-latest-user-agent/ for generic User-Agent.
3. Don't execute the script too frequent, might raise detection by Twitch.