# JamfEA-Kit

[![CI](https://github.com/workprasanth9/JamfEA-Kit/actions/workflows/ci.yml/badge.svg)](https://github.com/workprasanth9/JamfEA-Kit/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A polished, tested kit of **Jamf Pro Extension Attribute** scripts for Mac admins, plus `jamfea`, a small command line tool to list, run, validate, and export them.

Every EA is a standalone bash script that prints a single `<result>...</result>` line, carries its own metadata (name, data type, description), passes `shellcheck`, and is validated in CI on macOS.

## Install

**Homebrew**

```bash
brew tap workprasanth9/tap
brew trust workprasanth9/tap
brew install jamfea-kit
```

Homebrew 7 refuses to load formulae from a third party tap until you trust it, which is what `brew trust` does. Installing by the full name, `brew install workprasanth9/tap/jamfea-kit`, also works without that step, because naming the tap trusts that one formula.

**Installer package**

Download `JamfEA-Kit-1.0.0.pkg` from the [latest release](https://github.com/workprasanth9/JamfEA-Kit/releases/latest) and open it. It installs `jamfea` to `/usr/local/bin` and the EA scripts to `/usr/local/share/jamfea-kit/eas`. The package is unsigned, so if macOS blocks it, right click the file and choose Open.

**From source**

```bash
git clone https://github.com/workprasanth9/JamfEA-Kit.git
cd JamfEA-Kit
bin/jamfea list
```

## Extension Attributes

| ID | Name | Type | What it reports |
|----|------|------|-----------------|
| `battery-condition` | Battery Condition | String | Battery condition and maximum capacity from System Information, or No Battery. |
| `battery-cycle-count` | Battery Cycle Count | Integer | Battery cycle count reported by the AppleSmartBattery driver. Empty on Macs without a battery. |
| `bootstrap-token` | Bootstrap Token | String | Whether a Bootstrap Token is supported and escrowed to MDM. Needs root, which Jamf provides. |
| `browser-versions` | Browser Versions | String | Installed versions of Safari, Chrome, Firefox, Edge, and Brave. |
| `cpu-architecture` | CPU Architecture | String | Apple Silicon or Intel, with the chip name. |
| `disk-free-gb` | Disk Free Space GB | Integer | Free space in GB on the data volume. |
| `filevault-status` | FileVault Status | String | FileVault state from fdesetup, for example FileVault is On. |
| `firewall-status` | Firewall Status | String | Application Firewall global state: Enabled, Disabled, or Block All. |
| `gatekeeper-status` | Gatekeeper Status | String | Gatekeeper assessment state from spctl. |
| `homebrew-installed` | Homebrew Installed | String | Whether Homebrew is installed, where, and its version. Reads files only, never runs brew as root. |
| `last-reboot` | Last Reboot | Date | Date and time of the last boot in Jamf date format (YYYY-MM-DD hh:mm:ss). |
| `last-user-login` | Last User Login | String | Most recent console or remote login, excluding reboot and shutdown records. |
| `macos-version` | macOS Version | String | Product version and build, for example 15.1 (24B83). |
| `mdm-enrollment` | MDM Enrollment | String | MDM enrollment state, including whether enrollment was user approved or via DEP. |
| `pending-macos-updates` | Pending macOS Updates | Integer | Number of recommended software updates cached by softwareupdate. Fast, no network call. |
| `rosetta-installed` | Rosetta Installed | String | Whether Rosetta 2 is installed. Intel Macs report Not Applicable. |
| `secure-token-users` | Secure Token Users | String | Local accounts (UID 500 and up) that hold a Secure Token. |
| `sip-status` | SIP Status | String | System Integrity Protection state from csrutil. |
| `uptime-days` | Uptime Days | Integer | Whole days since the last boot. Handy for finding Macs that never restart. |

## Using jamfea

```bash
jamfea list                          # every EA with its type
jamfea info filevault-status         # metadata for one EA
jamfea run --all                     # run all EAs on this Mac
jamfea run uptime-days disk-free-gb  # run a few
jamfea validate                      # syntax, metadata, shellcheck, output format
jamfea export --format xml --out ~/Desktop/jamf-eas
jamfea export --format json > jamf-eas.json
```

Some EAs (for example `bootstrap-token` and `secure-token-users`) report more when run as root, which is how Jamf runs them. Use `sudo jamfea run --all` to see what Jamf will see.

## Uploading to Jamf Pro

**By hand (any Jamf Pro version)**

1. In Jamf Pro, go to **Settings > Computer management > Extension attributes** and click **New**.
2. Use the EA's **Name**, **Description**, and **Data Type** from the table above (or `jamfea info <id>`).
3. Set **Input Type** to **Script** and paste the contents of `eas/<id>.sh`.
4. Save. Values appear after the next inventory update (`sudo jamf recon`).

**Classic API (XML)**

```bash
jamfea export --format xml --out eas-xml
for f in eas-xml/*.xml; do
  curl -s -X POST "https://YOUR.jamfcloud.com/JSSResource/computerextensionattributes/id/0" \
    -H "Authorization: Bearer $TOKEN" -H "Content-Type: text/xml" --data-binary @"$f"
done
```

**Jamf Pro API (JSON)**

```bash
jamfea export --format json --out eas-json
for f in eas-json/*.json; do
  curl -s -X POST "https://YOUR.jamfcloud.com/api/v1/computer-extension-attributes" \
    -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" --data-binary @"$f"
done
```

Get `$TOKEN` from `POST /api/oauth/token` with an API client that has the Create Computer Extension Attributes privilege.

## Writing your own EA

Drop a new script into `eas/` with this header, then run `jamfea validate`:

```bash
#!/bin/bash
# EA-Name: My Custom Check
# EA-DataType: String        # String, Integer, or Date
# EA-Description: One line that explains what this reports.

echo "<result>something</result>"
```

Integer EAs must print a whole number (or nothing). Date EAs must use `YYYY-MM-DD hh:mm:ss`.

## Contributing

Issues and pull requests are welcome, especially new EAs that Mac admins use every day.

## Support the project

If JamfEA-Kit saves you time, please **star the repo** and **share it with a Mac admin friend**.

## License

MIT, see [LICENSE](LICENSE).
