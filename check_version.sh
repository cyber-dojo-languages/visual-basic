#!/usr/bin/env bash
set -Eeu

readonly REGEX="image_name\": \"(.*)\""
readonly JSON=`cat docker/image_name.json`
[[ ${JSON} =~ ${REGEX} ]]
readonly IMAGE_NAME="${BASH_REMATCH[1]}"

readonly MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly EXPECTED=10.0.103
readonly ACTUAL=$(docker run --rm -i ${IMAGE_NAME} sh -c 'dotnet --version')

if echo "${ACTUAL}" | grep -q "${EXPECTED}"; then
  echo "VERSION CONFIRMED as ${EXPECTED}"
else
  echo "VERSION EXPECTED: ${EXPECTED}"
  echo "VERSION   ACTUAL: ${ACTUAL}"
  exit 42
fi

# The SDK version alone does not prove the Visual Basic compiler ships in it,
# which is the whole point of this image.
readonly VBC=$(docker run --rm -i ${IMAGE_NAME} sh -c "ls /usr/share/dotnet/sdk/${EXPECTED}/Roslyn/bincore/vbc.dll")

if [ "${VBC}" == "/usr/share/dotnet/sdk/${EXPECTED}/Roslyn/bincore/vbc.dll" ]; then
  echo "VB COMPILER CONFIRMED at ${VBC}"
else
  echo "VB COMPILER NOT FOUND"
  exit 42
fi
