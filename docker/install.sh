#!/bin/sh -eu

# Records the VisualBasic this image holds, in the shape every image shares.
# The version is the language's, not the SDK's: the SDK's own VB compiler
# lists the language versions it accepts and marks the one it compiles to by
# default, as in "17.13 (default)". So the version is one the image compiles
# to rather than one written down when someone last edited this file.
readonly VBC=$(ls /usr/share/dotnet/sdk/*/Roslyn/bincore/vbc.dll)
readonly LANGUAGE_VERSION=$(dotnet "${VBC}" -langversion:? | grep -i '(default)' | cut -d' ' -f1)

if [ -z "${LANGUAGE_VERSION}" ]; then
  echo 'Could not read a default version from vbc -langversion:?' >&2
  exit 1
fi

cat > /versions.json <<EOF
{
  "language": {
    "name": "VisualBasic",
    "version": "${LANGUAGE_VERSION}"
  },
  "test_frameworks": []
}
EOF
