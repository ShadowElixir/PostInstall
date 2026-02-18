# PostInstall
A small script to use right after installing Windows.

# Usage
### Method 1
**After fully updating and restarting Windows**, open Powershell as Admin and run the following command:
```
irm cutt.ly/postinstall | iex
```

### Method 2
Alternatively, you could run this command if you want it to ask you for confirmation first:
```
irm cutt.ly/postinstall-confirmation | iex
```

This is especially useful if you want to add PostInstall to a script, like [VariousScripts](https://github.com/ShadowElixir/VariousScripts).
