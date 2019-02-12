#!/bin/bash

set -eu -o pipefail

if [ $# -ne 1 ]
then
  echo "Usage: $0 <output directory>" >&2
  exit 1
fi

OUTDIR="$1"
GIT_VERSION="$(git --version | awk '{print $3}')"

mkdir -p "${OUTDIR}"
pushd "${OUTDIR}" > /dev/null
for f in git-completion.bash git-prompt.sh
do
    (
      set -x
      curl -f "https://raw.githubusercontent.com/git/git/v${GIT_VERSION}/contrib/completion/${f}" > "${f}"
    )
done
popd > /dev/null
