#!/bin/bash
# EA-Name: Pending macOS Updates
# EA-DataType: Integer
# EA-Description: Number of recommended software updates cached by softwareupdate. Fast, no network call.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

count=$(/usr/bin/defaults read /Library/Preferences/com.apple.SoftwareUpdate LastRecommendedUpdatesAvailable 2>/dev/null)
echo "<result>${count:-0}</result>"
