#!/bin/bash
# Build dist/JamfEA-Kit-<version>.pkg. Installs jamfea to /usr/local/bin and
# the EA scripts to /usr/local/share/jamfea-kit/eas.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VERSION="$("$ROOT/bin/jamfea" version | awk '{print $2}')"
DIST="$ROOT/dist"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

mkdir -p "$STAGE/root/usr/local/bin" "$STAGE/root/usr/local/share/jamfea-kit" "$DIST"
cp "$ROOT/bin/jamfea" "$STAGE/root/usr/local/bin/jamfea"
cp -R "$ROOT/eas" "$STAGE/root/usr/local/share/jamfea-kit/eas"
cp "$ROOT/LICENSE" "$ROOT/README.md" "$STAGE/root/usr/local/share/jamfea-kit/"
"$ROOT/bin/jamfea" export --format xml --out "$STAGE/root/usr/local/share/jamfea-kit/export/xml" >/dev/null
"$ROOT/bin/jamfea" export --format json --out "$STAGE/root/usr/local/share/jamfea-kit/export/json" >/dev/null
chmod 755 "$STAGE/root/usr/local/bin/jamfea" "$STAGE/root/usr/local/share/jamfea-kit/eas/"*.sh
xattr -cr "$STAGE/root" 2>/dev/null || true
find "$STAGE/root" -name "._*" -delete
export COPYFILE_DISABLE=1

pkgbuild --root "$STAGE/root" \
  --identifier io.github.workprasanth9.jamfea-kit \
  --version "$VERSION" \
  --install-location / \
  "$STAGE/component.pkg"

sed "s/@VERSION@/$VERSION/g" "$ROOT/pkg/distribution.xml" > "$STAGE/distribution.xml"
productbuild --distribution "$STAGE/distribution.xml" \
  --resources "$ROOT/pkg/resources" \
  --package-path "$STAGE" \
  "$DIST/JamfEA-Kit-$VERSION.pkg"

echo "Built $DIST/JamfEA-Kit-$VERSION.pkg"
