#!/bin/bash
set -euo pipefail

pushd ./radeon-profile-daemon/

# Full clean: removes generated Makefile, object files, moc output, and target binary
[[ -f Makefile ]] && make distclean

qmake6
make -j$(nproc)

popd
