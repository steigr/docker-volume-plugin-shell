Docker Volume Plugin Shell
==========================

Usage/Development
-----------------

1. Create a Dockerfile, e.g.:
   ```
FROM steigr/docker-volume-plugin-shell
ADD  handler /handler
ENV  DRIVER_NAME mydriver
```

2. Add a script for every Action inside /handler and make them executable.
  - `/handler/Plugin.Activate`
  - `/handler/VolumeDriver.Capabilities`
  - `/handler/VolumeDriver.Create`
  - `/handler/VolumeDriver.Get`
  - `/handler/VolumeDriver.List`
  - `/handler/VolumeDriver.Mount`
  - `/handler/VolumeDriver.Path`
  - `/handler/VolumeDriver.Remove`
  - `/handler/VolumeDriver.Unmount`
  It should be easy to support Network and/or authz plugins.

3. Write well-formed JSON to STDOUT, documented here: https://docs.docker.com/engine/extend/plugins_volume/

4. Each request parameters are normalized into the script environment:

  Request:
  ```
{ "Name": "volume_name", "Opts": {"fstype": "ext4", "mountopts":["discard","nosuid"]} }
```

  Environment:
  ```
VOLUMEDRIVER_NAME='volume_name'
VOLUMEDRIVER_OPTS_FSTYPE='ext4'
VOLUMEDRIVER_OPTS_MOUNTOPTS_0='discard'
VOLUMEDRIVER_OPTS_MOUNTOPTS_1='nosuid'
```