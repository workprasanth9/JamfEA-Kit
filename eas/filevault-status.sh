#!/bin/bash
# EA-Name: FileVault Status
# EA-DataType: String
# EA-Description: FileVault state from fdesetup, for example FileVault is On.
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

status=$(/usr/bin/fdesetup status 2>/dev/null | /usr/bin/head -n 1 | /usr/bin/sed 's/\.$//')
echo "<result>${status:-Unknown}</result>"
