# PostInstall
A small script to use right after installing Windows.

# Warning
**This script will uninstall all Microsoft Store (UWP) apps**.

But you have the option to reinstall the Microsoft Store and/or Xbox components.

# Usage
## Method 1
**After fully updating and restarting Windows**, open Powershell as Admin and run the following command:
```
irm cutt.ly/postinstall | iex
```

## Method 2
Alternatively, you could run this command if you want it to ask you for confirmation first:
```
irm cutt.ly/postinstall-confirmation | iex
```

This is especially useful if you want to add PostInstall to a script, like [VariousScripts](https://github.com/ShadowElixir/VariousScripts).

# Recommendations
## LibreWolf
### Install these extensions:
[CanvasBlocker](https://addons.mozilla.org/en-US/firefox/addon/canvasblocker/)

[Violentmonkey](https://addons.mozilla.org/en-US/firefox/addon/violentmonkey/)

[TWP - Translate Web Pages](https://addons.mozilla.org/en-US/firefox/addon/traduzir-paginas-web/)

[AB Download Manager Browser Integration](https://addons.mozilla.org/en-US/firefox/addon/ab-download-manager/)

## Brave
### Install these extensions:
[Linguist](https://chrome.google.com/webstore/detail/gbefmodhlophhakmoecijeppjblibmie)

[Violentmonkey](https://chrome.google.com/webstore/detail/violent-monkey/jinjaccalgkegednnccohejagnlnfdag)

[AB Download Manager Browser Integration](https://chromewebstore.google.com/detail/bbobopahenonfdgjgaleledndnnfhooj)
