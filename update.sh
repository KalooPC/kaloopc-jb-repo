#!/bin/bash
# Rebuilds the APT index for the KalooPC JB repo. Run from WSL.
# Usage: bash update.sh   (run inside the repo root)
set -e
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"
echo "== repo: $REPO_DIR"

# 1. sanity: expected symbols inside shipped debs
for DEB in debs/*.deb; do
  TMPD=$(mktemp -d)
  dpkg-deb -x "$DEB" "$TMPD"
  DYLIB=$(find "$TMPD" -name Zen.dylib | head -1)
  echo "-- $DEB -> $DYLIB"
  echo "-- FLEXManager refs: $(strings "$DYLIB" | grep -c FLEXManager)"
  rm -rf "$TMPD"
done

# 2. Packages index
if ! command -v dpkg-scanpackages >/dev/null 2>&1; then
  sudo apt-get install -y dpkg-dev
fi
dpkg-scanpackages --arch iphoneos-arm64 debs /dev/null > Packages 2>/dev/null || dpkg-scanpackages debs /dev/null > Packages
gzip -kf Packages
xz -kf Packages
bzip2 -kf Packages
if command -v zstd >/dev/null 2>&1; then zstd -kf Packages; fi
echo "-- index files:"; ls -la Packages* debs/

# 3. Release file
python3 - "$REPO_DIR" <<'EOF'
import hashlib, os, sys, time
root = sys.argv[1]
files = ['Packages', 'Packages.gz', 'Packages.bz2', 'Packages.xz']
if os.path.exists(os.path.join(root, 'Packages.zst')):
    files.append('Packages.zst')
for dp in sorted(os.listdir(os.path.join(root, 'debs'))):
    if dp.endswith('.deb'):
        files.append('debs/' + dp)
def h(algo, path):
    hh = hashlib.new(algo)
    with open(os.path.join(root, path), 'rb') as f:
        for b in iter(lambda: f.read(1 << 20), b''):
            hh.update(b)
    return hh.hexdigest()
entries = [(p, os.path.getsize(os.path.join(root, p))) for p in files]
with open(os.path.join(root, 'Release'), 'w') as f:
    f.write('Origin: KalooPC\'s Repo\nLabel: KalooPC\'s Repo\nSuite: stable\nVersion: 1.0\nCodename: ios\nArchitectures: iphoneos-arm iphoneos-arm64\nComponents: main\nDescription: KalooPC\'s repo for Jailbreak\nDate: %s\n' % time.strftime('%a, %d %b %Y %H:%M:%S UTC', time.gmtime()))
    for algo, name in (('md5', 'MD5Sum'), ('sha1', 'SHA1'), ('sha256', 'SHA256')):
        f.write('%s:\n' % name)
        for p, sz in entries:
            f.write(' %s %16d %s\n' % (h(algo, p), sz, p))
print('Release written')
EOF
echo OK
