#!/bin/bash
# EA-Name: Browser Versions
# EA-DataType: String
# EA-Description: Installed versions of Safari, Chrome, Firefox, Edge, and Brave.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

out=""
for entry in "Safari:/Applications/Safari.app" \
             "Chrome:/Applications/Google Chrome.app" \
             "Firefox:/Applications/Firefox.app" \
             "Edge:/Applications/Microsoft Edge.app" \
             "Brave:/Applications/Brave Browser.app"; do
  name="${entry%%:*}"
  app="${entry#*:}"
  if [ -f "$app/Contents/Info.plist" ]; then
    ver=$(/usr/bin/defaults read "$app/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)
    out="${out:+$out, }${name} ${ver:-unknown}"
  fi
done
echo "<result>${out:-None}</result>"
