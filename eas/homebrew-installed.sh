#!/bin/bash
# EA-Name: Homebrew Installed
# EA-DataType: String
# EA-Description: Whether Homebrew is installed, where, and its version. Reads files only, never runs brew as root.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

for prefix in /opt/homebrew /usr/local; do
  if [ -x "$prefix/bin/brew" ]; then
    repo="$prefix"
    [ -d "$prefix/Homebrew/.git" ] && repo="$prefix/Homebrew"
    ver=$(/usr/bin/git -C "$repo" describe --tags --abbrev=0 2>/dev/null)
    echo "<result>Installed ${ver:-unknown version} at $prefix</result>"
    exit 0
  fi
done
echo "<result>Not Installed</result>"
