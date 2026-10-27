#!/bin/bash
# EA-Name: macOS Version
# EA-DataType: String
# EA-Description: Product version and build, for example 15.1 (24B83).
# Part of JamfEA-Kit: https://github.com/workprasanth9/JamfEA-Kit

echo "<result>$(/usr/bin/sw_vers -productVersion) ($(/usr/bin/sw_vers -buildVersion))</result>"
