
#!/bin/sh
current_dir="$(pwd)"
bazelisk_dir="$(git rev-parse --show-toplevel)/tools/bazelisk"

if [ "$current_dir" != "$bazelisk_dir" ]; then
  echo "This script should be run from $REPO/tools/bazelisk directory"
  exit 1
fi

for BAZELISK_EXECUTABLE in bazelisk-darwin-amd64 bazelisk-darwin-arm64; do
  BAZELISK_URL="https://github.com/bazelbuild/bazelisk/releases/latest/download/$BAZELISK_EXECUTABLE"
  echo "curl -OL $BAZELISK_URL"
  curl -OL $BAZELISK_URL
  echo "making $BAZELISK_EXECUTABLE executable"
  chmod +x $BAZELISK_EXECUTABLE
  if [ $BAZELISK_EXECUTABLE == "bazelisk-darwin-*" ]; then
    echo "adding extended com.apple.quarantine attribute to $BAZELISK_EXECUTABLE"
    xattr -d com.apple.quarantine $BAZELISK_EXECUTABLE
  fi
done

