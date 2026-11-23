
# AMD Radeon Profile - Daemon

System daemon for reading info about Radeon GPU clocks and volts as well as control card power profiles so the GUI [`radeon-profile`](https://github.com/MaesterZ/radeon-profile) application can be run as normal user.

Supports opensource `xf86-video-ati` and `xf86-video-amdgpu` drivers.

**[2026-05] Forked to fix issues with latest GPUs and LTS kernel.**

# Dependencies

* Qt 6 (qt6-base) (On Debian/Ubuntu: `qt6-base-dev qmake6`)

# Build

```bash
./build.sh
```

Or manually:

```bash
cd radeon-profile-daemon/
qmake6
make
```

The resulting binary is `./radeon-profile-daemon/target/radeon-profile-daemon`.

# Installation

Will copy the binary to `/usr/local/bin/` and the [System service](./radeon-profile-daemon.service) to `/usr/lib/systemd/system/`.

```bash
./install.sh
```

# Links

* [radeon-profile](https://github.com/MaesterZ/radeon-profile) 
* Forum thread: http://phoronix.com/forums/showthread.php?83602-radeon-profile-tool-for-changing-profiles-and-monitoring-some-GPU-parameters
* Icons: http://proicons.deviantart.com/art/Graphics-Cards-Icons-H1-Pack-161178339
