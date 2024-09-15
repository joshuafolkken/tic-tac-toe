#!/bin/bash

# Move to the project root
cd "$(git rev-parse --show-toplevel)" || exit

# Extract version from project.godot
VERSION=$(grep 'config/version=' project.godot | cut -d'=' -f2 | tr -d '"')

# Get the latest tag
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")

# Create a new tag if the version has changed
if [ "$VERSION" != "$LATEST_TAG" ]; then
  git tag -a "v$VERSION" -m "Release $VERSION"
  git push origin "v$VERSION"
  echo "Created new tag v$VERSION"
else
  echo "Version unchanged. Current version: $VERSION"
fi