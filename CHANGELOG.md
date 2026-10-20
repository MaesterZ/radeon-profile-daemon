# [2026-10-20]

## Port to Qt 6

Qt 5 is end of life. The daemon now builds with Qt 6 (`qmake6`, C++17); no source change was
needed. Shared memory keys are compatible: a Qt 6 GUI creates the same System V segment and
`/tmp/qipc_sharedmemory_*` key file as a Qt 5 one.

### `radeon-profile-daemon.service` — Remove `PrivateTmp`

`PrivateTmp=true` gave the daemon its own `/tmp`, but the GUI creates the shared memory key file
there and reads the debugfs clocks copy from it. With it, the daemon could never attach to the
shared memory (`QSharedMemory::handle:: UNIX key file doesn't exist`), so clocks read through
the daemon were missing.

### Version

Version bumped to `20261020`.

# [2026-05-12]

## Linux 6.18 LTS compatibility fixes

### `radeon-profile-daemon/rpdthread.cpp` — Replace `system("cp ...")` with `QFile::copy()`

The daemon runs as root and was using `system()` to copy the debugfs clock file into
`/tmp/`. Replaced with `QFile::remove()` + `QFile::copy()` to avoid shell execution
as root and correctly handle the case where the destination file already exists.

### `radeon-profile-daemon/rpdthread.cpp` — Tolerate missing `amdgpu_pm_info` in debugfs

On kernel 6.x with RDNA2 GPUs, `/sys/kernel/debug/dri/<N>/amdgpu_pm_info` is often
absent. The daemon's `configure()` was returning `false` and aborting the entire setup
when this file was not found, which prevented `configureSharedMem()` from running and
caused `QSharedMemory::handle:: key is empty` log spam.

Changed to log a warning and return `true` instead. The client (`radeon-profile`) falls
back to the ioctl path for clock data when the pm_info file is unavailable, so the
daemon does not need to fail hard here.

### `radeon-profile-daemon/rpdthread.cpp` — Guard `readData()` against empty clock path

Added an early return in `readData()` when `clocksDataPath` is empty (i.e. the pm_info
file was not configured because it doesn't exist on this kernel). Eliminates the
repeated `Shared memory is not attached, can't write data` warnings that appeared
whenever the daemon timer fired before a valid path was established.

## Build system cleanup

### `radeon-profile-daemon.pro` — Fix broken service file install path (bug fix)

`service.files` pointed to `extra/radeon-profile-daemon.service` but that subdirectory
does not exist. The file lives at the repo root, so the path is corrected to
`../radeon-profile-daemon.service`. `make install` would have silently skipped the
service file before this fix.

### `radeon-profile-daemon.pro` — Use `CONFIG += c++11` instead of raw `QMAKE_CXXFLAGS`

Replaced `QMAKE_CXXFLAGS += -std=c++11` with `CONFIG += c++11` so the directive
applies to both the compiler and Qt's MOC.

### `radeon-profile-daemon.pro` — Add debug warnings, clean up formatting

Added `CONFIG += warn_on` + `-Wextra -Wpedantic` for debug builds (matching the main
project). Fixed inconsistent `DESTDIR= target` spacing and removed the stale QtCreator
boilerplate header and trailing whitespace.
