#!/bin/sh
set -e

echo "🎮 Running Open Orbis Toolchain Action!"

if [ "$INPUT_VERSION" = "latest" ]
then
  LATEST_VERSION="$(curl -sL "https://api.github.com/repos/OpenOrbis/OpenOrbis-PS4-Toolchain/releases/latest" | \
    grep -Po '"tag_name": "\K.*?(?=")')"
  export INPUT_VERSION=$LATEST_VERSION
fi

if [ ! -f "/tmp/toolchain-cache/$INPUT_VERSION.tar.gz" ]
then
  echo "⬇️ Toolchain release $INPUT_VERSION not cached, downloading..."
  curl -sL "https://github.com/OpenOrbis/OpenOrbis-PS4-Toolchain/releases/download/$INPUT_VERSION/$INPUT_VERSION.tar.gz" -o "/tmp/toolchain-cache/$INPUT_VERSION.tar.gz"
  echo "👌 Downloaded toolchain release to \"/tmp/toolchain-cache/$INPUT_VERSION.tar.gz\""
else
  echo "♻️ Toolchain release $INPUT_VERSION was already cached at \"/tmp/toolchain-cache/$INPUT_VERSION.tar.gz\""
fi

echo "📁 Extracting \"/tmp/toolchain-cache/$INPUT_VERSION.tar.gz\" to \"$OO_PS4_TOOLCHAIN\""
tar -xzf "/tmp/toolchain-cache/$INPUT_VERSION.tar.gz" -C "$OO_PS4_TOOLCHAIN" bin/data bin/linux include lib scripts link.x
echo "👌 Extracted \"/tmp/toolchain-cache/$INPUT_VERSION.tar.gz\" to \"$OO_PS4_TOOLCHAIN\""

export OO_TOOLCHAIN_VERSION=$INPUT_VERSION

echo "🏃 Executing command \"$INPUT_COMMAND\""
sh -ec "$INPUT_COMMAND"
echo "💯 Done executing command!"
