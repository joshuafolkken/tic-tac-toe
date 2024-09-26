#!/bin/bash

# Set Git configuration
git config --global user.name "$GITHUB_ACTOR"
git config --global user.email "$GITHUB_ACTOR@users.noreply.github.com"

# Move to the project root
cd "$(git rev-parse --show-toplevel)" || exit

# Extract version from project.godot
VERSION=v$(grep 'config/version=' project.godot | cut -d'=' -f2 | tr -d '"')
echo "VERSION: $VERSION"

# Get the latest tag
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
echo "LATEST_TAG: $LATEST_TAG"

# Create a new tag if the version has changed
if [ "$VERSION" = "$LATEST_TAG" ]; then
  echo "Version unchanged. No new tag will be created."
  exit 0
fi

if ! git tag -a "$VERSION" -m "Release $VERSION"; then
  echo "Failed to create tag $VERSION"
  exit 0
fi

if ! git push origin "$VERSION"; then
  echo "Failed to push tag $VERSION"
  exit 0
fi

echo "Created and pushed new tag $VERSION"
